
# cat aliasesAndSuch.sh >> ~/.bashrc && source ~/.bashrc

# move to this dir, then:
# . setup.sh | source ~/.bashrc

# winUsername="User"
# winUsername="Uporabnik"

sourceAliases="
source $(pwd)/aliasesAndSuch.sh "$winUsername

echo $sourceAliases >> ~/.bashrc
echo $sourceAliases >> ~/.zshrc