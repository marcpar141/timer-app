import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:timer_ui/features/timer/presentation/timer_bloc.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<TimerBloc>(
          builder: (context, bloc) => Column(
            children: [
              Text(bloc.state.secondsLeft.toString()),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: bloc.stopTimer,
                    child: Text("Stop"),
                  ),
                  ElevatedButton(
                    onPressed: bloc.startTimer,
                    child: Text("Start"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
