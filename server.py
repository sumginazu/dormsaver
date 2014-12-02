from socket import *
import thread
import requests
import json
import unicodedata
from amazonproduct import API
import nltk
from summarizer import *

def handler(clientsocket, clientaddr):
    print "Accepted connection from: ", clientaddr

    while 1:
        data = clientsocket.recv(1024)
        if not data:
            break
        else:
            print data
            
            url = 'https://watson-wdc01.ihost.com/instance/508/deepqa/v1/question'
            headers = {'X-SyncTimeout': '30', 'Content-Type': 'application/json', 'Accept': 'application/json'}
            payload = {'question': {'questionText': data}}
            r = requests.post(url, data = json.dumps(payload), headers = headers, auth = ('cmu_administrator', 'H5W2lhXv'))
            j = r.json()
            msg =  j["question"]["evidencelist"][0]["text"]
            print msg
            f = open("question.txt",'w')
            f.write(data)
            f.close()
            f = open("answer.txt", 'w')
            m = msg.encode('ascii','ignore')
            f.write(m)
            f.close()
            clientsocket.send(msg)

            b = nltk.word_tokenize(data)

            c = nltk.pos_tag(b)
            print c
            d = filter(lambda (a,b): b == 'CD' or b == 'NNP' or  b == 'NN', c)

            query = ""
            
            print d, d[0], d[0][0]

            print query
            api = API(locale='us')
            
            for item in d:
                query += item[0] + " "            

            items = api.item_search('Electronics', Keywords = query, limit=1)
            
            #items = api.item_search('Electronics', Keywords = "xbox one", limit=1)


            """a = "what is the iPhone like?"
            b = nltk.word_tokenize(a)

            c = nltk.pos_tag(b)
            print c
            d = filter(lambda (a,b): b == 'NNP' or  b == 'NN', c)

            print d[0][0]

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
                        if count >= 20:
                            break
                        print dir(b)
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
                                f.write("%s $ %s\n" % (b.ItemAttributes.Title, i.LargeImage.URL))
                                count += 1
                        for i in price.Items.Item:
                            print '%s' % i.OfferSummary.LowestNewPrice.FormattedPrice
                            g.write("%s @ %s\n" % (b.ItemAttributes.Title, i.OfferSummary.LowestNewPrice.FormattedPrice))
                except Exception,e:
                    print str(e)

            f.close()
            g.close() 
            


    clientsocket.close()

if __name__ == "__main__":

    host = 'localhost'
    port = 3000

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
