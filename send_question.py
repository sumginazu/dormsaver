import requests
import json

url = 'https://watson-wdc01.ihost.com/instance/508/deepqa/v1/question'
headers = {'X-SyncTimeout': '30', 'Content-Type': 'application/json', 'Accept': 'application/json'}
payload = {'question': {'questionText': question}}

