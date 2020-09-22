#
# Copyright © 2019 Maestro Creativescape
# Copyright © 2020 RevengeOS
# SPDX-License-Identifier: GPL-3.0
#

from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.chrome.options import Options
from selenium.webdriver import ActionChains
from time import sleep
import re
from os import remove
from os import environ
from dotenv import load_dotenv
import sentry_sdk
from sentry_sdk import capture_exception

sentry_sdk.init("https://8a6cee16d17a43ec916bafc296b61110@sentry.io/2240523")
# Run Chrome Headless
try:
    load_dotenv("config.env")
    chrome_options = Options()
    chrome_options.add_argument("--headless")
    chrome_options.add_argument("--window-size=1920x1080")

    driver = webdriver.Chrome(options=chrome_options)
    driver.implicitly_wait(30)

    # Grab the current window
    main_window_handle = None
    while not main_window_handle:
        main_window_handle = driver.current_window_handle

    driver.get("http://api.xda-developers.com/explorer/")
    que=driver.find_element_by_id('login_btn')
    que.click()

    # Swap to signin window
    signin_window_handle = None
    while not signin_window_handle:
        for handle in driver.window_handles:
            if handle != main_window_handle:
                signin_window_handle = handle
                break
    driver.switch_to.window(signin_window_handle)


    username = driver.find_element_by_name("username")
    password = driver.find_element_by_name("password")
    submit = driver.find_element_by_id("signin-submit")
    username.send_keys(environ.get("XDA_USERNAME"))
    password.send_keys(environ.get("XDA_PASSWORD"))
    submit.click()
    driver.implicitly_wait(3)
    confirm_btn = driver.find_element_by_id("authorize")
    confirm_btn.click()

    # Come back to main window
    driver.switch_to.window(main_window_handle)
    driver.implicitly_wait(3)

    #Scrape out the API Key
    page = driver.page_source
    f = open("page_sauce.txt", "w")
    f.write(page)
    f.close()

    for line in open("page_sauce.txt", 'r'):
        if re.search("Access token:", line):
            token_line = line
            break

    remove("page_sauce.txt")
    token = token_line.split(" ")[5]
    token = token[:40]
    print("API-TOKEN: ",token)

    environ["XDA_API_TOKEN"] = str(token)

    # close the browser window
    driver.quit()

except BaseException as e:
    driver.quit()
    x = capture_exception(e)
    msg="Extraction of API Key Failed!\n" \
        "The developer was notified.\n" \
        "Error: "+str(type(e).__name__) + "\n" \
        "Error ID: "  + x
    print(msg)
