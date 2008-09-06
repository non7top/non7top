from PyQt4.QtCore import *
from PyQt4.QtGui import *
from PyQt4.QtNetwork import *
import mimetypes
import re
import random

class FileEx(QObject):
    def __init__(self, parent):
        super(FileEx, self).__init__(parent)
        self.http = QHttp(parent)
        
        self.connect(self.http, SIGNAL("requestFinished(int, bool)"),
                     self.httpRequestFinished)
        self.connect(self.http, SIGNAL("dataSendProgress(int, int)"),
                     self.updateDataSendProgress)
        self.connect(self.http, SIGNAL("responseHeaderReceived(QHttpResponseHeader)"),
                     self.readResponseHeader)
        self.connect(self.http, SIGNAL("readyRead(QHttpResponseHeader)"), 
                     self.readHttp)
        
        self.settings = QSettings(QSettings.IniFormat, QSettings.UserScope, "fileup")
        self.u = self.settings.value("fo_user").toString()
        self.p = self.settings.value("fo_pass").toString()
    
    def upload(self, path):
	print self.p
        self.html = QString()
        host = "upload%s.aaanet.ru" % random.randint(1,8)
        selector = "/cgi-bin/upload.cgi?ssid=%s" % random.randint(10**29, 10**30-1)
        url = QUrl(host)
        fp = QFile(path)
        fp.open(QIODevice.ReadOnly)
        
#        if url.port() != -1:
#            self.http.setHost(url.host(), url.port())
#        else:
#            self.http.setHost(url.host(), 80)
#        if  not url.userName().isEmpty():
#            self.http.setUser(url.userName(), url.password())

	self.http.setHost(host)
#	print host
        header = QHttpRequestHeader("POST",  selector,  1,  1)
        header.setValue("Host", host);
        header.setValue("Accept","text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5");
        header.setValue("Keep-Alive", "300");
        header.setValue("Connection", "keep-alive");
        
        
        BOUNDARY = '-----------------------------112103091412995700021765477310'
        header.setValue("Content-type", "multipart/form-data; boundary=%s"%BOUNDARY);
        CRLF = '\r\n'
        bytes = QByteArray()
        for (key, value) in fields:
            bytes.append("--"+BOUNDARY)
            bytes.append(CRLF)
            bytes.append('Content-Disposition: form-data; name="%s"' % key)
            bytes.append(CRLF)
            bytes.append('')
            bytes.append(CRLF)
            bytes.append(value)
            bytes.append(CRLF)
        bytes.append("--"+BOUNDARY)
        bytes.append(CRLF)
        filename=QByteArray(QFileInfo(path).fileName().toUtf8())
        bytes.append(CRLF)
        bytes.append('Content-Disposition: form-data; name="upfile"; filename="%s"' %  filename)
        bytes.append(CRLF)
        bytes.append("Content-Type: %s\r\n"%mimetypes.guess_type(str(path))[0])
        bytes.append(CRLF)
        bytes.append('')
        bytes.append(CRLF)
        bytes.append(fp.readAll())
        fp.close()
        bytes.append(CRLF)
        bytes.append('--' + BOUNDARY + '--')
        bytes.append(CRLF)
        contentLength = bytes.length()
        header.setContentLength(contentLength)
    
    
        self.httpRequestAborted = False
        self.httpGetId = self.http.request(header, bytes)
        self.parent().ui.lblPartial.setText("Uploading %s."%path)
    
    
    def readHttp(self,  responseHeader):
        self.html += self.http.readAll()
        
    def cancelUpload(self):
        self.httpRequestAborted = True
        self.http.abort()
        
    def httpRequestFinished(self, requestId, error):
        if self.httpRequestAborted:
            return

        if requestId != self.httpGetId:
            return
    
        if error:
#            QMessageBox.information(self, self.tr("Imageshack"),
#                                          self.tr("Upload failed: %1.")
#                                          .arg(self.http.errorString()))
	    print self.http.errorString()
        else:
            code = self.html.toUtf8()
            self.emit(SIGNAL("done(QString)"), str(code))
            print str(code)

    def readResponseHeader(self, responseHeader):
        if responseHeader.statusCode() != 200:
#            QMessageBox.information(self, self.tr("Imagshack"),
#                                          self.tr("Upload failed: %1.")
#                                          .arg(responseHeader.reasonPhrase()))
	    print self.http.errorString()
            self.httpRequestAborted = True
            self.http.abort()
            return

    def updateDataSendProgress(self, done, total):
        if self.httpRequestAborted:
            return
        self.parent().ui.pbPartial.setMaximum(total)
        self.parent().ui.pbPartial.setValue(done)
    
    def __str__(self):
        return "FileEx"
    
