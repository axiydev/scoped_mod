import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

/*
Mavzu::: ScopedModel
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ScopedModel<MyCounterModel>(
          model: MyCounterModel(count: 0),
          child: const HomePage(),
        ));
  }
}

class MyCounterModel extends Model {
  int? count;
  MyCounterModel({required this.count});

  void incremet() {
    count = count! + 1;
    notifyListeners();
  }

  void decrement() {
    count = count! - 1;
    notifyListeners();
  }

  static MyCounterModel? of(BuildContext context) {
    return ScopedModel.of<MyCounterModel>(context);
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    log('BUILDDD');
    final myModelProvider =
        ScopedModel.of<MyCounterModel>(context, rebuildOnChange: true);
    return Scaffold(
      body: SafeArea(
        child: Center(
            child: Text(
          myModelProvider.count.toString(),
          style: const TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.orange),
        )),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: '00',
            onPressed: () => myModelProvider.decrement(),
            child: const Icon(Icons.remove),
          ),
          const SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            heroTag: '111',
            onPressed: () => myModelProvider.incremet(),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
