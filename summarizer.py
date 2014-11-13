import nltk

with open ("answer.txt", "r") as myfile:
    response=myfile.read().replace('\n', '')

with open("question.txt",'r') as myfile:
    question=myfile.read().replace('\n', '')


