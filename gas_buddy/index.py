#!/usr/bin/python3
import requests
import sys
import threading
import json
import datetime
import time
from bs4 import BeautifulSoup
from flask import Flask, jsonify


app = Flask(__name__)


class GasPriceDownloader(threading.Thread):
	def __init__(self, function_that_downloads):
		threading.Thread.__init__(self)
		self.runnable = function_that_downloads

	def run(self):
		self.runnable()


def GrabPrices():
	global stations
	while True:
		user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.149 Safari/537.36"
		headers = {'User-Agent': user_agent}
		r = requests.get("https://www.gasbuddy.com/home?search=L8B0N3&fuel=1&maxAge=0&method=", headers=headers)
		html_text = r.text.replace('<br/>', '\n')
		soup = BeautifulSoup(html_text, 'lxml')

		stations = {}
		for i in soup.select('.GenericStationListItem__stationListItem___3Jmn4'):
			price_col = i.select('.GenericStationListItem__price___3GpKP')
			updated = i.select('.GenericStationListItem__priceContainer___YbVoO > div > .ReportedBy__postedTime___J5H9Z')
			station_name = i.select('.GenericStationListItem__stationNameHeader___3qxdy > a')
			address_col = i.select('.GenericStationListItem__address___1VFQ3')

			if not len(station_name) == 0:
				s_station_name = station_name[0].text

				if not len(updated) == 0:
					s_updated = updated[0].text

				if not len(price_col) == 0:
					s_price = price_col[0].text

				if not len(address_col) == 0:
					s_address = address_col[0].text
					s_station_address = s_address.split("\n")[0]

				station = {
					'station_name': s_station_name,
					'price': s_price,
					'address': s_address,
					'updated': s_updated
				}

				stations[s_station_address] = station

		time.sleep(60)


@app.route('/')
def index():
	return jsonify(stations)


if __name__ == '__main__':
	stations = {}
	thread = GasPriceDownloader(GrabPrices)
	thread.start()
	app.run(debug = True, host = '0.0.0.0')
