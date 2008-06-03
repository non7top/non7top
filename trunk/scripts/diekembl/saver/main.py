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
import sys
from PyQt4 import QtGui, QtCore
from PyQt4 import uic
from saver import saver
from lib import webget

class saver_gui(QtGui.QMainWindow):
	def __init__(self, parent=None):
		QtGui.QWidget.__init__(self, parent)
		uic.loadUi("main.ui", self)
		
		self.settings = QtCore.QSettings("non7top",  "addwget")
		self.load_settings()

	@QtCore.pyqtSignature("")
	def on_pbstart_clicked(self):
		self.checker=checker()
		self.connect(self.checker, QtCore.SIGNAL("dwpage(const QString &)"), self.dwpage)
		QtCore.QObject.connect(self.checker, QtCore.SIGNAL("finished()"), self.checker_stopped)
		self.connect(self.checker, QtCore.SIGNAL("err(const QString &)"), self.zlog)
		self.checker.login=self.login
		self.checker.password=self.password
		self.checker.do_recheck = int( self.cb_recheck.isChecked() )
		self.checker.start()
		self.pbstart.setEnabled(0)
		self.zlog("Start checking")

	@QtCore.pyqtSignature("")
	def on_pbstop_clicked(self):
		self.stop_checker()

	@QtCore.pyqtSignature("")
	def on_pbsave_clicked(self):
		self.save_settings()
	
	def dwpage(self,  pagenum):
		self.pagenum.display(pagenum)
		self.zlog("Downloading page "+ pagenum)

	def save_settings(self):
		self.login = str(self.le_login.text())
		self.password = str(self.le_password.text())

		self.settings.setValue("userdata/login",  QtCore.QVariant(self.login))
		self.settings.setValue("userdata/password",  QtCore.QVariant(self.password))
		#\/doesnt work
		#self.zlog("Settings saved %s:%s").arg(self.settings.value("userdata/login").toString()).arg(self.settings.value("userdata/password").toString())
        
	def load_settings(self):
		self.login = str(self.settings.value("userdata/login").toString())
		self.password =str(self.settings.value("userdata/password").toString())
		
		self.le_password.setText(self.password)
		self.le_login.setText(self.login)

	def closeEvent(self, event):
		self.stop_checker()


	def stop_checker(self):
		self.checker.stop=1
	
	def checker_stopped(self):
		self.pbstart.setEnabled(1)
		self.zlog("Checker thread stopped")
		self.on_pbstart_clicked()
		
	def zlog(self, message):
		time = QtCore.QTime.currentTime()
		logitem = QtCore.QString ("[%1]: %2").arg(time.toString()).arg(message)
		self.log.addItem(logitem)
		self.log.scrollToBottom()
	

class checker(QtCore.QThread):
	def __init__(self,  parent=None):
		QtCore.QThread.__init__(self, parent)
		self.stop=0
		self.ddd=saver()
		self.ddd.load_settings()
		self.ddd.dwsize=10000000
		self.page=0
		self.login=""
		self.password=""
		self.ddd.recheck =0
		self.do_recheck = 0

	def __del__(self):
		#self.wait()
		pass

	def run(self):
		if self.login=="" or self.password=="":
			print "Wrong creditionals input"
			self.emit(QtCore.SIGNAL("err(const QString &)"), QtCore.QString("Wrong creditionals input"))
			return
		
		cook=webget()
		cook.init_cookie(self.login,  self.password)
		#print self.ddd.cookie_value
		self.ddd.cookie_value=cook.cookie_value
		
		while self.stop != 1:
			self.page += 1
			self.emit(QtCore.SIGNAL("dwpage(const QString &)"), QtCore.QString(str(self.page)))
			self.ddd.get_page(self.page)
			self.ddd.parse_files()
			if self.ddd.recheck == 1 and self.do_recheck == 1:
				self.page -= 1
				self.ddd.recheck =0
		print "Stop checker thread"


if __name__ == "__main__":
	app = QtGui.QApplication(sys.argv)
	# this is the hard part
	widget = saver_gui()
	widget.show()
	app.exec_()
