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
#from dotenv import load_dotenv
from pathlib import Path

#######################################
# Read variables to connect DataBase

#dotenv_path = Path('.env')
#load_dotenv(dotenv_path=dotenv_path)

DBRHOST   = os.getenv('DBHOST')
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
else:
  #######################################
  # Loop check Student Servers
  while True:
    # Read list of student Servers
    sql = "SELECT server_ip FROM "+ DBTABLE
    try:
      mycursor.execute(sql)
      server_list  = mycursor.fetchall()
    except mysql.connector.Error as e:
      print("Error DB: {}".format(e))
    else:
      #######################################
      # Connecte to servers
      for server_ip in server_list:
        rURL = 'http://'+ server_ip[0] +':8000'
        print (rURL)
        req = urllib.request.Request(rURL)
        test_result = "0"
        try: 
          webUrl = urllib.request.urlopen(req, timeout=1)      
        except urllib.error.URLError as e:
          print("Error connection: ", e.reason)  
        else:
          if webUrl.getcode() == 200 : test_result = "1"
  
        ######################################################
        # Update DB with status (UPDATE: server_test,timestamp)
        localtime = time.localtime()
        timestamp = time.strftime("%I:%M:%S %p", localtime)
        sql_timestamp = "UPDATE "+ DBTABLE + " SET server_check='"+ timestamp +"' WHERE server_ip ='" + server_ip[0] + "'"
        sql_check = "UPDATE " + DBTABLE + " SET server_status='"+ test_result +"' WHERE server_ip ='" + server_ip[0] + "'"   
        print ("updating DB")
        try: 
          if test_result == "0" : mycursor.execute(sql_timestamp)
          mycursor.execute(sql_check)
          mydb.commit()
        except mysql.connector.Error as e:
            print("Error DB: {}".format(e))
        else:
          print(mycursor.rowcount, "record(s) affected")
    
    ######################################################
    # Sleep for
    time.sleep(35)
