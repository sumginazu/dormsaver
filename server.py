from socket import *
import thread
import requests
import json
import unicodedata
from amazonproduct import API
import nltk

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

            # get all books from result set and
            # print author and title
            items = api.item_search('Electronics', Keywords = query, limit=1)



            for item in items:
                a = item.ASIN
                result = api.item_lookup(str(a))
                #print '%s %s' % (item.ItemAttributes.Title, item.ASIN)
                try:
                    result = api.similarity_lookup(str(a))
                except:
                    print "error"
                print u"%s" % (result.Items.Item.ItemAttributes.Title)  

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
