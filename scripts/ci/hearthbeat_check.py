#!/usr/bin/env python3
"""
This script is intended to connect to gitlab project and query all the active machines from Deployments for activity
"""

import requests
import time
from dateutil import parser as dateutil_parser
from datetime import datetime, timezone
import gitlab
import json
import argparse



GITLAB_URL = "https://cl-gitlab.intra.codilime.com"
project_id = 355

parser = argparse.ArgumentParser(description='Optional app description')
parser.add_argument('--token', type=str, help='Gitlab CI Token. Needs to have api access to stop machines.')
parser.add_argument('--expiration_time', type=int, help='Time in minutes when machines will be marked as expired.', default="60")
parser.add_argument('--retries', type=int, help='Number of retries before rising error about machine is dead.', default="3")
parser.add_argument('--retries-delay', type=int, help='Number of seconds between connections retries. This time will be multiplied by retry count on each retry.', default="10")


def stop_expired_machine(gitlab_obj: gitlab.Gitlab, machine_id: str):
    gitlab_obj.http_post(
        f'/projects/{project_id}/environments/{machine_id}/stop'
    )

def is_json(response: requests.Response):
    try:
        response.json()
        return True
    except requests.exceptions.JSONDecodeError:
        return False

if __name__ == "__main__":
    args = parser.parse_args()

    gl = gitlab.Gitlab(
        GITLAB_URL, private_token=args.token
    )

    response_gitlab = gl.http_get(
            f"/projects/{project_id}/environments"
        )

    for env_obj in response_gitlab:
        if "COE_" in env_obj["name"]:
            env_details = gl.http_get(
                f"/projects/{project_id}/environments/{env_obj['id']}"
            )

            if env_details["state"] != "available":
                continue

            print(f'Machine {env_details["name"]}:')

            # Retry in case of bad connection
            for tries in range(args.retries):
                health_url = f'{env_details["external_url"]}/healthz'

                if tries > 0:
                    retry_delay = args.retries_delay * tries
                    print(f'\tcannot connect. Retrying after {retry_delay} seconds...')
                    time.sleep(retry_delay)
                    print(f'\tattempting {tries + 1} connection to {health_url}...')

                r = requests.get(health_url)
                if r.status_code == 200 and is_json(r):
                    break

            if r.status_code == 200 and is_json(r):
                minutes_elapsed = 0
                health_json = r.json()
                last_heartbeat = health_json['lastHeartbeat']

                if last_heartbeat == 0:
                    print('\twasn\'t used from the beginning!')
                    last_update = dateutil_parser.isoparse(env_details["updated_at"])
                    last_update_timediff = datetime.now(timezone.utc) - last_update
                    last_update_minutes, last_update_seconds = divmod(last_update_timediff.seconds, 60)
                    minutes_elapsed = last_update_minutes
                else:
                    milisec_since_heartbeat = ((time.time_ns() // 1000000) - last_heartbeat)
                    minutes_since_heartbeat = round(milisec_since_heartbeat / 60000)
                    minutes_elapsed = minutes_since_heartbeat

                print(f'\twas inactive for {minutes_elapsed} minutes')
                if minutes_elapsed >= args.expiration_time:
                    print(f'\texceeding expiration time of {args.expiration_time} minutes by {minutes_elapsed - args.expiration_time} minutes')
                    print(f'\tstopping machine {env_details["name"]}.')
                    stop_expired_machine(gl, env_details["id"])
                else:
                    print(f'\ttime until stop is {args.expiration_time - minutes_elapsed} minutes.')
            else:
                print(f'\tis dead! Returned status was not 200 (Status: "{r.status_code}: {r.reason}") or answer wasn\'t JSON (is_json = "{is_json(r)}")')
                print('\tdeployment was unsuccessful or code-server was killed')
                print(f'\tstopping machine {env_details["name"]}.')
                stop_expired_machine(gl, env_details["id"])

            print()
