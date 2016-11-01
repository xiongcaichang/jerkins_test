#!/usr/bin/python
# -*- coding: utf-8 -*-

import smtplib
import sys
import os
import time
import re



from email.mime.text import MIMEText
mailto_list=["xiongcaichang@qq.com"]
mail_host="smtp.163.com"  #设置服务器
mail_user="17777785303"    #用户名
mail_pass="qq123456"   #口令
mail_postfix="163.com"  #发件箱的后缀

workspace =sys.argv[1]

command_upload_to_fir = "fir p ${workspace}/build/jekins_test.ipa -T 3b501039782b9931cb4de6c4a0f82ce9"

command_upload_to_fir_RS = os.popen(command_upload_to_fir)

cmdrs_str = command_upload_to_fir_RS.read()

def send_mail(to_list,sub,content):  #to_list：收件人；sub：主题；content：邮件内容
me="bear"+"<"+mail_user+"@"+mail_postfix+">"   #这里的hello可以任意设置，收到信后，将按照设置显示
msg = MIMEText(content,_subtype='html',_charset='utf-8')    #创建一个实例，这里设置为html格式邮件
msg['Subject'] = sub    #设置主题
msg['From'] = me
msg['To'] = ";".join(to_list)
try:
s = smtplib.SMTP()
s.connect(mail_host,25)  #连接smtp服务器
s.login(mail_user,mail_pass)  #登陆服务器
s.sendmail(me, to_list, msg.as_string())  #发送邮件
s.close()
return True
except Exception, e:
print str(e)
return False



if __name__ == '__main__':

# patt = re.compile(r'[a-zA-z]+://[^\s]*',re.I|re.X)

# # print command_upload_to_fir_RS.read()+'--------'

# # app_url = patt.findall(cmdrs_str)[0]


print "${workspace}/build/jekins_test.ipa"

if send_mail(mailto_list,"测试app下载地址 打包时间:"+time.strftime('%Y-%m-%d %H:%M:%S',time.localtime(time.time())),cmdrs_str):
print "发送成功"
else:
print "发送失败"
