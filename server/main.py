from flask import Flask
from flask_cors import CORS
from flask_socketio import SocketIO

from src.socket.namespaces.timer import TimerNamespace

# Flask app
app = Flask(__name__)
CORS(app)

# SocketIO
socketio = SocketIO(app, cors_allowed_origins="*", async_mode="gevent")
socketio.on_namespace(TimerNamespace())


if(__name__ == "__main__"):
    socketio.run(app, host='0.0.0.0', debug=False)
