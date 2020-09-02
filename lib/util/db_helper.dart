import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flights_app/models/flight.dart';

class DbHelper {
  final int version = 1;
  Database db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'flights.db'),
          onCreate: (database, version) {
            database.execute(
              'CREATE TABLE flights(id INTEGER PRIMARY KEY, note TEXT, datetime INTEGER)');
      }, version: version);
    }
    return db;
  }

  Future<List<Flight>> getFlightList() async {
    final List<Map<String, dynamic>> maps = await db.query('flights');

    return List.generate(maps.length, (i) {
      return Flight (
        maps[i]['id'],
        maps[i]['note'],
        maps[i]['datetime'],
      );
    });
  }

  // retrieve all flights
  Future<List<Flight>> getFlights() async {
    final List<Map<String, dynamic>> maps = await db.query('flights', orderBy: "datetime DESC");

    return List.generate(maps.length, (i) {
      return Flight (
        maps[i]['id'],
        maps[i]['note'],
        maps[i]['datetime'],
      );
    });
  }

  // count todays flights
  Future getFlightsToday() async {
    final DateTime now = DateTime.now();
    final int dateTodayBeginning = new DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;

    final int retVal = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM flights WHERE datetime > ' + dateTodayBeginning.toString())); //await db.query('flights', orderBy: "datetime DESC");
    return retVal;
  }

  // insert a new flight
  Future<int> insertFlight(Flight flight) async {
    int id = await this.db.insert(
      'flights',
      flight.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  Future<int> updateFlight(Flight flight) async {
    int result = await db.update("flights", flight.toMap(), where: "id = ?", whereArgs: [flight.id]);
    return result;
  }

  Future<int> deleteFlight(Flight flight) async {
    int result = await db.delete("flights", where: "id = ?", whereArgs: [flight.id]);
    return result;
  }
}
