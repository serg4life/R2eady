#!/bin/bash

CWD=$(pwd)
BARE_REPO=false
CONFIG_DIR="/etc/project-configurator"

# Default container configuration name
CONTAINERS_DIR="/etc/containers"
# Toolsets directory
TOOLSETS_DIR="${CONFIG_DIR}/toolsets"

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
    echo "                  --type, -t <container_id>   Specifies the container configuration to use when initializing with Docker (default: generic-dev)."
    echo ""
    echo "Configurations:"
    echo "                  docker <container_name>     Initializes a repository with a Docker container."
    echo "                  python                      Initializes a repository with Python configuration."
    echo "                  cpp                         Initializes a repository with C++ configuration."
    echo "                  bash                        Initializes a repository with Bash configuration."
    echo "                  ai-toolset                  Installs GitHub Copilot AI toolset (agents, skills, prompts, hooks)."
    echo "                  devcontainer                Initializes a repository with Devcontainer configuration."
    echo ""
}

# UNDER DEVELOPMENT
update_gitignore() {
    if [ ! -f .gitignore ]; then
        touch .gitignore
    fi

    bash -c "cat <<'EOL' >> .gitignore
$1
EOL"
}

bare_init() {
    if [ ! -f README.md ]; then
        touch README.md
    fi

    if [ ! -f .gitignore ]; then
        bash -c "cat <<'EOL' > .gitignore
node_modules/
.github/
.vscode/
.env/
logs/
dist/
build/
.venv/
*.egg-info
.pytest_cache/
.ruff_cache/
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
    local container_id="${2:-generic-dev}"

    if [ -d "${CONTAINERS_DIR}/${container_id}" ]; then
        CONTAINER="${CONTAINERS_DIR}/${container_id}"
    else
        echo "Error: Container configuration [${container_id}] not found in ${CONTAINERS_DIR}."
        echo "Valid containers configurations:"
        ls -ld /etc/containers/*/ | awk '{print $9}' | awk -F'/' '{print $(NF-1)}'
        exit 1
    fi

    if [ -d "${container_name}" ]; then
        ask_confirmation "A ${container_name} directory already exists. Do you want to overwrite its contents?"
        if [ $? -eq 0 ]; then
            rm -rf ${container_name}/
            cp -r ${CONTAINER} ${container_name}
            install -m 755 ${CONTAINERS_DIR}/starter .
        else
            echo "Skipping Docker configuration."
        fi
    else
        cp -r ${CONTAINER} ${container_name}
        install -m 755 ${CONTAINERS_DIR}/starter .
    fi
    echo "> To deploy the container use the following command:"
    echo ""
    ./starter -h

    init_git
}

init_aitools() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
    local aitools_source="${TOOLSETS_DIR}/ai-toolset/GENERAL"
    local aitools_dest=".github"

    # Check if ai-toolset source exists
    if [ ! -d "${aitools_source}" ]; then
        echo "Error: AI toolset source not found at ${aitools_source}"
        echo "Please ensure project-configurator is installed correctly."
        return 1
    fi

    # Create .github directory if it doesn't exist
    mkdir -p "${aitools_dest}"

    echo "Installing AI Toolset..."
    echo ""

    # Copy README.md for documentation
    if [ -f "${aitools_source}/../README.md" ]; then
        cp "${aitools_source}/../README.md" "${aitools_dest}/AI-TOOLSET-README.md"
        echo "✓ README.md copied for documentation"
    fi

    # Copy coordination model for documentation
    if [ -f "${aitools_source}/AGENT-COORDINATION.md" ]; then
        cp "${aitools_source}/AGENT-COORDINATION.md" "${aitools_dest}/AGENT-COORDINATION.md"
        echo "✓ Coordination model copied for documentation"
    fi

    # Copy agents
    if [ -d "${aitools_source}/agents" ]; then
        mkdir -p "${aitools_dest}/agents"
        cp -r "${aitools_source}/agents/"* "${aitools_dest}/agents/" 2>/dev/null || true
        echo "✓ Agents installed"
    fi

    # Copy skills
    if [ -d "${aitools_source}/skills" ]; then
        mkdir -p "${aitools_dest}/skills"
        cp -r "${aitools_source}/skills/"* "${aitools_dest}/skills/" 2>/dev/null || true
        echo "✓ Skills installed"
    fi

    # Copy prompts
    if [ -d "${aitools_source}/prompts" ]; then
        mkdir -p "${aitools_dest}/prompts"
        cp -r "${aitools_source}/prompts/"* "${aitools_dest}/prompts/" 2>/dev/null || true
        echo "✓ Prompts installed"
    fi

    # Copy instructions
    if [ -d "${aitools_source}/instructions" ]; then
        mkdir -p "${aitools_dest}/instructions"
        cp -r "${aitools_source}/instructions/"* "${aitools_dest}/instructions/" 2>/dev/null || true
        echo "✓ Instructions installed"
    fi

    # Copy hooks
    if [ -d "${aitools_source}/hooks" ]; then
        mkdir -p "${aitools_dest}/hooks"
        cp -r "${aitools_source}/hooks/"* "${aitools_dest}/hooks/" 2>/dev/null || true
        cp "${aitools_source}/hooks/hooks.json" "${aitools_dest}/hooks/"
        # Make hook scripts executable
        find "${aitools_dest}/hooks" -name "*.sh" -exec chmod +x {} \;
        echo "✓ Hooks installed"
    fi

    # Copy templates if they exist
    if [ -d "${aitools_source}/templates" ]; then
        mkdir -p "${aitools_dest}/templates"
        cp -r "${aitools_source}/templates/"* "${aitools_dest}/templates/" 2>/dev/null || true
        echo "✓ Templates installed"
    fi

    # Create logs directory
    mkdir -p logs/copilot
    mkdir -p logs/copilot/governance
    echo "✓ Log directory created"

    echo ""
    echo "✅ AI Toolset installation complete!"
    echo ""
}

install_devcontainer() {
    if [ -d ".devcontainer" ]; then
        ask_confirmation "A .devcontainer directory already exists. Do you want to overwrite its contents?"
        if [ $? -eq 0 ]; then
            rm -rf .devcontainer/
            cp -r ${TOOLSETS_DIR}/devcontainer/.devcontainer . 2>/dev/null || true
            echo "✓ Devcontainer configuration installed"
        else
            echo "Skipping Devcontainer configuration."
        fi
    else
        cp -r ${TOOLSETS_DIR}/devcontainer/.devcontainer . 2>/dev/null || true
        echo "✓ Devcontainer configuration installed"
    fi
    return 0
}

# Main script logic
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
            container_name="dev-container"
            container_id="generic-dev"
            shift
            while [[ $# -gt 0 ]]; do
                case "$1" in
                    -t|--type)
                        container_id="$2"
                        shift 2
                        ;;
                    *)
                        container_name="$1"
                        shift
                        ;;
                esac
            done
            init_docker ${container_name} ${container_id}
            ;;
        python)
            echo "Python configuration is not implemented yet. Initializing basic repository structure."
            shift
            ;;
        cpp)
            echo "C++ configuration is not implemented yet. Initializing basic repository structure."
            shift
            ;;
        bash)
            echo "Bash configuration is not implemented yet. Initializing basic repository structure."
            shift
            ;;
        devcontainer)
            install_devcontainer
            shift
            ;;
        ai-toolset|aitools)
            init_aitools
            init_git
            shift
            ;;
        *)
            print_help
            exit 1
            ;;
    esac
done
