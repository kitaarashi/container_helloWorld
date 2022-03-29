from bottle import route, run

@route('/')
def hello():
    return "Hello World!!!!!!!\n"

run(host='0.0.0.0', port=8000, debug=True)