import tornado.ioloop
import tornado.web
import pprint

class MyDumpHandler(tornado.web.RequestHandler):
    def post(self):
        pprint.pprint(self.request)

if __name__ == "__main__":
    tornado.web.Application([(r"/.*", MyDumpHandler),]).listen(8080)
    tornado.ioloop.IOLoop.instance().start()
