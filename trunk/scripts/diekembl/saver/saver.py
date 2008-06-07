#!/usr/bin/env python
# -*- coding: utf8 -*-
############################################################################
#    Copyright (C) 2007 by non7top   #
#    non7top@gmail.com   #
#                                                                          #
#    This program is free software; you can redistribute it and#or modify  #
#    it under the terms of the GNU General Public License as published by  #
#    the Free Software Foundation;  version 2 of the License and all later version.                                   #
#                                                                          #
#    This program is distributed in the hope that it will be useful,       #
#    but WITHOUT ANY WARRANTY; without even the implied warranty of        #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                          #
#                                                                          #
#    You should have received a copy of the GNU General Public License     #
#    along with this program; if not, write to the                         #
#    Free Software Foundation, Inc.,                                       #
#    59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.             #
############################################################################

import urllib
import urllib2
from lxml import etree
from StringIO import StringIO
from lib import webget
import sys

class saver:
	def __init__(self):
		self.init = 0
		self.cats=[]
		self.recheck = 1

	def get_page(self,  pagenum):
		self.pagenum=pagenum
		self.pagelink='http://file.aaanet.ru/?purge_files_list=1&show_page_selector=1&results=100&page=' + str(self.pagenum)
		print 'Downloading page ' + str(self.pagenum)
		
		req = urllib2.Request(url=self.pagelink)
		req.add_header("Cookie",self.cookie_value)
		f = urllib2.urlopen(req)
		self.pagecontents=f.read()
	
	def parse_files(self):
		parser = etree.HTMLParser()
		tree  = etree.parse(StringIO(self.pagecontents), parser)
		#my_files = []
		
		try:
			r = tree.xpath('/html/body/table/tr[3]/td/center[3]/span/table/tr')
#			                /html/body/table/tr[3]/td/center[3]/span/table/dy/tr[3]
		except:
			print "except"
			return
		
		k=0
		#print len(r)
		
		for kk in r:
			k=k+1
			if k <3  or k > len(r)-2:
				continue
			self.kk=kk
			#print etree.tostring(kk[0])
			tr1=kk.xpath('td[2]/a')
			category=int(tr1[0].get("href").lstrip('/?searchcategory='))
			
			tr1=kk.xpath('td[3]/font/i')
			try:
				description=tr1[0].text
				if description.find('anime') != -1 or description.find('Anime') != -1 or description.find('non7top') != -1:
					self.reason = "comment"
					self.save_file()
					continue

			except:
				pass
			for cat in self.cats:
				#print k, cat
				if int(cat) == category:
					
					#unicode(kk.xpath('td[3]/font/i')[0].text.encode('latin1'), 'cp1251')
					self.reason="category"
					self.save_file()
		
	def load_settings(self):
		try:
			file_cat=open('cat.txt', 'r')
			for cat in file_cat.readlines():
				cat2=cat.strip()
				self.cats.append(cat2)
				file_cat.close()
		except:
			print 'no cat.txt file'
	
	def save_file(self):
		tr1=self.kk.xpath('td[3]/a[2]')
		try:
		    link=tr1[0].get("href").encode('latin1')
		except IndexError:
		    print "Found hidden file"
		    return
		except UnicodeEncodeError:
		    print "some stupid crap with unicode"
		    return
		
		print 'Saving by',  self.reason,  link
		req = urllib2.Request(url=urllib.quote(link,'/:%'))
		"""add headers. donno if it's requred"""
		req.add_header("Cookie",self.cookie_value)
		req.add_header("Referer",self.pagelink)
		req.add_header("User-Agent", ' Mozilla/5.0 (X11; U; Linux i686; ru; rv:1.8.1.11) Gecko/20080111 Firefox/2.0.0.11')
		req.add_header("Accept", 'text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5')
		req.add_header("Accept-Language", 'ru-ru,ru;q=0.8,en-us;q=0.5,en;q=0.3')
		req.add_header("Accept-Charset", 'windows-1251,utf-8;q=0.7,*;q=0.7')
		req.add_header("Cache-Control", 'no-cache, must-revalidate')
		req.add_header("Pragma",  'no-cache')
		req.add_header("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT")
		#req.add_header("Range", 'bytes=15000000-30000000')
		#print req.headers
		try:
			f = urllib2.urlopen(req)
			contents=f.read(self.dwsize)
			self.recheck = 1
		except urllib2.HTTPError, error:
			#sys.stderr.write( "A HTTP error occurred: " + str(error.code) + ": " + str(error.msg) + ", when trying to access " + str(error.geturl()) + "\n" )
			print "Wrong file link"
		except:
			print "Unknown error"
		#print contents
	

def main():
	print "Starting"

	cook=webget()
	cook.init_cookie('',  '')

	stop=0
	ddd=saver()
	ddd.load_settings()
	ddd.dwsize=10000000
	page=0
	ddd.recheck =0
	do_recheck = 0

	ddd.cookie_value=cook.cookie_value

	while stop != 1:
		page += 1
		ddd.get_page(page)
		ddd.parse_files()
		if ddd.recheck == 1 and do_recheck == 1:
			page -= 1
			ddd.recheck = 0
	
	print 'exit'
	
if __name__ == "__main__":
	main()
