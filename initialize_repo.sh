#!/bin/bash

CWD=$(pwd)
BARE_REPO=false
CONFIG_REPO="/etc/project-configurator"

ask_confirmation() {
    read -p "$1 (y/n) " answer
    case $answer in
        [Yy]* ) return 0;;
        [Nn]* ) return 1;;
        * ) echo "Please answer y or n."; ask_confirmation "$1";;
    esac
}

print_help() {
    echo "Usage:   $0 <options>"
    echo "Options:  --bare, -b       Initialize a bare repository without creating additional files or directories."
    echo "          --help, -h       Display this help message."
    echo "          docker           Initialize a repository with Docker configuration."
    echo "          python           Initialize a repository with Python configuration."
    echo "          cpp              Initialize a repository with C++ configuration."
    echo "          bash             Initialize a repository with Bash configuration."
    echo "          ia               Initialize a repository with AI configuration."
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
    if [ -d "dev-container" ]; then
        ask_confirmation "A dev-container directory already exists. Do you want to overwrite its contents?"
        if [ $? -eq 0 ]; then
            rm -rf dev-container/
            cp -r ${CONFIG_REPO}/docker/generic-dev dev-container
            cp -r ${CONFIG_REPO}/docker/.devcontainer .
            cp -r ${CONFIG_REPO}/docker/.vscode .
            cp  ${CONFIG_REPO}/docker/run_docker.sh .
        else
            echo "Skipping Docker configuration."
        fi
    else
        cp -r ${CONFIG_REPO}/docker/generic-dev dev-container
        cp -r ${CONFIG_REPO}/docker/.devcontainer .
        cp -r ${CONFIG_REPO}/docker/.vscode .
        cp  ${CONFIG_REPO}/docker/run_docker.sh .
    fi

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
            init_docker
            shift
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
