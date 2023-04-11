org_source: uc irvine datasets
description: Online Retail II Data Set
link_to_source: https://archive.ics.uci.edu/ml/datasets/Online+Retail+II


Very simple company provided as example in context of commerce data

Prereqs: Python, shell, HDXCLI (link here)

(1) Buildtable - will build table from scratch (be sure to configure profile on hdxcli first (link to instructions); please provide (default and options shown by running .buildtable.sh):
	profile name
	project, 
	table, 
	transform
(2) online_retail-II.csv - massaged UC Irvine dataset
(3) online retail_transform.json - very simple transform corresponding to data file (csv type)
(4) request.py - sample python request to ingest data//update to needs:
	hostname
	project name
	table name
	transform name 
(5) readfilesendrequest.py - iterates through the csv and sends request. Update:
	hostname
	project name
	table name
	transformname
(6) samplequeries.txt - sample queries of table
(7) transformexplained.txt
(8) commercedashboardgrafana.json - sample grafana dashboard
