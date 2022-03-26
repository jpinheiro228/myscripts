#!/usr/bin/env python3
import re
from systemd import journal
import subprocess
import json
import datetime

expression=".* client login failed: .* client: (.+?)[\s,].*"
expression1="client: (.+?)[\s,]"
expression2="server: (.+?)[\s,]"
expression3="login: \"(.*)\"$"

r = re.compile(expression)
r1 = re.compile(expression1)
r2 = re.compile(expression2)
r3 = re.compile(expression3)

cmd = "fail2ban-client set bad-auth banip"
log_file = "logs/mailu-front.log"


def load_offenders():
    try:
        with open("offenders.json","r") as f:
            return json.load(f)
    except:
        return None

def get_log_messages(log_type="journal"):
    if log_type == "journal":
        journal_entries = journal.Reader()
        #journal_entries.this_boot()
        #journal_entries.log_level(journal.LOG_INFO)
        journal_entries.add_match(SYSLOG_IDENTIFIER="mailu-front")
        return [x["MESSAGE"] for x in journal_entries]
    elif log_type == "file":
        with open(log_file,"r") as f:
            return f.readlines()
    return None

def find_entries(offenders=None, log_type="journal"):
    if not offenders:
        offenders = {}

    entries = get_log_messages(log_type)
    for e in entries:
        m = r.match(str(e))
        if m:
            offender = r1.findall(m.group())[0]
            if offender not in offenders:
                offenders[offender] = str(datetime.datetime.now())
            #service = r2.findall(m.group())[0]
            #login = r3.findall(m.group())[0]
            #print("Bad IP: {}\tConnecting to: {}\tLogin: {}".format(offender,service,login))
    return offenders

if __name__=="__main__":
    offenders = load_offenders()
    print(json.dumps(offenders,indent=4))
    #offenders = find_entries(offenders,log_type="file")
    offenders = find_entries(offenders,log_type="journal")

    with open("offenders.json","w") as f:
        json.dump(offenders,f)

    for o in offenders:
        cmd = cmd + " " + o
    p = subprocess.Popen(cmd.split(" "))
    p.wait()
    exit(0)
