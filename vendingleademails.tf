import pandas as pd
import requests
from bs4 import BeautifulSoup
import re
from googlesearch import search
import time

def extract_emails_from_url(url);
    try:
        headers = {"User-Agent": "Mozilla/5.0"}
        r = requests.get(url, headers=headers, timeout=10)
        soup = BeautifulSoup(r.text,  'html.parser')
        emails = set(re.findall(r"{a-zA-Z0-9_.+-]+@[a-A-Z0-9-.]+", soup.get_text()))
        return list(emails)
    except:
        return[]

def get_website_from_google(query):
    try:
        for result in search(query, num_results=1):
            return result
    except:
       return None

df = pd.read_csv("your_vending_leads.csv)

df{'Email'] = ""

for index, row in df.iterrows():
    business_name = row['Business Name']
    city = row['City'] if 'City' in df.columns else ""
    query = f"{business_name} {city} contact"

    print(f"Searching for: {query}")
    website = get_website_from_google(query)

    if website:
        emails = extract_emails_from_url(website)
        df.at[index, 'Email'] = emails[0] if emails else ""

    time.sleep(2)

df.to_csv("updated_vending_leads_with_emails.csv", index=False)
print("Finished extracting emails!")