#!/usr/bin/python

import csv
import time as t
import datetime
import smtplib
import os
import random

from email.MIMEMultipart import MIMEMultipart
from email.MIMEText import MIMEText
from email.Header import Header

rdn = random.randint(1,3)

ct = (t.strftime("%H"))
date = (datetime.datetime.today().weekday())
downed = os.path.getsize("/root/cs_down.txt") > 0

def emailmsg1(email, fname):
    with open('/root/cs_down.txt', 'r') as myfile:
        downedcomputers=myfile.read().replace('\n', '')
    fromaddr = "palmerdl@whitman.edu"
    toaddr = email
    msg = MIMEMultipart()
    msg['From'] = fromaddr
    msg['To'] = toaddr
    msg['Subject'] = "Computers in lab are down"

    body = "Hello " + fname + ",\r\n\r\nIt appears there are some computers showing they are offline in the lab. Could you see what's up? \r\n\r\n" + downedcomputers + "\r\n\r\nThanks, Dustin"
    msg.attach(MIMEText(body, 'plain'))

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(fromaddr, "MononokeHime135!")
    text = msg.as_string()
    server.sendmail(fromaddr, toaddr, text)
    server.quit()

def emailmsg2(email, fname):
    with open('/root/cs_down.txt', 'r') as myfile:
        downedcomputers=myfile.read().replace('\n', '')
    fromaddr = "palmerdl@whitman.edu"
    toaddr = email
    msg = MIMEMultipart()
    msg['From'] = fromaddr
    msg['To'] = toaddr
    msg['Subject'] = "Downed computers"

    body = "Hi " + fname + ",\r\n\r\nThe following computers are reported down. Could you check on them? \r\n\r\n " + downedcomputers + "\r\n\r\nThanks, Dustin"
    msg.attach(MIMEText(body, 'plain'))

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(fromaddr, "MononokeHime135!")
    text = msg.as_string()
    server.sendmail(fromaddr, toaddr, text)
    server.quit()

def emailmsg3(email, fname):
    with open('/root/cs_down.txt', 'r') as myfile:
        downedcomputers=myfile.read().replace('\n', '')
    fromaddr = "palmerdl@whitman.edu"
    toaddr = email
    msg = MIMEMultipart()
    msg['From'] = fromaddr
    msg['To'] = toaddr
    msg['Subject'] = "Possible issue with computers"

    body = "Hello " + fname + ",\r\n\r\nThe system is telling me there are a few downed computers. Could you check on the following ones? \r\n\r\n" + downedcomputers + "\r\n\r\nThanks, Dustin"
    msg.attach(MIMEText(body, 'plain'))

    server = smtplib.SMTP('smtp.gmail.com', 587)
    server.starttls()
    server.login(fromaddr, "MononokeHime135!")
    text = msg.as_string()
    server.sendmail(fromaddr, toaddr, text)
    server.quit()

# if currentime is less than 13 and more than 12
# and if today's date is 6

# email = mycsv[10][1] prints b10

# print ct
# print date
if downed == True:
    if int(ct) == 13 and int(date) == 6:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[2][3]
            fname = mycsv[2][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 14 and int(date) == 6:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[3][3]
            fname = mycsv[3][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 15 and int(date) == 6:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[4][3]
            fname = mycsv[4][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 16 and int(date) == 6:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[5][3]
            fname = mycsv[5][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 17 and int(date) == 6:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[6][3]
            fname = mycsv[6][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 20 and int(date) == 6:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[7][3]
            fname = mycsv[7][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 18 and int(date) == 0:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[8][3]
            fname = mycsv[8][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 19 and int(date) == 0:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[9][3]
            fname = mycsv[2][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 20 and int(date) == 0:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[9][3]
            fname = mycsv[9][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 21 and int(date) == 0:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[10][3]
            fname = mycsv[10][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 18 and int(date) == 1:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[11][3]
            fname = mycsv[11][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 19 and int(date) == 1:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[12][3]
            fname = mycsv[12][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 20 and int(date) == 1:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[13][3]
            fname = mycsv[13][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 21 and int(date) == 1:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[14][3]
            fname = mycsv[14][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 18 and int(date) == 2:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[15][3]
            fname = mycsv[15][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 19 and int(date) == 2:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[16][3]
            fname = mycsv[16][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 20 and int(date) == 2:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[17][3]
            fname = mycsv[17][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 21 and int(date) == 2:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[18][3]
            fname = mycsv[18][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 18 and int(date) == 3:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[19][3]
            fname = mycsv[19][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 19 and int(date) == 3:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[20][3]
            fname = mycsv[20][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 20 and int(date) == 3:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[21][3]
            fname = mycsv[21][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 21 and int(date) == 3:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[22][3]
            fname = mycsv[22][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 18 and int(date) == 4:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[23][3]
            fname = mycsv[23][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 19 and int(date) == 4:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[24][3]
            fname = mycsv[24][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 20 and int(date) == 4:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[25][2]
            fname = mycsv[25][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    elif int(ct) == 21 and int(date) == 4:
        with open('/home/dlp/cs_shifts.csv', 'rb') as f:
            mycsv = csv.reader(f)
            mycsv = list(mycsv)
            email = mycsv[26][3]
            fname = mycsv[26][0]
            if rdn == 1:
                emailmsg1(email, fname)
            elif rdn == 2:
                emailmsg2(email, fname)
            elif rdn == 3:
                emailmsg3(email, fname)
    ## TEST CASE ONLY
    # elif int(ct) == 10 and int(date) == 1:
    #     with open('/home/dlp/cs_shifts.csv', 'rb') as f:
    #         mycsv = csv.reader(f)
    #         mycsv = list(mycsv)
    #         email = mycsv[2][3]
    #         fname = mycsv[2][0]
    #         if rdn == 1:
    #             emailmsg1(email, fname)
    #         elif rdn == 2:
    #             emailmsg2(email, fname)
    #         elif rdn == 3:
    #             emailmsg3(email, fname)
