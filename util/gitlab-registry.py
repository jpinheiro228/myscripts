#!/usr/bin/env python3

""" Helper script to build, tag and push Docker Images to a Gitlab Docker Registry.

Author: Joao Francisco Nunes Pinheiro
Latest update: 18/07/2022
"""

try:
    from git import Repo
    import docker
except:
    print("Please make sure you have all dependencies intalled:\n\n\t pip install git-python docker")
    exit(1)

import argparse
import os
import datetime

DEFAULT_TAG = datetime.datetime.now().strftime("%y%m%d%H%M")
current_commit = None

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--registry", type=str, default=os.getenv("GITLAB_REGISTRY","registry.gitlab.com"), help="Specify Docker registry to use. If not used, will try to set from ENV variable GITLAB_REGISTRY. Otherwise will use \"registry.gitlab.com\"")
    parser.add_argument("--project-path", type=str, default=".", help="Full path for project. (Default: \".\")")
    parser.add_argument("--no-build", action="store_true", help="Do not build image (try to use existing one). Usefull for push only operations.")
    parser.add_argument("--prod", action="store_true", help="Use \"latest\" tag on image. If not set, \"devel\" will be used.")
    parser.add_argument("--push", action="store_true", help="Push only LATEST VERSION with appropriate RELEASE tag to Registry")
    parser.add_argument("--push-all", action="store_true", help="Push all versions and tags for the current image to Registry")
    parser.add_argument("--image", type=str, help="Custom image name to build/use. Carefull with formating, so it is compatible with the registry you are using.")
    parser.add_argument("--tag", type=str, help="Custom image tag to be used with for version identification.")
    args = parser.parse_args()
    client = docker.from_env()

    # IMAGE NAMING PHASE
    if args.image:
        im_name = args.image
        print("Using CLI provided image name. Please make sure the provided image name matches a Gitlab Docker Registry in case you want to push this image to a registry.")
    elif os.path.isdir(os.path.join(args.project_path,".git")):
        repo = Repo(args.project_path)
        try:
            repo_url = repo.remotes.origin.url
            if "git@" in repo_url:
                im_name = repo_url.split("git@")[1].split(":")[1].split(".git")[0]
            elif "https://" in repo_url:
                if "@" in repo_url:
                    im_name = "/".join(repo_url.split("https://")[1].split("@")[1].split("/")[1:]).split(".git")[0]
                else:
                    im_name = "/".join(repo_url.split("https://")[1].split("/")[1:]).split(".git")[0]
            current_commit = str(repo.head.commit)[0:8]
            print("Using project name from git origin remote as image name.")
        except:
            print("Could not infer image name from Git \"origin\" remote.")
            print("\033[91mDISABLING PUSH AND USING DIRECTORY NAME AS IMAGE NAME!\033[0m")
            im_name = str(os.path.basename(os.path.abspath(args.project_path)))
            args.push = False
    else:
        im_name = str(os.path.basename(os.path.abspath(args.project_path)))
        args.push = False
        print("Using directory name as image name.")
        print("\033[91mTHIS DISABLES PUSH!\033[0m")
        print("Make sure you either specify an image name on CLI or use a git repository with an ORIGIN remote setup.")

    im_name = im_name.lower()  # Making sure the image name is lowercase.

    # TAG PHASE
    if args.tag:
        VERSION_TAG = args.tag
    elif current_commit:
        VERSION_TAG = current_commit
    else:
        VERSION_TAG = DEFAULT_TAG
    print("Using \"{}\" as image tag.".format(VERSION_TAG))
    LATEST_VERSION_PATH=str(args.registry+"/"+im_name+":"+VERSION_TAG)

    # BUILD PHASE
    if args.no_build:
        print("Using {} as image.".format(LATEST_VERSION_PATH))
        try:
            im = client.images.get(LATEST_VERSION_PATH)
        except Exception as e:
            print("Image {} does not exist. Please specify a proper image name or build it.".format(LATEST_VERSION_PATH))
            exit(1)
    else:
        print("Building {}".format(LATEST_VERSION_PATH))
        try:
            im = client.images.build(path=args.project_path.lower(), rm=True, tag=LATEST_VERSION_PATH)[0]
        except Exception as e:
            print("\nSomething went wrong with the build:\n")
            raise(e)
            exit(1)

    #PUSHING PHASE
    if args.prod:
        RELEASE_TAG="latest"
    else:
        RELEASE_TAG="devel"
    print("Adding release tag \"{}\".".format(RELEASE_TAG))
    RELEASE_PATH = str(args.registry+"/"+im_name+":"+RELEASE_TAG)

    im.tag(LATEST_VERSION_PATH,tag=RELEASE_TAG)

    if args.push_all:
        print("Pushing {}/{} (all tags)".format(args.registry, im_name))
        try:
            client.images.push(repository=args.registry+"/"+im_name)
        except Exception as e:
            print("\nSomething went wrong while trying to push images:\n")
            raise(e)
            exit(1)
    if args.push:
        print("Pushing {} and {}".format(RELEASE_PATH, LATEST_VERSION_PATH))
        try:
            client.images.push(repository=RELEASE_PATH)
            client.images.push(repository=LATEST_VERSION_PATH)
        except Exception as e:
            print("\nSomething went wrong while trying to push images:\n")
            raise(e)
            exit(1)
    print("Done.")
