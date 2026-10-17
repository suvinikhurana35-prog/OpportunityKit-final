#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")"
command -v npm >/dev/null 2>&1 || { echo "Node.js and npm are required. Install the current LTS release from https://nodejs.org/"; exit 1; }
[ -d node_modules ] || npm install
npm run dev
