from flask import request
from flask_socketio import SocketIO, join_room
from flask_socketio.namespace import Namespace
from typing import Union


class TimerNamespace(Namespace):
    def __init__(self):
        super().__init__("/timer")
        self.socketio: SocketIO = self.socketio
        self.timer_control_event_name = "control"

    def on_connect(self):
        if self.__is_system_client():
            return
        sid = self.__get_sid()
        join_room(sid)
        self.socketio.emit(self.timer_control_event_name, {"command": "start", "roomName": sid})

    def on_disconnect(self):
        print(f"{self.__get_sid()} disconnected!")

    def __get_sid(self) -> str:
        return request.sid

    def __is_system_client(self) -> bool:
        return True if self.__get_system_client_info() is not None else False

    def __get_system_client_info(self) -> Union[str, None]:
        return request.headers.environ.get('HTTP_CLIENT')
