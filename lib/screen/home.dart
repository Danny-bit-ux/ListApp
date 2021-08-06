import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _userTodo;
  List todoList = [];

  void initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  void initState() {
    super.initState();

    initFirebase();

    todoList.addAll(['Buy Milk', 'Wash dishes', 'Buy Kartofan']);
  }

  void _menuOpen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text('Меню')),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/', (route) => false);
                    },
                    child: Text('Нажми'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        title: Text("Список дел"),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.menu_outlined), onPressed: _menuOpen),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (!snapshots.hasData) return Text('Нет записей');
          return ListView.builder(
            itemCount: snapshots.data.docs.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(snapshots.data.docs[index].id),
                child: Card(
                  child: ListTile(
                    title: Text(
                      snapshots.data.docs[index].get('item'),
                    ),
                    trailing: IconButton(
                        icon:
                            Icon(Icons.delete_sweep, color: Colors.amberAccent),
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('items')
                              .doc(snapshots.data.docs[index].id)
                              .delete();
                        }),
                  ),
                ),
                onDismissed: (direction) {
                  FirebaseFirestore.instance
                      .collection('items')
                      .doc(snapshots.data.docs[index].id)
                      .delete();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Добавить задание.'),
                  content: TextField(
                    onChanged: (String value) {
                      _userTodo = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        FirebaseFirestore.instance
                            .collection('items')
                            .add({'items': _userTodo});
                        Navigator.of(context).pop();
                      },
                      child: Text('Добавить'),
                    ),
                  ],
                );
              });
        },
        child: Icon(Icons.add_box, color: Colors.white),
        backgroundColor: Colors.amberAccent,
      ),
    );
  }
}
