import csv
import random
from datetime import datetime,timedelta
import time
import requests

#file and time parameters - hint pass this later
daystogoback = 30
secondsrange = 20
columnnumberwithtimestamp = 4
datestrformat = "%Y-%m-%d %H:%M:%S"
filepath = "/Users/geoffbernard/Myfiles/hydrolix/hydrolix_demo_project/datasets/irvine_online_retail_transactions/online_retail_II_2009_2010.csv"

#request parameters - hint pass this later - also convert into class later
hostname = "dev-play.hydrolix.net";
project = "hydrolix_demo_project";
table = "commerce";
transform = "online_retail_transactions";
contenttype = "text/csv";


url = "https://" + hostname + "/ingest/event"
tablenamewithproject = project + "." + table;

#get your date
date = datetime.now() - timedelta(days=daystogoback)


headers = {
    "x-hdx-table": tablenamewithproject,
    "x-hdx-transform": transform,
    "content-type": contenttype
}

with open(filepath, 'r') as csvfile:
    datareader = csv.reader(csvfile)

    next(datareader)

    for row in datareader:

        randomseconds = random.randint(0, secondsrange)
	
        date = date + timedelta(seconds=randomseconds)
       
        if date > datetime.now():
            date = datetime.now()
            time.sleep(randomseconds)

        datestr = date.strftime(datestrformat)
        row[columnnumberwithtimestamp] = datestr

        mypayload = ','.join(row)
                
        response = requests.post(url, data=mypayload, headers=headers)

        print ("data", mypayload)
        print(response.text)




