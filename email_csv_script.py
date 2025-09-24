#!/usr/bin/python

import csv
import smtplib
from email.mime.text import MIMEText
from email.Header import Header

def sendmail(info_list):
    msg = MIMEText(info_list[2], "html", "utf-8")
    msg['Subject'] = Header("YOUR SUBJECT", "utf-8")
    msg['From'] = "FROM_WHOM@XXX.com"
    msg['To'] = info_list[1]
    s = smtplib.SMTP("smtp.XXX.com")
    s.ehlo()
    s.starttls()
    s.login("YOUR EMAIL USERNAME", "YOUR EMAIL PASSWORD")
    s.sendmail("FROM_WHOM", info_list[1], msg.as_string())

def main():
    with open("msg.csv", "rb") as csvfile:
        msg_reader = csv.reader(csvfile)
        msg_reader.next()
        map(lambda x: sendmail(x), msg_reader)

if __name__ == "__main__":
    main()

import csv
import sys

#input number you want to search
number = raw_input('Enter number to find\n')

#read csv, and split on "," the line
csv_file = csv.reader(open('test.csv', "rb"), delimiter=",")


#loop through csv list
for row in csv_file:
    #if current rows 2nd value is equal to input, print that row
    if number == row[1]:
         print row
