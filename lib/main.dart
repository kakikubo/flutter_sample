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
      initialRoute: '/',
      routes: {
        '/': (context) => FirstPage(),
        '/second': (context) => SecondPage(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
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
  // final String? messageFromFirst;
  //
  // const SecondPage({Key? key, this.messageFromFirst}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var messageFromFirst = ModalRoute.of(context)?.settings.arguments;
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
