import 'package:flutter/material.dart';

class InputScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Список дел'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Готов делать себе заметки?',
              style: TextStyle(fontWeight: FontWeight.bold)),
          Center(
            child: ElevatedButton(
              child: Text('Вход'),
              onPressed: () {
                print('hello, dart');
                Navigator.pushNamedAndRemoveUntil(
                    context, '/todo', (route) => false);
              },
            ),
          ),
        ],
      ),
    );
  }
}
