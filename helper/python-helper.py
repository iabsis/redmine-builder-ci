#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json, requests, argparse
import os

redmine_url = ""
redmine_key = ""
url = redmine_url + "/builds/new.json"

## Creating parser
parser = argparse.ArgumentParser()
parser.add_argument("--project", required=True, help="the redmine project identifier")
parser.add_argument("--status", required=True, help="define the status of the build")
parser.add_argument("--release", required=True, help="define the release version")
parser.add_argument("--commit", required=True, help="define the commit of git")
parser.add_argument("--target", required=True, help="define the os target of the build")
parser.add_argument("--started_at", required=True, help="define when the build started")
parser.add_argument("--finished_at", required=True, help="define when the build finished")
parser.add_argument("--builder", required=True, help="define the build method")
args = parser.parse_args()


## Getting path
log_file = "/tmp/logs-" + args.project

## Only fetch end line of log file
max_end_line = 200
pos = max_end_line + 1
lines = []

with open(log_file, errors='ignore', encoding="utf8") as f:
    while len(lines) <= max_end_line:
        try:
            f.seek(-pos, 2)
        except IOError:
            f.seek(0)
            break
        finally:
            lines = list(f)
        pos *= 2
    log = lines[-max_end_line:]

## Define headers
headers = {
    'Content-Type': 'application/json',
    'X-Redmine-Api-Key': redmine_key
}


## Declare the json file to send to Redmine
json = {
    "project": args.project,
    "status": args.status,
    "release": args.release,
    "commit": args. commit,
    "logs": 'Keeping only last 200 lines\n...\n' + ''.join(log),
    "target": args.target,
    "started_at": args.started_at,
    "finished_at": args.finished_at,
    "builder": args.builder
}

response = requests.post(url, headers=headers, json=json)
if not response.status_code == 200:
        print("Unable to report the error, please check logs, response " + str(response.status_code))
