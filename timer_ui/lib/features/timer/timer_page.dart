import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:timer_ui/features/timer/presentation/timer_bloc.dart';
import 'package:timer_ui/features/timer/presentation/timer_state.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("10 second count down timer"),
      ),
      body: SizedBox.expand(
        child: Center(
          child: Consumer<TimerBloc>(
            builder: (context, bloc) => Column(
              children: [
                Text(bloc.state.secondsLeft?.toString() ?? "nie wystartowało"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: bloc.state.timerStatus == TimerStatus.STOPPED
                          ? null
                          : bloc.stopTimer,
                      child: Text("Stop"),
                    ),
                    ElevatedButton(
                      onPressed: bloc.state.timerStatus == TimerStatus.RUNNING
                          ? null
                          : bloc.startTimer,
                      child: Text("Start"),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
