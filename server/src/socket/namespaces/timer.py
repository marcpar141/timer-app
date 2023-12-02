from flask import request
from flask_socketio.namespace import Namespace


class TimerNamespace(Namespace):
    def __init__(self):
        super().__init__("/timer")

    def on_connect(self):
        print(f"{self.__get_sid()} connected!")

    def on_disconnect(self):
        print(f"{self.__get_sid()} disconnected!")

    def __get_sid(self) -> str:
        return request.sid
