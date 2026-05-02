#!/bin/bash

CWD=$(pwd)
BARE_REPO=false
CONFIG_DIR="/etc/project-configurator"

# Default container configuration name
CONTAINERS_DIR="/etc/containers"
CONTAINER_NAME="generic-dev"
CONTAINER=${CONTAINERS_DIR}/${CONTAINER_NAME}

ask_confirmation() {
    read -p "$1 (y/n) " answer
    case $answer in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Please answer y or n."; ask_confirmation "$1";;
    esac
}

print_help() {
    echo ""
    echo "Usage:            $0 <options> <configuration>"
    echo "Options:"
    echo "                  --bare, -b                  Initializes a bare repository without creating additional files or directories."
    echo "                  --help, -h                  Displays this help message."
    echo ""
    echo "Configurations:"
    echo "                  docker <container_name>     Initializes a repository with a Docker container."
    echo "                  python                      Initializes a repository with Python configuration."
    echo "                  cpp                         Initializes a repository with C++ configuration."
    echo "                  bash                        Initializes a repository with Bash configuration."
    echo "                  ia                          Initializes a repository with AI configuration."
    echo ""
}

bare_init() {
    if [ ! -f README.md ]; then
        touch README.md
    fi

    if [ ! -f .gitignore ]; then
        bash -c "cat <<'EOL' > .gitignore
node_modules/
.env
dist/
build/
__pycache__/
.DS_Store
EOL"
    fi

    if [ ! -d .git ]; then
        git init
        git add -A
        git commit -m "Initial commit"
        git checkout -b develop
    else
        echo "> GIT repository already exists. Skipping GIT initialization."
    fi
    echo ""
    echo "> Repository initialized successfully."
    echo ""
}

init() {
    mkdir -p src tests docs lib
    bare_init
}

init_git() {
    if [ ${BARE_REPO} = false ]; then
        init
    else
        bare_init
    fi
}

init_docker() {
    local container_name="${1:-dev-container}"
    if [ -d "${container_name}" ]; then
        ask_confirmation "A ${container_name} directory already exists. Do you want to overwrite its contents?"
        if [ $? -eq 0 ]; then
            rm -rf ${container_name}/
            cp -r ${CONTAINER} ${container_name}
            cp  ${CONTAINERS_DIR}/starter .
        else
            echo "Skipping Docker configuration."
        fi
    else
        cp -r ${CONTAINER} ${container_name}
        cp  ${CONTAINERS_DIR}/starter .
    fi
    echo "> To deploy the container use the following command:"
    echo ""
    ./starter -h

    init_git
}

cd ${CWD}

if [ $# -eq 0 ]; then
    init
    exit 0
fi

if [ $# -eq 1 ]; then
    if [ "$1" == "--bare" ] || [ "$1" == "-b" ]; then
        BARE_REPO=true 
        bare_init
        exit 0
    fi
fi

while [[ $# -gt 0 ]]; do
    case "$1" in
        -b|--bare)
            BARE_REPO=true
            shift
            ;;
        -h|--help)
            print_help
            exit 0
            ;;
        docker)
            init_docker $2
            if [ -n "$2" ]; then
                shift 2
            else
                shift
            fi
            ;;
        python)
            shift
            ;;
        cpp)
            shift
            ;;
        bash)
            shift
            ;;
        ia)
            shift
            ;;
        *)
            print_help
            exit 1
            ;;
    esac
done
