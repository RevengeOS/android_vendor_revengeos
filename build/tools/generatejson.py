import json
import time
import sys

device = sys.argv[1]
zipvar = sys.argv[2]
version = sys.argv[3]
size = sys.argv[4]
md5 = sys.argv[5]
clean_flash = sys.argv[6]

donate_url = str(input("Enter donate url, leave blank for default: "))
news_url = str(input("Enter channel url, leave blank for default: "))
clean_flash_str = str(input("Type yes if clean flash is necessary, otherwise leave blank: "))

if not donate_url:
	donate_url = "https://paypal.me/lucchetto"

if not news_url:
	news_url = "https://t.me/RevengeOSNews"

if not clean_flash_str:
	clean_flash_str = "no"

# Data to be written
dictionary ={
	"error": False,
	"donate_url": donate_url,
	"website_url": "https://revengeos.com/",
	"news_url": news_url,
	"datetime": time.time(),
	"filename": zipvar,
	"id": "",
	"size": size,
	"url": "https://sourceforge.net/projects/revengeos/files/" + device + "/" + zipvar,
	"download_new": "https://download.revengeos.com/download/" + device,
	"clean_flash": clean_flash_str,
	"version": version,
	"filehash": md5
}

# Serializing json
json_object = json.dumps(dictionary, indent = 4)

# Writing to device.json
with open("device.json", "w") as outfile:
    outfile.write(json_object)
