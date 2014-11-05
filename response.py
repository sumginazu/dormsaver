import ask_watson as watson
import json

w = watson.Watson()

def get_best_answer(question):
    #Returns the first response given by Watson
    res = w.ask(question)
    if res.status != 200:
        return 'HTML Error ' + res.status
    json_res = json.loads(res.read())
    answers_ev = json_res['question']['evidencelist']
    answers = json_res['question']['answers']
    return answers[0]['text'] + '\n\n' + answers_ev[0]['text']
