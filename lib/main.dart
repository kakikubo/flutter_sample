import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/second') {
          String? messageFromFirst = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) {
              return SecondPage(messageFromFirst: messageFromFirst);
            },
          );
        }
        return null;
      },
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First Page')),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            var message = await Navigator.pushNamed(
              context,
              '/second',
              arguments: 'messageFromFirst',
            );
            print(message);
          },
          child: const Text('Next Page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String? messageFromFirst;

  const SecondPage({Key? key, required this.messageFromFirst})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(messageFromFirst);
    return Scaffold(
      appBar: AppBar(title: Text(messageFromFirst as String)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context, 'Go Back from SecondPage');
          },
          child: const Text('Go back'),
        ),
      ),
    );
  }
}
