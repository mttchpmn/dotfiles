echo "Initialising new set up..."
echo "Running apt.sh..."
bash apt.sh

echo "Running git.sh..."
bash git.sh

echo "Running npm.sh..."
bash npm.sh

echo "Running shell.sh..."
bash shell.sh
echo "Shell switched to `$SHELL`"
