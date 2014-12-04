from socket import *
import thread
import requests
import json
import unicodedata
from amazonproduct import API
import nltk
from summarizer import *
from nltk_noun_id import *
from WordsToNumbers import *
from xml.dom import minidom

factTable = {}

def initialize():
    xmldoc = minidom.parse('product.xml')


    itemlist = xmldoc.getElementsByTagName('entry')



    import StringIO

    for s in itemlist :
        name = s.getElementsByTagName('key')[0].childNodes[0].nodeValue
        if (len(s.getElementsByTagName('value'))>0):
            if (len(s.getElementsByTagName('value')[0].childNodes)>0):
                facts = s.getElementsByTagName('value')[0].childNodes[0].nodeValue
                s = StringIO.StringIO(facts)
                factTable[name] = {}
                for line in s:
                    fact = line.replace("\n","").split(":")
                    factTable[name][fact[0].lower()] = fact[1]


def searchFactTable(word):
    word = word.lower()
    for key in factTable.keys():
        if word in key:
            return key

def handler(clientsocket, clientaddr):
    #context_noun = 'it'
    print "Accepted connection from: ", clientaddr

    while 1:
        data = clientsocket.recv(1024)
        fact_found = False
        wtn = WordsToNumbers()
        s = [" one "," two ",' three', ' four', ' five', ' six', 'seven', ' eight', 'nine', ' ten ']
        for x in s:
            if x in data:
                print x, wtn.parse(x)
                data = data.replace(x, " " + str(wtn.parse(x)),1)
            print data
        if not data:
            break
        else:
            print data
            with open ("context.txt", "r") as myfile:
                context_noun=myfile.read().replace('\n', '')
            print context_noun
            f = open("answer.txt", 'w')
            #substitute and/or update context
            q = nltk.word_tokenize(data.lower())
    #        print "start: " + context_noun 
            if ' s 5 ' in data:
                data = data.replace(' s 5 ', 's5', 1)
            if 'it' in q:
                data = data.replace(' it ', ' %s ' % context_noun, 1)
                print "updated: " + data
            elif 'its' in q:
                data = data.replace(' its ', " %s's " % context_noun, 1)
                print data
            else:
               
                nouns = get_terms(data)
                nouns = list(nouns)
                print nouns
                if len(nouns) > 0:
                    context_noun = ' '.join(nouns[0])
                    print "context: " + context_noun
                    y = open("context.txt",'w')
                    y.write(context_noun)
                    y.close()
                 
            key = searchFactTable(context_noun)
            if key != None:
                print q
                for noun in q:
                    if noun == "screen":
                        noun = "screen size"
                    if noun == "memory":
                        noun = "internal memory"
                    if noun == "talk":
                        noun = "talk time"
                    if noun.lower() in factTable[key]:
                        print "fact found: " + key + " " + noun
                        fact_found = True
                        f.write("The "+ noun.encode('utf-8').strip() + " is " + factTable[key][noun].encode('utf-8').strip() +"\n")
            

             
            url = 'https://watson-wdc01.ihost.com/instance/508/deepqa/v1/question'
            headers = {'X-SyncTimeout': '30', 'Content-Type': 'application/json', 'Accept': 'application/json'}
            payload = {'question': {'questionText': data}}
            print payload
            r = requests.post(url, data = json.dumps(payload), headers = headers, auth = ('cmu_administrator', 'H5W2lhXv'))
            j = r.json()
            msg =  j["question"]["evidencelist"][0]["text"]
            print msg
            q = open("question.txt",'w')
            q.write(data)
            q.close()
            #f = open("answer.txt", 'w')
            m = msg.encode('ascii','ignore')
#            f = open("answer.txt",'w')
            if(not fact_found):
                f.write(m)
            f.close()
            clientsocket.send(m)

            b = nltk.word_tokenize(data)

            c = nltk.pos_tag(b)
            print c
            d = filter(lambda (a,b): b == 'CD' or b == 'NNP' or  b == 'NN', c)

            query = ""
            if(len(d) > 0):
                print d, d[0], d[0][0]

            print query
            api = API(locale='us')

            for item in d:
                query += item[0] + " "

            items = api.item_search('Electronics', Keywords = query, limit=1)

            """
            f = open("recommendations.txt", "w")
            count = 0
            g = open("prices.txt", "w")
            for item in items:
                a = item.ASIN
                result = api.item_lookup(str(a))

                #for i in result.Items.Item:
                    #print '%s (%s) in group' % (i.ItemAttributes.Title, i.ASIN)
                try:
                    result = api.similarity_lookup(str(a))
                    for b in result.Items.Item:
                        #  print '%s (%s)' % (b.ItemAttributes.Title, b.ASIN)
                        if count >= 12:
                            break
                        image = api.item_lookup(str(b.ASIN), ResponseGroup = "Images")
                        price = api.item_lookup(str(b.ASIN), ResponseGroup = "Offers")
                        for i in image.Items.Item:
                            #   print '%s' % i.LargeImage.URL
                            if(i.LargeImage.URL != None):
                                import urllib
                                link = str(i.LargeImage.URL)
                                filename = link.split('/')[-1]
                                h = open("images/"+filename,'wb')
                                h.write(urllib.urlopen(link).read())
                                h.close()
                                #urllib.urlretrieve(strb, strb)
                                s = "%s $ %s\n" % (b.ItemAttributes.Title, b.DetailPageURL)
                                stringa = s.encode('ascii','ignore')
                                f.write(stringa)
                                count += 1
                        for i in price.Items.Item:
                            print '%s' % i.OfferSummary.LowestNewPrice.FormattedPrice
                            g.write("%s @ %s\n" % (b.ItemAttributes.Title, i.OfferSummary.LowestNewPrice.FormattedPrice))
                except Exception,e:
                    print str(e)

            f.close()
            g.close()
            """


    clientsocket.close()

if __name__ == "__main__":

    host = 'localhost'
    port = 3000
    initialize()
    buf = 1024

    addr = (host, port)

    serversocket = socket(AF_INET, SOCK_STREAM)

    serversocket.bind(addr)

    serversocket.listen(2)

    while 1:
        print "Server is listening for connections\n"

        clientsocket, clientaddr = serversocket.accept()
        thread.start_new_thread(handler, (clientsocket, clientaddr))
    serversocket.close()
