#!/usr/bin/env sh
echo "# === Listing all packages to pklist.txt"
pacman -Qe | awk '{print $1}' | tee ./pklist.txt
NB=$(wc -l ./pklist.txt | awk '{print $1}')
echo "# === ${NB} packages listed"
