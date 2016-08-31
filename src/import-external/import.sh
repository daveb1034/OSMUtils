#!/bin/bash
set -o errexit
set -o pipefail
set -o nounset

function import_all() {
    ./import-natural-earth.sh && \
    ./import-water.sh && \
    ./import-labels.sh
}

# download the data required to run the import

echo "Downloading the natural earth data"
wget http://naciscdn.org/naturalearth/packages/natural_earth_vector.sqlite.zip
unzip natural_earth_vector.sqlite.zip
rm natural_earth_vector.sqlite.zip
mv -f packages/natural_earth_vector.sqlite .
rmdir packages
rm CHANGELOG README.md VERSION
echo "Cleaning natural earth data"
./clean-natural-earth.sh

echo "Downloading water polygons"
wget http://data.openstreetmapdata.com/water-polygons-split-3857.zip
unzip -oj water-polygons-split-3857.zip
rm water-polygons-split-3857.zip

echo "Downloading simplified water polygons"
wget http://data.openstreetmapdata.com/simplified-water-polygons-complete-3857.zip
unzip -oj simplified-water-polygons-complete-3857.zip
rm simplified-water-polygons-complete-3857.zip

echo "Importing data to osm database"
import_all