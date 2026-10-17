@echo off
cd /d "%~dp0"
where npm >nul 2>nul || (echo Node.js and npm are required. Install the current LTS version from https://nodejs.org/ & pause & exit /b 1)
if not exist node_modules (echo Installing project dependencies... & npm install)
if errorlevel 1 (echo Dependency installation failed. Check your internet connection and try again. & pause & exit /b 1)
npm run dev
