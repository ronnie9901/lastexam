import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


import '../modal/expense_modal.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('contacts.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phoneNumber TEXT,
        email TEXT,
        category TEXT,
        isFavorite INTEGER
      )
    ''');
  }

  Future<int> addContact(Contact contact) async {
    final db = await instance.database;
    return await db.insert('contacts', contact.toMap());
  }

  Future<List<Contact>> getContacts() async {
    final db = await instance.database;
    final result = await db.query('contacts');
    return result.map((map) => Contact.fromMap(map)).toList();
  }

  Future<int> updateContact(Contact contact) async {
    final db = await instance.database;
    return await db.update('contacts', contact.toMap(),
        where: 'id = ?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(int id) async {
    final db = await instance.database;
    return await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAllContacts() async {
    final db = await instance.database;
    await db.delete('contacts');
  }
}