import 'package:dart_ping/dart_ping.dart';
import 'package:timer/application.dart';

void main(List<String> arguments) async {
  final application = Application();
  await application.start();
  final ping = Ping("server:5000", count: 5);
  print("toPing");

  // Begin ping process and listen for output
  ping.stream.listen((event) {
    print(event);
  });
  // while(true){}
}
