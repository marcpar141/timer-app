from flask import Flask
from flask_cors import CORS
from flask_socketio import SocketIO


app = Flask(__name__)
socketio = SocketIO(app)
CORS(app)


if(__name__ == "__main__"):
    socketio.run(app, host='0.0.0.0', debug=False)
