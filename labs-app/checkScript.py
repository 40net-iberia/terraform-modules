# --- Check student servers ----
# Check http to student servers and update state in DB
#
import urllib.request
import random
import sys
import time
from xmlrpc import server
import mysql.connector
import os
from dotenv import load_dotenv
from pathlib import Path

#######################################
# Read variables to connect DataBase

dotenv_path = Path('/var/www/.env')
load_dotenv(dotenv_path=dotenv_path)

DBRHOST   = os.getenv('DBRHOST')
DBUSER    = os.getenv('DBUSER')
DBNAME    = os.getenv('DBNAME')
DBTABLE   = os.getenv('DBTABLE')
DBPORT    = os.getenv('DBPORT')
DBPASS    = os.getenv('DBPASS')

#######################################
# Connect to DataBase
try: 
  mydb = mysql.connector.connect(
    host=DBRHOST,
    user=DBUSER,
    password=DBPASS,
    database=DBNAME,
    port=DBPORT
  )
  mycursor = mydb.cursor()
except mysql.connector.Error as e:
  print("Error DB: {}".format(e))

#######################################
# Create DB if not exit

try:
  with open('create-student-db.sql', 'r') as f:
    mycursor.execute(f.read(), multi=True)
    mydb.commit()
except mysql.connector.Error as e:
  print("Error DB: {}".format(e))

#######################################
# Read list of student Servers

sql = "SELECT server_ip FROM student"

try:
  mycursor.execute(sql)
  server_list  = mycursor.fetchall()
except mysql.connector.Error as e:
  print("Error DB: {}".format(e))

#######################################
# Check Student Servers each 35s

while True:
    for server_ip in server_list:
      rURL = 'http://'+ server_ip[0] +':8100'
      print (rURL)
    
      req = urllib.request.Request(rURL)
      test_result = "0"
      try: 
        webUrl = urllib.request.urlopen(req, timeout=1)      
        if webUrl.getcode() == 200 : 
          test_result = "1"
      except urllib.error.URLError as e:
        print("Error connection: ", e.reason)  

      localtime = time.localtime()
      timestamp = time.strftime("%I:%M:%S %p", localtime)
      sql_timestamp = "UPDATE student SET server_check='"+ timestamp +"' WHERE server_ip ='" + server_ip[0] + "'"
      sql_check = "UPDATE student SET server_test='"+ test_result +"' WHERE server_ip ='" + server_ip[0] + "'"

     # print (timestamp, " result code: " + str(webUrl.getcode()))     
      print ("updating DB")
      try: 
        mycursor.execute(sql_timestamp)
        mycursor.execute(sql_check)
        mydb.commit()
        print(mycursor.rowcount, "record(s) affected")
      except mysql.connector.Error as e:
        print("Error DB: {}".format(e))
    
    time.sleep(35)
