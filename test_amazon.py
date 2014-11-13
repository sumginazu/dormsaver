from amazonproduct import API
import nltk

api = API(locale='us')

# get all books from result set and
# print author and title
items = api.item_search('Electronics', Keywords = "xbox one", limit=1)


a = "what is the iPhone like?"
b = nltk.word_tokenize(a)

c = nltk.pos_tag(b)
print c
d = filter(lambda (a,b): b == 'NNP' or  b == 'NN', c)

print d[0][0]

"""
for item in items:
    a = item.ASIN
    result = api.item_lookup(str(a))
    #print '%s %s' % (item.ItemAttributes.Title, item.ASIN)
    try:
        result = api.similarity_lookup(str(a))
    except:
        print "error"
    print u"%s" % (result.Items.Item.ItemAttributes.Title)
    """
