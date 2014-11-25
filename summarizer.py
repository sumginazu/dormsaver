import nltk, json, math
from nltk.util import ngrams

with open ("answer.txt", "r") as myfile:
    response=myfile.read().replace('\n', '')

with open("question.txt",'r') as myfile:
    question=myfile.read().replace('\n', '')

stopwords = nltk.corpus.stopwords.words('english')

def tfidf(word, corpus):
    #word is the candidate token
    #corpus is a list of tokenized (list of words) documents
    corpus = [ngrams(d, 2) for d in corpus]
    tfs = [1 if word in d else 0 for d in corpus]
    idf = math.log(len(corpus) / sum(tfs)) if sum(tfs) > 0 else 0
    res = [tf * idf for tf in tfs]
    return res

def get_important_bigrams(sen):
    #sen is a sentence
    words = nltk.word_tokenize(sen)
    res = [ (w1, w2) for (w1, w2) in ngrams(words, 2)
            if w1.lower() not in stopwords and w2.lower() not in stopwords ]
    return res

def summarize(json_o):
    #Extracts the relevant information from Watson's response.
    raw = (json_o["question"]["evidencelist"][0]["text"] + '\n' +
           json_o["question"]["evidencelist"][1]["text"] + '\n' +
           json_o["question"]["evidencelist"][2]["text"] )

    sentences = [s for s in nltk.sent_tokenize(raw) if len(s) > 1]
    t_sens = [nltk.word_tokenize(s) for s in sentences]
    q = json_o["question"]["questionText"]
    #print json["question"]
    #print json.dumps(json_o["question"], indent=4, separators=(',', ': '))
    q_grams = get_important_bigrams(q)
    #print q_grams
    scores = [tfidf(w, t_sens) for w in q_grams]
    #for s in scores:
    #    print s
    sen_scores = [sum(s) for s in zip(*scores)]
    #print sen_scores
    #best_index, best_value = max(enumerate(sen_scores), key=lambda p: p[1])
    best_index = max(xrange(len(sen_scores)), key=sen_scores.__getitem__)
    return sentences[best_index]
