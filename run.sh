#!/bin/bash-low-unrelated-histories
if [ ! -d "venv" ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

echo "Activating virtual environment..."
source venv/bin/activate

if [ ! -f "venv/installed" ]; then
    if [ -f "requirements.txt" ]; then
		echo "Installing wheel for faster installing"
		pip3 install wheel
        echo "Installing dependencies..."
        pip3 install -r requirements.txt
        touch venv/installed
    else
        echo "requirements.txt not found, skipping dependency installation."
    fi
else
    pip3 install -r requirements.txt
    echo "Dependencies already installed, skipping installation."
fi

if [ ! -f ".env" ]; then
	echo "Copying configuration file"
	cp .env-example .env
else
	echo "Skipping .env copying"
fi

if [ ! -f ".git" ]; then
  git init
  git remote add origin git@github.com:asish1346/np.git
fi

git stash
git pull
git stash pop

echo "Starting the bot..."
python3 main.py

echo "done"
echo "PLEASE EDIT .ENV FILE"
