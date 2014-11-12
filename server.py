from socket import *
import thread
import requests
import json
import unicodedata

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
            f = open("answer.txt", 'w')
            m = msg.encode('ascii','ignore')
            f.write(m)
            f.close()
            clientsocket.send(msg)
    clientsocket.close()

if __name__ == "__main__":

    host = 'localhost'
    port = 3001

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
