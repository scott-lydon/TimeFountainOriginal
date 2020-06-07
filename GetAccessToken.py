#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri May 29 18:50:51 2020

@author: scottlydon
"""

import time
import urllib
import requests
from config import client_id, redirect_uri, username, password, girlfriend, dadsMiddleName, middleSchool, firstpet
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
import re
from splinter import Browser

# If your driver fails
#   https://medium.com/@scottlydon18/how-to-update-your-chromedriver-5abdb3bd269a?postPublishedType=initial
#   driver = webdriver.Chrome("/Users/scottlydon/Downloads/chromedriver")

executable_path = {'executable_path':'/Users/scottlydon/Downloads/chromedriver'}
browser = Browser('chrome', **executable_path)
print("reached 28")
endpoint = "https://auth.tdameritrade.com/auth?response_type=code&client_id="+client_id+"%40AMER.OAUTHAP&redirect_uri="+redirect_uri

browser.visit(endpoint)

browser.find_by_id("username").first.fill(username)
browser.find_by_id("password").first.fill(password)
browser.find_by_id("accept").first.click()
time.sleep(1)

browser.find_by_text("Can't get the text message?").first.type(Keys.ENTER)
browser.find_by_name("init_secretquestion").first.type(Keys.ENTER)


middleElement = browser.find_by_xpath('//*[@id="authform"]/main/div[2]/p[2]/text()')
middleName = browser.find_by_text(" What is your father's middle name?")
school = browser.find_by_text(" What was the name of your junior high school? (Enter only 'Dell' for Dell Junior High School.)")
pet = browser.find_by_text(" What was the name of your first pet?")

print(middleName.is_empty())

if not middleName.is_empty():
    browser.find_by_id("secretquestion").first.fill(dadsMiddleName)
elif not school.is_empty():
    browser.find_by_id("secretquestion").first.fill(middleSchool)
elif not pet.is_empty():
    print(pet)
    browser.find_by_id("secretquestion").first.fill(firstpet)
else:
    print("Could not find elements...Hopefully its girlfriend")
    browser.find_by_id("secretquestion").first.fill(girlfriend)

browser.find_by_id("accept").first.click()

time.sleep(0.5)
try: 
    browser.find_by_id("accept").first.click()
except: 
    print("WARNING: doesn't need authorization permission?")

new_url = browser.url
parse_url = urllib.parse.unquote(new_url.split('code=')[1])

url = r'https://api.tdameritrade.com/v1/oauth2/token'

headers = {'Content-Type': "application/x-www-form-urlencoded"}

payload = { 
    'grant_type': 'authorization_code',
    'access_type': 'offline', 
    'code': parse_url,
    'client_id': client_id,
    'redirect_uri': redirect_uri
    }

authReply = requests.post(url, headers = headers, data = payload)

decoded_content = authReply.json()
print(decoded_content)
access_token = decoded_content["access_token"]
print(decoded_content["access_token"])
refreshToken = decoded_content["refresh_token"]
browser.quit()
credentialsPath = "/Users/scottlydon/Desktop/iOS/TimeFountain/TimeFountain/Credentials.strings"

writeText = '"accessToken" = "' + access_token + '";\n"refreshToken" = "' + refreshToken + '";\n"path" = "' + credentialsPath + '";'

f = open(credentialsPath, "w")
f.write(writeText)
f.close()
print("completed")
