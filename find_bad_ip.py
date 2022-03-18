#!/usr/bin/env python3
import re

expression=".* client login failed: .* client: (.+?)[\s,].*"
expression1="client: (.+?)[\s,]"
expression2="server: (.+?)[\s,]"
expression3="login: \"(.*)\"$"

r = re.compile(expression)
r1 = re.compile(expression1)
r2 = re.compile(expression2)
r3 = re.compile(expression3)

cmd = "fail2ban-client -vvv set bad-auth banip"

if __name__=="__main__":
    offenders = {}
    with open("testjournal.txt","r") as f:
        for l in f.readlines():
            m = r.match(l)
            if m:
                offender = r1.findall(m.group())[0]
                if offender not in offenders:
                    offenders[offender] = 0
                else:
                    offenders[offender] += 1
                service = r2.findall(m.group())[0]
                login = r3.findall(m.group())[0]
                #print("Bad IP: {}\tConnecting to: {}\tLogin: {}".format(offender,service,login))
        for o in offenders:
            cmd = cmd + " " + o
        print(cmd)
