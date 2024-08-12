import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:royal/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

// class DBHandler {
//   Database? _database;
//   String databaseName = 'mydatabase';
//   String tableName = 'DatabaseTable';
//   UserModel? userData;
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     //find path and create table
//     Directory directory = await getApplicationDocumentsDirectory();
//     String path = join(directory.path, 'mydatabase.db');
// // create table
//     _database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: (db, version) {
//         db.execute('''
//           CREATE TABLE DatabaseTable(
//           id INTEGER PRIMARY KEY,
//           name TEXT,
//           age INTEGER
//           )
//           ''');
//       },
//     );
//     return _database;
//   }

// // insert date in table
//   insertData(UserModel user) async {

//     Database? db = await database;
//     db!.insert(tableName, user.toJson());
//     print('text inserted');
//   }

// // read data of table
// Future<List<UserModel>> readData() async {
//   Database? db = await database;
//   // Check if the database is null to avoid potential null errors
//   if (db == null) {
//     throw Exception("Database is not initialized");
//   }
//   // Query the database table
//   List<Map<String, dynamic>> userData = await db.query(tableName);
//   // Convert the map to a list of UserModel objects
//   List<UserModel> users = userData.map((data) => UserModel.fromJson(data)).toList();

//   return users;
// }

//   deleteData(int id) async {
//     Database? db = await database;
//     await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
//   }

//   updateData(int id, String name, int age) async {
//     Database? db = await database;
//     db!.update(tableName, {'name': name, 'age': age},
//         where: 'id = ?', whereArgs: [id]);
//   }
// }
class DBHandler {
  Database? _database;
  String databaseName = 'mydatabase';
  String userTable = 'Users';
  String productTable ='Products';
  Future<Database?> get database async {
    if (_database != null) return _database;

    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'mydatabase.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE Users(
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER
          )
        ''');
        db.execute('''
          CREATE TABLE Products(
          id INTEGER PRIMARY KEY,
          productName TEXT,
          price REAL
          )
        ''');
      },
    );
    return _database;
  }

  // Generic method to insert data
  Future<void> insertData(String tableName, Map<String, dynamic> data) async {
    Database? db = await database;
    await db!.insert(tableName, data);
  }

  // Generic method to read data
  Future<List<Map<String, dynamic>>> readData(String tableName) async {
    Database? db = await database;
    List<Map<String, dynamic>> data = await db!.query(tableName);
    return data;
  }

  // Generic method to delete data
  Future<void> deleteData(String tableName, int id) async {
    Database? db = await database;
    await db!.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  // Generic method to update data
  Future<void> updateData(
      String tableName, int id, String name , int age) async {
    Database? db = await database;
    await db!.update(tableName, {
      'name' : name,
      'age' : age,
    }, where: 'id = ?', whereArgs: [id]);
  }
}
