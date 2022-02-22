import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  // Future<Database> openConnection() async {

  Future<Database> openConnection() async {
    final databasepath = await getDatabasesPath();
    final databaseFinalPath = join(databasepath, 'SQLITE_EXAMPLE');

    return await openDatabase(
      databaseFinalPath,
      version: 1,
      onConfigure: (db) async {
        log("chamado");
        await db.execute('PRAGMA foreign_keys =ON');
      },
      // Chamado somente no momento de criação do banco de dados
      // Primeira vez que carrega o aplicativo
      onCreate: (db, version) {
        log(" Create Chamado");
        final batch = db.batch();
        batch.execute(
            'create table teste(id Integer primary key autoincrement, nome varchar(200))');

        batch.execute(
            'create table produto(id Integer primary key autoincrement, nome varchar(200))');

        batch.execute(
            'create table categoria(id Integer primary key autoincrement, nome varchar(200))');

        log(batch.toString());
        batch.commit();
      },
      // Será chamado sempre que ouver uma lateração no version incrementa 1 -> 2
      onUpgrade: (db, oldVersion, newVersion) {
        log("onUpgrade Chamado");
        final batch = db.batch();
        if (oldVersion == 1) {
          batch.execute(
              'create table produto(id Integer primary key autoincrement, nome varchar(200))');

          batch.execute(
              'create table categoria(id Integer primary key autoincrement, nome varchar(200))');
        }

        if (oldVersion == 2) {
          batch.execute(
              'create table categoria(id Integer primary key autoincrement, nome varchar(200))');
        }

        batch.commit();
      },
      // Será chamado sempre que ouver uma alteração no version descremental 2 -> 1
      onDowngrade: (db, oldVersion, newVersion) {
        log("onDowgrade Chamado");
        final batch = db.batch();
        if (oldVersion == 3) {
          batch.execute('drop table categoria');
        }

        batch.commit();
      },
    );
  }
}
