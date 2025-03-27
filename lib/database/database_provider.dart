
import 'package:sqflite/sqflite.dart';

import '../model/tarefa.dart';

class DatabaseProvider {

  static const _dbNome = 'cadastro_tarefas.db';
  static const _dbVersion = 1;

  DatabaseProvider._init();

  static final DatabaseProvider instance = DatabaseProvider._init();

  Database? _database;

  Future<Database> get database async{
    if (_database == null){
      _database = await _initDataBase();
    }
    return _database!;
  }

  Future<Database> _initDataBase() async {
    String databasePath = await getDatabasesPath();
    String dbPath = '${databasePath}/${_dbNome}';
    return await openDatabase(
      dbPath,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async{
    await db.execute('''
    CREATE TABLE ${Tarefa.nomeTabela}(
    ${Tarefa.CAMPO_ID} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${Tarefa.CAMPO_DESCRICAO} TEXT NOT NULL,
    ${Tarefa.CAMPO_PRAZO} TEXT
    );
    ''');
  }

  Future<void> _onUpgrade( Database db, int newVersion, int oldVersion) async {

  }

  Future<void> close() async {
    if(_database != null){
      await _database!.close();
    }
  }
}