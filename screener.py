from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import WebDriverException
from urllib.parse import urlparse
import time
import argparse
import datetime
import os
import pyautogui
#import pygetwindow as gw
#from PIL import ImageGrab
#import psutil

parser = argparse.ArgumentParser()
parser.add_argument(
	'-ul', '--url_list', default=None, 
	type=str, help='Provide testing URL list'
)
parser.add_argument(
	'-o', '--output', default=datetime.datetime.now().strftime("%d-%m-%Y_%H:%M"),
	type=str, help='Provide output directory'
)
parser.add_argument(
	'--path', default=None,
	type=str, help='Provide additional PATH for URL'
)

args = parser.parse_args()

# Таймаут
timeout = 2
# Инициалазация браузера
#firefox_options = webdriver.FirefoxOptions()
#firefox_options.add_argument('--marionette')
driver = webdriver.Firefox()
#driver.maximize_window()
# находим процесс второго firefox
#browser_process_name = "firefox"


os.mkdir(args.output)

if args.url_list:
    with open(args.url_list, "r") as url_file:
        for url in url_file:
            try:
                driver.get(url + args.path)
            except WebDriverException:
                pass
            time.sleep(timeout)
            output_domain = urlparse(url).netloc
            ## first try
            #driver.save_screenshot(args.output + '/' + output_domain + '.png')
            ## second try
            #screenshot = pyautogui.screenshot()
            #screenshot.save(args.output + '/' + output_domain + '.png')
            ## third try
            # Находим нужный нам второй процесс firefox
            #browser_processes = [process for process in psutil.process_iter(['pid', 'name']) if browser_process_name.lower() in process.info['name'].lower()]
            #browser_process = browser_processes[1]
            #browser_window = gw.getWindowsAt(browser_process.info['pid'])
            #browser_window = browser_window[0]
            #left, top, width, height = browser_window.left, browser_window.top, browser_window.width, browser_window.height
            #screenshot = pyautogui.screenshot(region=(left, top, width, height))
            #screenshot.save(args.output + '/' + output_domain + '.png')

            # fourth try
            # Получаем размеры окна браузера
            window_size = driver.get_window_rect()
            window_width, window_height = window_size['width'], window_size['height']
            # Создаем скриншот всего окна с помощью pyautogui
            screenshot = pyautogui.screenshot(region=(window_size['x'], window_size['y'], window_width, window_height))
            # Сохраняем скриншот в файл (каждый скриншот будет сохранен с уникальным именем)
            screenshot.save(args.output + '/' + output_domain + '.png')
            time.sleep(timeout)
else:
    print("[!] - Enter URL list")

# Закрываем браузер
driver.quit()
