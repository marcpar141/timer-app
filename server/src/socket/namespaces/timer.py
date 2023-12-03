import json

from flask import request
from flask_socketio import join_room, leave_room
from flask_socketio.namespace import Namespace
from typing import Union, Dict


class TimerNamespace(Namespace):
    def __init__(self):
        super().__init__("/timer")
        self.timer_control_event_name = "control"
        self.timer_state_event_name = "state"

    def on_connect(self):
        if self.__is_system_client():
            return
        sid = self.__get_sid()
        join_room(sid)
        self.emit(self.timer_control_event_name, json.dumps({"command": "start", "roomName": sid}))

    def on_state(self, state: Dict[str, Union[int, str]]):
        state = json.loads(state)
        room_name = self.__get_room_name_from_state(state)
        if room_name is None:
            return
        time = self.__get_time_from_state(state)
        self.emit(self.timer_state_event_name, json.dumps(time), room_name)

    def on_disconnect(self):
        if self.__is_system_client():
            return
        sid = self.__get_sid()
        leave_room(sid)
        self.emit(self.timer_control_event_name, json.dumps({"command": "stop", "roomName": sid}))

    def __get_sid(self) -> str:
        return request.sid

    def __is_system_client(self) -> bool:
        return True if self.__get_system_client_info() is not None else False

    def __get_system_client_info(self) -> Union[str, None]:
        return request.headers.environ.get('HTTP_CLIENT')

    def __get_time_from_state(self, state: Dict[str, Union[int, str]]) -> Union[Dict[str, int], None]:
        time = state.get("time", 120)
        return {"time": time} if time is not None else None

    def __get_room_name_from_state(self, state: Dict[str, Union[int, str]]) -> Union[str, None]:
        return state.get("roomName")
