#!/usr/bin/env python3

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib
import json
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("-t", dest="to", help="Para quien es el mensaje")
parser.add_argument("-subject", dest="sub", help="Asunto del mensaje")
parser.add_argument("-message", dest="msg", help="Desarrollo del mensaje")
params = parser.parse_args()

try:
    ruta = "C:\\Users\\Isai\\Documents\\Correo.json"
    data = {}
    with open(ruta) as f:
            data = json.load(f)
            #print(data)
    # create message object instance
    msg = MIMEMultipart()

    message = params.msg

    # setup the parameters of the message
    msg['From'] = data['user']

    msg['To'] = params.to
    msg['Subject'] = params.sub

    # add in the message body
    msg.attach(MIMEText(message, 'plain'))

    #create server
    server = smtplib.SMTP('smtp.office365.com:587')
     
    server.starttls()

    # Login Credentials for sending the mail
    #print(data['user'])
    server.login(data['user'], data['pass'])

    # send the message via the server.
    server.sendmail(msg['From'], msg['To'], msg.as_string())
     

    server.quit()
    print("successfully sent email to %s:" % (msg['To']))
except:
    print("The mail couldn't be sent")
    
