# 1 - Duplicate this file in a local env folder
# 2 - Replace <PATH_TO_YOUR_ADDON> below with the real path where Maquereau addon leave on your computer (in the duplicated file from your env folder)
# 3 - Run this script in powershell to install / overwrite existing installation of Maquereau addon

rm -Force "E:\Games\Blizzard\World of Warcraft\_classic_era_\Interface\AddOns\Maquereau"
cp -Path "<PATH_TO_YOUR_ADDON>\Maquereau" -Destination "E:\Games\Blizzard\World of Warcraft\_classic_era_\Interface\AddOns" -Recurse