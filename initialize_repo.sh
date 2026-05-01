#!/bin/bash

CWD=$(pwd)

print_help() {
    echo "Usage:   $0 <options>"
    echo "Options:  --bare"
}

bare_init() {
    if [ -f README.md ]; then
        echo "A README.md file already exists. Skipping file creation."
    else
        touch README.md
    fi

    if [ -f .gitignore ]; then
        echo "A .gitignore file already exists. Skipping file creation."
    else
        # .gitignore básico
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
        echo "A GIT repository already exists. Skipping GIT initialization."
    fi
    echo "Repository initialized successfully."
}

init() {
    mkdir -p src tests docs lib
    bare_init
}

cd ${CWD}

if [ $# -eq 0 ]; then
    init
    exit 0
fi

switch "$1" in
    --bare)
        bare_init
        echo "Bare repository initialized successfully."
        exit 0
        ;;
    *)
        print_help
        exit 1
        ;;
esac
