from amazonproduct import API
import nltk

api = API(locale='us')

# get all books from result set and
# print author and title
items = api.item_search('Electronics', Keywords = "xbox one", limit=1)


"""a = "what is the iPhone like?"
b = nltk.word_tokenize(a)

c = nltk.pos_tag(b)
print c
d = filter(lambda (a,b): b == 'NNP' or  b == 'NN', c)

print d[0][0]

"""

f = open("recommendations.txt", "w")
count = 0

for item in items:
    a = item.ASIN
    result = api.item_lookup(str(a))
    
    for i in result.Items.Item:
        print '%s (%s) in group' % (i.ItemAttributes.Title, i.ASIN)
    try:
        result = api.similarity_lookup(str(a))
        for b in result.Items.Item:
            print '%s (%s)' % (b.ItemAttributes.Title, b.ASIN)
            image = api.item_lookup(str(b.ASIN), ResponseGroup = "Images")
            for i in image.Items.Item:
                print '%s' % i.LargeImage.URL
                f.write("%s $ %s\n" % (b.ItemAttributes.Title, i.LargeImage.URL))
                
    except:
        print "error"

f.close()
