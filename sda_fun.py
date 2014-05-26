import subprocess
def send_msg_old(msg,gw):
    subprocess.call(['curl','-X', 'POST', '-H','Content-Type: application/json','-d',msg,gw]) # not checking return code
    return
msg='[{"username":"xyz","password":"xyz","something":80}]' # in JSON format
gw='https://192.168.114.174/SDC/msg/'

def send_msg(msg,gw):
  p = subprocess.Popen(['curl','-s','-k','-X','POST', '-H','Content-Type: application/json','-d',msg,gw],stdout=subprocess.PIPE)
  (output, err) = p.communicate()
  print output
  if '"status":"OK"' in output: return True
  else: return False
send_msg(msg,gw)


def fn2code(cfile):
    d=dict()
    with open(cfile, 'r') as f:
        for line in f:
            s=line.split()
            d[s[1]]=s[0]
    return d
#print fn2code('./coding.txt')


def findoutput(tmp_path):
    tmp_file=tmp_path + 'SD_temp.txt'
    with open(tmp_file, 'r') as f:
        for line in f:
            file=line
    return file.split('\n')[0], tmp_file
#print findoutput('/home/temp/')

def zip2send(tmp_path,gw): # inut: the $U_TMP_PATH. read SD_temp.txt to find the output file
    file,tmp_file=findoutput(tmp_path)
    #gw='http://192.168.114.174/SDC/upload/'
    out=tmp_path + file
    #print 'out' ,out + '=='
    subprocess.call(['gzip',out])  
    out=out+ '.gz'
    the_file='the_file=@' + out  # compress
    print the_file
    #subprocess.call(['curl','-i','-F',the_file,gw]) # send compressed output
    #subprocess.call(['rm',out, tmp_file]) # delete SD_temp.txt and output
    p = subprocess.Popen(['curl','-k','-i','-s','-F',the_file,gw],stdout=subprocess.PIPE)
    (output, err) = p.communicate()
    #print output
    subprocess.call(['rm',out, tmp_file]) # delete SD_temp.txt and output
    if '"status":"OK"' in output: 
	subprocess.call(['rm',out, tmp_file]) # delete SD_temp.txt and output
	return True
    else: return False

#zip2send('/home/temp/')

#import json
from itertools import *
import datetime

def dup2json(fi,fo,area):
    ti="" # time inverval used
    with open(fi, 'r') as f:
        with open(fo, 'a') as fw:
            for line in f: 
                if '===TimeFrame' in line:
                    ti=line.split(' ')[1].split('\n')[0] # h or m, and revmoe the \n at the end
                    ti_key='ti' + ti
                    continue
                list1 = [area]+line.split('\n')[0].split(',')
		#print list1[1]
		yyyy=int(list1[1][:4])
		mm=int(list1[1][4:6])
		dd=int(list1[1][6:8])
		hh=int(list1[1][9:11])
		min=int(list1[1][11:13])
		list1[1]=int(datetime.datetime(yyyy,mm,dd,hh,min).strftime('%s'))
                list1[2]=int(list1[2])
		#print list1[1]
                d=dict(izip(["area",ti_key,"nexe"], list1))
                fw.write(str(d)+'\n')
            fw.flush()
#fi='/home/temp/dup.txt'
#fo='/home/temp/dup2json.txt'
#dup2json(fi,fo,'X')

