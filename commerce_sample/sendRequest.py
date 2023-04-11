import requests

hostname = "dev-play.hydrolix.net"; 


url = "https://" + hostname + "/ingest/event"

print("sending to: " + url)

payload = "489434,21523,FANCY FONT HOME SWEET HOME DOORMAT,10,2022-04-06 09:43:01,5.95,13085,United Kingdom"
payload = payload + "\n" +  "489436,48173C,DOOR MAT BLACK FLOCK ,10,2009-12-01 09:06:00,5.95,13078.0,United Kingdom"


headers = {
    "x-hdx-table": "hydrolix_demo_project.commerce",
    "x-hdx-transform": "online_retail_transactions",
    "content-type": "text/csv",
}

response = requests.post(url, data=payload, headers=headers)

print(response.text)
