from flask_script import Manager, Server
from main import app
#set my app
manager = Manager(app)
# set command to server
manager.add_command('runserver', Server())
# shell
@manager.shell
def make_shell_context():
	return dict(app=app)
if __name__ == '__main__':
	manager.run()
