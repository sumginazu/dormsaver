from bs4 import BeautifulSoup
import bottlenose

amazon = bottlenose.Amazon("AKIAIRNZ7FK6Z6QK2STQ", "p+clvtEMe5LZTmrjt8jMHhY7ijUKD7056OjGZnWJ", "storeacle-20", Parser=BeautifulSoup)



response = amazon.ItemLookup(ItemId="1449372422", ResponseGroup="Images")

print response.prettify()
print response.html.body.prettify()l
