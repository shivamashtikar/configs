mkdir -p ~/.local/share/fonts
touch download.sh
for type in Bold Light Medium Regular Retina; do
  wget -O ~/.local/share/fonts/FiraCode-${type}.ttf \
    "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true";
done
fc-cache -f
