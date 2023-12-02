import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:timer_ui/di/bloc.dart';
import 'package:timer_ui/di/repository.dart';
import 'package:timer_ui/di/usecase.dart';
import 'package:timer_ui/di/utils.dart';
import 'package:timer_ui/features/timer/timer_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: blocs,
      dependencies: [
        ...repositories,
        ...usecases,
        ...utils,
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TimerPage(),
      ),
    );
  }
}
