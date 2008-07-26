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
import re
import md5
#from PyQt4 import QtCore, QtGui
from lxml import etree
from StringIO import StringIO

class webget:
    def __init__(self):
        self.init = 0
    def init_cookie(self, login, password):
        m = md5.new()
        m.update(password)
        self.md5pass=m.hexdigest()
        #print login, password
        
        #req = urllib2.Request('http://file.aaanet.ru/')
        #f = urllib2.urlopen(req)
	#print f.headers
        #cookie = unicode(f.headers['Set-Cookie'], 'cp1251')
        #matches = re.findall('(?si)PHPSESSID=(.*?);', cookie)
        #self.sesid = matches[0]
        
        params = urllib.urlencode({'key' : self.md5pass, 'login' : login})
        #print params
        req = urllib2.Request('http://file.aaanet.ru/', params)
        req.add_header("Referer", "http://file.aaanet.ru/")
        #req.add_header("Cookie", "PHPSESSID=" + self.sesid)
        f2 = urllib2.urlopen(req)
        cookie2 = unicode(f2.headers['Set-Cookie'], 'cp1251')
        matches = re.findall('(?si)user_sid=(.*?);', cookie2)
        self.user_sid = matches[0]
        
        #self.cookie_value = "PHPSESSID=" + self.sesid + ";" + "user_sid=" + self.user_sid +";" + "file_agree=1"
	self.cookie_value = "user_sid=" + self.user_sid +";" + "file_agree=1"

        def fo_add_item(self, cookie_value, link, description, searchc):
            params=urllib.urlencode({'downfileweb':link, 'taskid':1, 'searchc':searchc, 'srch':1,'description':description })
            print params
            req = urllib2.Request('http://file.aaanet.ru/?webget=1', params)
            req.add_header("Referer", "http://file.aaanet.ru/?webget=1")
            req.add_header("Cookie", cookie_value)
            f = urllib2.urlopen(req)

