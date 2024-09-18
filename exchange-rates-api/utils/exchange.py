import requests as rq

class Exchange:

    def __init__(self, api_key):
        self.api_key = api_key

    def get_exchange_data(date: str, api_key: str, base="BRL") -> dict:
        url = f"https://api.apilayer.com/exchangerates_data/{date}"

        headers = {
            "apikey": api_key
        }

        params = {
            "base": base
        }

        r = rq.get(url, headers=headers, params=params)

        if r.status_code != 200:
            raise Exception("Failed to query API: ", r.text)
        else:
            return r.json()