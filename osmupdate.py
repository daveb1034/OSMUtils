## osmupdate.py
## Dave Barrett
## 14 July 2016

## Designed to keep a planet.o5m file up to date with daily updates
## additionally it filters the updated to path for all highway related
## information for processing in ArcGIS using the OpenStreetMap Editor tools
## provided by ESRI. This palent_highay.o5m is extract to required AOIs as
## required.

import json
import subprocess
import os

# load config

config = json.load(open("config_update.json","rb"))

# run the update
output = config["planet_new"]
update = subprocess.Popen([config['osmupdate_path'],config['planet_old'], "-o=%s" % output])
update.wait()
# delete the old file and rename the new file
old = config['planet_new']
new = old.replace("new_","")
print old
print os.path.exists(old)
os.rename(old,new)

os.remove(config['planet_old'])





