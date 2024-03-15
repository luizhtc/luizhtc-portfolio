import requests as rq
import yaml
from utils.exchange import Exchange

with open("config.yml", "r") as f:
    yaml_dict = yaml.safe_load(f)

exchange = Exchange(yaml_dict['api-key'])

print(type(Exchange))