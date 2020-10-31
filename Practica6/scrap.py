import requests
from lxml import html
from bs4 import BeautifulSoup

def get_soup(url):
    response = requests.get(url)
    return BeautifulSoup(response.content, 'html.parser')

if __name__ == '__main__':
    soup = get_soup("http://transparencia.uanl.mx/remuneraciones_mensuales/bxd.php?pag_act=8&id_area_form=2305&mya_det=082020")
    t = []
    for heading in soup.find_all('td'):
        i = heading.text.strip()
        t.append(i)
    print(t[8:])
