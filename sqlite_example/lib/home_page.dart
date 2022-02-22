import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sqlite_example/database/database_sqlite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    _database();
    super.initState();
  }

  Future<void> _database() async {
    var database = await DatabaseSqLite().openConnection();

    // database.insert('teste', {'nome': 'Rodrigo Ferreira'});
    // database.delete('teste', where: 'nome = ?', whereArgs: ['Rodrigo Ferreira']);
    // database.update('teste', {'nome': 'Rodrigo Lindo'},where: 'nome = ?', whereArgs: ['Rodrigo Ferreira']);

    // var result = await database.query('teste');
    // log(result.toString());

    // database.rawInsert('insert into teste values(null, ?)', ["jairoEt"]);
    // database.rawUpdate('update teste set nome = ? where id = ?', ["jairoEtiii", 3]);
    // database.rawDelete('delete from teste where id = ?', [5]);

    var result = await database.rawQuery('select * from teste');
    log(result.toList().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Container(),
    );
  }
}
