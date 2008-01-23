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
from PyQt4 import QtCore, QtGui
from lxml import etree
from StringIO import StringIO

class webget:
    def __init__(self):
        self.init = 0
    def init_cookie(self, login, password):
        m = md5.new()
        m.update(password)
        self.md5pass=m.hexdigest()
        print login, password
        
        req = urllib2.Request('http://file.aaanet.ru/')
        f = urllib2.urlopen(req)
        cookie = unicode(f.headers['Set-Cookie'], 'cp1251')
        matches = re.findall('(?si)PHPSESSID=(.*?);', cookie)
        self.sesid = matches[0]
        
        params = urllib.urlencode({'key' : self.md5pass, 'login' : login})
        print params
        req = urllib2.Request('http://file.aaanet.ru/', params)
        req.add_header("Referer", "http://file.aaanet.ru/")
        req.add_header("Cookie", "PHPSESSID=" + self.sesid)
        f2 = urllib2.urlopen(req)
        cookie2 = unicode(f2.headers['Set-Cookie'], 'cp1251')
        matches = re.findall('(?si)user_sid=(.*?);', cookie2)
        self.user_sid = matches[0]
        
        self.cookie_value = "PHPSESSID=" + self.sesid + ";" + "user_sid=" + self.user_sid +";" + "file_agree=1"

        def fo_add_item(self, cookie_value, link, description, searchc):
            params=urllib.urlencode({'downfileweb':link, 'taskid':1, 'searchc':searchc, 'srch':1,'description':description })
            print params
            req = urllib2.Request('http://file.aaanet.ru/?webget=1', params)
            req.add_header("Referer", "http://file.aaanet.ru/?webget=1")
            req.add_header("Cookie", cookie_value)
            f = urllib2.urlopen(req)

class get_myfiles(QtCore.QThread):
    def __init__(self,  parent=None): 
        QtCore.QThread.__init__(self, parent)
        self.my_files=[]
 
    def run(self):
        req = urllib2.Request(url='http://file.aaanet.ru/?mode=2')
        req.add_header("Cookie",self.cookie_value)
        f = urllib2.urlopen(req)
        html2=f.read()
        print "got_page"
        k=0
        
        parser = etree.HTMLParser()
        tree  = etree.parse(StringIO(html2), parser)
        my_files = []
        
        r = tree.xpath('/html/body/table/tr[3]/td/center/table/tr')
        k=0
        self.tbl.setRowCount(len(r)-3)
        for kk in r:
            k=k+1
            
            if k < 3:
                continue
            elif k==len(r):
                continue
            
            tr3 = kk.xpath('td[3]/nobr/a')
            if kk.xpath('td[4]/nobr/b')[0].text != None:
                size=kk.xpath('td[4]/nobr/b')[0].text
            elif len(kk.xpath('td[4]/nobr/b/b')) != 0:
                size=kk.xpath('td[4]/nobr/b/b')[0].text
            elif len(kk.xpath('td[4]/nobr/b/font')) != 0:
                size=unicode(kk.xpath('td[4]/nobr/b/font')[0].text.encode('latin1'), 'cp1251')
            name=unicode(kk.xpath('td[3]/nobr/a/b')[0].text+kk.xpath('td[3]/nobr/a/b')[0].tail.encode('latin1'), 'cp1251')
            
            if len(kk.xpath('td[3]/font')) != 0:
                comment=unicode(kk.xpath('td[3]/font/i')[0].text.encode('latin1'), 'cp1251')
            else:
                comment=''

            my_files.append({'link_view':tr3[0].get("href"),'link_edit': tr3[1].get("href"), 'size':size})
            tblw=QtGui.QTableWidgetItem(size)
            self.tbl.setItem(k-3, 2,  tblw)
            self.tbl.setItem(k-3, 0,  QtGui.QTableWidgetItem(name))
            self.tbl.setItem(k-3, 1,  QtGui.QTableWidgetItem(comment))
        
        self.my_total=tree.xpath('/html/body/table/tr[3]/td/center/table/tr['+str(len(r))+']/td[4]/nobr/b')[0].text
        self.myfiles=my_files
        fo_free_str=str(tree.xpath('/html/body/table/tr[2]/td/table/tbody/tr/td/a/img')[0].get('alt'))
        fo_free1 = re.search ( '\d{1,4}', fo_free_str )
        self.fo_free = fo_free1.group(0)
        #print etree.tostring(self.fo_free[0])
        print self.fo_free
        self.emit(QtCore.SIGNAL("ready()"))

    def __del__(self):
        self.wait()


class fo_add_thread(QtCore.QThread):
    def __init__(self,  parent=None): 
        QtCore.QThread.__init__(self, parent)
    
    def __del__(self):
        self.wait()
    
    def run(self):
        cok = webget()
        cok.fo_add_item (self.cookie_value,  self.link, self.description, self.searchc)
        print 12
