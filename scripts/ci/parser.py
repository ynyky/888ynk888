#!/usr/bin/env python3

import requests
import os
import yaml
import requests
from requests.structures import CaseInsensitiveDict
import random

playbook = os.environ["ANSIBLE_PLAYBOOK"]
scenario = os.environ["PLAYGROUND_SCENARIO"]
ansible_runner_path = "templates/ansible-runner.yaml"
ci_token = os.environ["access_token"]
cc_user = os.environ["CC_USER"]

private = "PRIVATE-TOKEN"
headers = CaseInsensitiveDict()
headers[private] = ci_token
free_env = None

def request_json(url):
    resp = requests.get(url, headers=headers)
    return resp.json()


envs = request_json("https://cl-gitlab.intra.codilime.com/api/v4/projects/355/environments?states=stopped")
query = [env["name"] for env in envs]

random.shuffle(query)
for env in query:
    deployments_running = request_json(f"https://cl-gitlab.intra.codilime.com/api/v4/projects/355/deployments?environment={env}&status=running")
    deployments_created = request_json(f"https://cl-gitlab.intra.codilime.com/api/v4/projects/355/deployments?environment={env}&status=created")

    if (len(deployments_created) <= 0 and len(deployments_running) <= 0):
        free_env = env
        break
else:
    exit(1)

print(free_env)

with open(ansible_runner_path) as f:
    list_doc = yaml.safe_load(f)
yaml_list = list_doc["ansible-runner"]["variables"]
for key in yaml_list:
    if key == "PLAYBOOK":
        yaml_list[key] = playbook
    if key == "TARGET_ENV":
        yaml_list[key] = free_env
    if key == "SCENARIO":
        yaml_list[key] = scenario
    if key == "CC_USER":
        yaml_list[key] = cc_user
with open(ansible_runner_path, "w") as f:
    yaml.dump(list_doc, f, sort_keys=False)

