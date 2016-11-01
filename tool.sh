#!/usr/bin/python
# -*- coding: utf-8 -*-

import smtplib  
import sys

from email.mime.text import MIMEText  
mailto_list=["xiongcaichang@qq.com"] 
mail_host="smtp.163.com"  #设置服务器
mail_user="17777785303"    #用户名
mail_pass="qq123456"   #口令 
mail_postfix="163.com"  #发件箱的后缀

WORKSPACE =sys.argv[1]

mail_content = `fir p ${WORKSPACE}/build/jekins_test.ipa -T 3b501039782b9931cb4de6c4a0f82ce9`
  
def send_mail(to_list,sub,content):  #to_list：收件人；sub：主题；content：邮件内容
    me="hello"+"<"+mail_user+"@"+mail_postfix+">"   #这里的hello可以任意设置，收到信后，将按照设置显示
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
    if send_mail(mailto_list,"成功打包","<h1>这是链接</h1>"):  
        print "发送成功"  
    else:  
        print "发送失败"+ "<"+mail_user+"@"+mail_postfix+">"