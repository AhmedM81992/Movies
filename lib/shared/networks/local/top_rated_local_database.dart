import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class TopRatedLocalDatabase {
  static late Database _database;
  static bool _isDatabaseInitialized = false;

  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'top_rated_api_data.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE top_rated_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );

    _isDatabaseInitialized = true;
    return _database;
  }

  static Future<void> saveData(String data) async {
    final Database db = await database;
    await db.insert(
      'top_rated_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getData() async {
    if (!_isDatabaseInitialized) {
      print("Database is not initialized TopRatedLocalDatabase.");
      await initDatabase();
    }

    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('top_rated_api_data');
    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      if (DateTime.now().millisecondsSinceEpoch - timestamp <=
          24 * 60 * 60 * 1000) {
        print("Data is up to date for TopRatedLocalDatabase");
        return latestData['data'];
      }
    }
    print("Data Expired or Null for TopRatedLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await database;
    await db.delete('top_rated_api_data');
  }
}
