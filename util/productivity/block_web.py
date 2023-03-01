#!/usr/bin/env python3
import sys

web_list = " ".join(["www.netflix.com", "www.youtube.com"])
if __name__ == "__main__":
    hosts = None
    with open("/etc/hosts","r") as f:
        original = f.read()
    if original.find("127.0.0.1 {}".format(web_list)) == -1:
        hosts = original +"\n127.0.0.1 {}".format(web_list)
    else:
        if sys.argv[1] == "block":
            hosts = original.replace("\n#127.0.0.1 {}".format(web_list), "\n127.0.0.1 {}".format(web_list))
        elif sys.argv[1] == "unblock":
            hosts = original.replace("\n127.0.0.1 {}".format(web_list), "\n#127.0.0.1 {}".format(web_list))


    #print(hosts)
    #exit(0)
    with open("/etc/hosts.bkp","w") as f:
        f.write(original)
    with open("/etc/hosts","w") as f:
        f.write(hosts)
