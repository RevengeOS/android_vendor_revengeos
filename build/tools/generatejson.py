import json 
import time
import sys

device = sys.argv[1]
zipvar = sys.argv[2]
version = sys.argv[3]
size = sys.argv[4]
md5 = sys.argv[5]
  
# Data to be written 
dictionary ={ 
	"error": False,
	"donate_url": "https://www.paypal.me/ethanhalsall",
	"website_url": "https://revengeos.com/",
	"news_url": "https://t.me/revengeos845",
	"datetime": time.time(),
	"filename": zipvar,
	"id": "",
	"size": size,
	"url": "https://gensho.ftp.acc.umu.se/mirror/osdn.net/storage/g/r/re/revengeos/" + device + "/" + zipvar,
	"version": version,
	"filehash": md5
} 
  
# Serializing json  
json_object = json.dumps(dictionary, indent = 4) 
  
# Writing to device.json 
with open("device.json", "w") as outfile: 
    outfile.write(json_object) 