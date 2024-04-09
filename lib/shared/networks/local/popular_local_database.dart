import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PopularLocalDatabase {
  static late Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'popular_api_data.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE popular_api_data(id INTEGER PRIMARY KEY, data TEXT, timestamp INTEGER)",
        );
      },
    );

    return _database;
  }

  static Future<void> saveData(String data) async {
    final Database db = await database;
    await db.insert(
      'popular_api_data',
      {'data': data, 'timestamp': DateTime.now().millisecondsSinceEpoch},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<String?> getData() async {
    final Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('popular_api_data');
    if (maps.isNotEmpty) {
      Map<String, dynamic> latestData = maps.first;
      int timestamp = latestData['timestamp'];
      if (DateTime.now().millisecondsSinceEpoch - timestamp <=
          24 * 60 * 60 * 1000) {
        print("Data is up to date for PopularLocalDatabase");
        return latestData['data'];
      }
    }
    print("Data Expired or Null for PopularLocalDatabase!");
    return null;
  }

  static Future<void> deleteData() async {
    final Database db = await database;
    await db.delete('popular_api_data');
  }
}
