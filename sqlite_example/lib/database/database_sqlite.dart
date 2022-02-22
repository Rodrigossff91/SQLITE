import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseSqLite {
  // Future<Database> openConnection() async {

  Future<void> openConnection() async {
    final databasepath = await getDatabasesPath();
    final databaseFinalPath = join(databasepath, 'SQLITE_EXAMPLE');

    openDatabase(
      databaseFinalPath,
      version: 1,
      // Chamado somente no momento de criação do banco de dados
      // Primeira vez que carrega o aplicativo
      onCreate: (db, version) {
        print("Chamado");
        final batch = db.batch();
        batch.execute(
            'create table teste(id Integer primary key autoincrement, nome varchar(200))');

        print(batch);
        batch.commit();
      },
      // Será chamado sempre que ouver uma lateração no version incrementa 1 -> 2
      onUpgrade: (db, oldVersion, newVersion) {},
      // Será chamado sempre que ouver uma alteração no version descremental 2 -> 1
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
