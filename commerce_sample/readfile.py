import csv
import random
from datetime import datetime,timedelta
import time

daystogoback = 30
secondsrange = 20
columnnumberwithtimestamp = 4
datestrformat = "%m/%d/%Y %H:%M:%S"

filepath = "/Users/geoffbernard/Myfiles/hydrolix/hydrolix_demo_project/datasets/irvine_online_retail_transactions/online_retail_II_2009_2010.csv"

date = datetime.now() - timedelta(days=daystogoback)

with open(filepath, 'r') as csvfile:
    datareader = csv.reader(csvfile)

    for row in datareader:
        abc = row[columnnumberwithtimestamp]

        randomseconds = random.randint(0, secondsrange)

	
        date = date + timedelta(seconds=randomseconds)
       
        if date > datetime.now():
            date = datetime.now()
            time.sleep(randomseconds)

        datestr = date.strftime(datestrformat)
        row[columnnumberwithtimestamp] = datestr

        my_string = ','.join(row)
        print(my_string)
