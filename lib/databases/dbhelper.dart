// import 'dart:io';

// import 'package:flutter_destroyer/models/soulland/tutiens.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';

// class DbHelper {
//   DbHelper._privateConstructor();
//   static final DbHelper instance = DbHelper._privateConstructor();

//   static Database? _db;
//   Future<Database> get db async => _db ??= await _initDb();

//   Future<Database> _initDb() async {
//     Directory document = await getApplicationDocumentsDirectory();
//     String path = join(document.path, 'dauladauluc.db');
//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _onCreate,
//     );
//   }

//   Future _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE daula(
//         id INTEGER PRIMARY KEY,
//         honsu TEXT,
//         honkhi REAL,
//         tuluyen INTEGER,
//         vohon TEXT,
//         honluc TEXT,
//         tinhthanluc TEXT,
//         honhoan TEXT,
//         congphap TEXT
//       )
//     ''');
//   }

//   Future drop() async {
//     await _db?.execute('''
//       DROP TABLE IF EXISTS daula
//     ''');
//   }

//   Future close() async {
//     await _db?.close();
//     _db = null;
//   }

//   Future<List<TuTien>> getTuTiens() async {
//     Database db = await instance.db;
//     var tutiens = await db.query('daula');
//     List<TuTien> tutienList = tutiens.isNotEmpty
//         ? tutiens.map((x) => TuTien.fromMap(x)).toList()
//         : [];
//     return tutienList;
//   }

//   Future add(TuTien tutien) async {
//     Database db = await instance.db;
//     await db.insert(
//       'daula',
//       tutien.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future remove(int id) async {
//     Database db = await instance.db;
//     await db.delete(
//       'daula',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future update(TuTien tutien) async {
//     Database db = await instance.db;
//     await db.update(
//       'daula',
//       tutien.toMap(),
//       where: 'id = ?',
//       whereArgs: [tutien.id],
//     );
//   }
// }
