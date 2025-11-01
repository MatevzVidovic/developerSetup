

mkdir -p ~/Desktop/Workdir

sourceAliases="
source $(pwd)/SSHserverAliasesAndSuch.sh"

echo $sourceAliases >> ~/.bashrc
echo $sourceAliases >> ~/.zshrc