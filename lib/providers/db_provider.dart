import 'dart:developer';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:gibt_1/models/models.dart';

class DBProvider {

  static Database? _database;
  static final DBProvider db = DBProvider._();

  // Contructor privado
  DBProvider._();

  Future<Database> get database async {
    if(_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {

    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentsDirectory.path, 'gibt-db.db');
    log(path);

    // Crear la Base de datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) async {
        //
      },
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS accounts (
            id INTEGER PRIMARY KEY,
            name TEXT,
            server TEXT,
            is_active BOOLEAN
          );
        ''');
        await db.execute('''
          CREATE TABLE IF NOT EXISTS account_characters (
            id INTEGER PRIMARY KEY,
            account_id INTEGER,
            character_id TEXT,
            weapon_id TEXT,
            level TEXT,
            constellations INTEGER,
            basic_talent_level INTEGER,
            elemental_talent_level INTEGER,
            burst_talent_level INTEGER,
            weap_level TEXT,
            weap_rank INTEGER,
            is_building BOOLEAN
          );
        ''');
      },
    );

  }

}