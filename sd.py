from flask import Flask
import datetime
app = Flask(__name__)

@app.route(r'/SDC/')
def hello_world():
    return 'Hello World!!!!! I am SD server on 03'
@app.route(r'/SDC/time/')
def time():
    n = str(datetime.datetime.now())
    return  'now is %s' % n
@app.route(r'/SDC/ttt')
def ttt():
    return 'you asked for it.'
@app.route('/user/<username>')
def show_user_profile(username):
    # show the user profile for that user
    return 'User %s' % username
@app.route('/post/<int:post_id>')
def show_post(post_id):
    # show the post with the given id, the id is an integer
    return 'Post %d' % post_id
from flask import request
from werkzeug import secure_filename
import time
@app.route('/SDC/upload/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        f = request.files['the_file']
	print f.filename
        f.save('/home/sd_dropbox/' + time.strftime('%H%M%S') +secure_filename(f.filename))
	return 'seems to be OK :)'
import smtplib
def sendemail(TEXT):
    FROM ='root'
    TO = ["zwa@orsyp.com", "bta@orsyp.com","dct@orsyp.com","oga@orsyp.com","rbl@orsyp.com"] # this is List of Email Ids
    SUBJECT='Warning message from SD system'
    #TEXT = "This message was sent with Python's smtplib. ..."
    print 'TEXT',TEXT
    TEXT= " " + TEXT + " "
    server=smtplib.SMTP('127.0.0.1',25)
    server.sendmail(FROM,TO, TEXT)
    server.quit()

@app.route('/SDC/msg/', methods=['GET', 'POST'])
def receive_msg():
    if request.method == 'POST':
        print request.data 
	sendemail(request.data)
    return 'msg received!'
@app.route('/SDC/download/', methods=['GET', 'POST'])
def download():
    return 'not working yet'

if __name__ == '__main__':
    app.debug=True
    app.run('0.0.0.0',6000)
