import socketio

sio = socketio.Client()

@sio.event
def connect():
    print('Connected to the server')

@sio.event
def disconnect():
    print('Disconnected from the server')

if __name__ == '__main__':
    sio.connect('ws://127.0.0.1:5000', namespaces="/timer")
    sio.wait()
