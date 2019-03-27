from flask import Flask
from config import DevConfig

app = Flask(__name__)
app.config.from_object(DevConfig)

myName = 'kai'

@app.route('/kai')
def index():
	return 'Hello World!i Kai' + myName
@app.route('/kai1')
def index1():
	return 'hey it is work'
if __name__ == '__main__':
	app.run()
