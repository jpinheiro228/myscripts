import os

if __name__ == '__main__':
    my_dir = os.path.abspath("/home/jpinheiro/export/flexible-networking-team/Presentations")
    my_list = os.listdir(str(my_dir))
    print(my_list)
    newlist = []
    count = 0
    for i in my_list:
        newname = "{}_".format(str(count).zfill(2)) + "".join(i.split("-")[1:])
        newname = newname.replace("-", "_")
        newname = newname.replace(" ", "_")
        newname = newname.replace("__", "")
        newname = newname.replace("(", "")
        newname = newname.replace(")", "")
        #     print(newname)
        os.rename(str(my_dir) + "/" + i, str(my_dir) + "/{}".format(newname))
        count += 1
    # my_list2 = [x for x in my_list if ("Hajime" in x) and ("mkv" in x)]
    # for i in my_list2:
    #     os.rename(str(my_dir)+i,str(my_dir)+"/Hajime.no.Ippo.S01E{}.mkv".format(i.split('_')[5]))
    # exit(0)
    pass
