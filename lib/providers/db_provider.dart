import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  // Contructor privado
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'gibt-db.db');

    // Crear la Base de datos
    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) async {
        //
      },
      onCreate: (Database db, int version) async {
        _createSchemaV2(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          _upgradeSchemaToV2(db);
        }
      },
      onDowngrade: (db, oldVersion, newVersion) {
        // Handle downgrades if necessary
      },
    );
  }

  void _upgradeSchemaToV2(Database db) async {
    await db.execute('''
      ALTER TABLE account_characters
        ADD COLUMN basic_talent_max_level INTEGER DEFAULT 9;
    ''');
    await db.execute('''
      ALTER TABLE account_characters 
        ADD COLUMN elemental_talent_max_level INTEGER DEFAULT 9;
    ''');
    await db.execute('''
      ALTER TABLE account_characters 
        ADD COLUMN burst_talent_max_level INTEGER DEFAULT 9;
    ''');
  }

  void _createSchemaV2(Database db) async {
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
        basic_talent_max_level INTEGER DEFAULT 9,
        elemental_talent_level INTEGER,
        elemental_talent_max_level INTEGER DEFAULT 9,
        burst_talent_level INTEGER,
        burst_talent_max_level INTEGER DEFAULT 9,
        weap_level TEXT,
        weap_rank INTEGER,
        is_building BOOLEAN
      );
    ''');
  }
}
