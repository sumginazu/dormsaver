import httplib, urllib
import json

class Watson:
    WATSON_INTERFACE_URI = "ghc47.ghc.andrew.cmu.edu"
    WATSON_INTERFACE_PORT = 8070
    watson_conn = httplib.HTTPConnection(WATSON_INTERFACE_URI, WATSON_INTERFACE_PORT)

    def ask(self, question):
        if question == '':
            question = 'Bad question' # TODO change this to return a default HTTP response
        question = urllib.quote(question)
        self.watson_conn.request("GET", "/qa/answer?q=" + question)
        return self.watson_conn.getresponse()

if __name__ == "__main__":
    #example use case
    watson = Watson()
    q = 'What is Carnegie Mellon University?'
    res = watson.ask(q)
    print res.status, res.reason
    text = res.read()
    json_res = json.loads(text)

    #pretty print
    print json.dumps(json_res, indent=4, separators=(',', ': '))
