import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Avoid errors caused by flutter upgrade.
  // Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'flights_database.db'),
    // When the database is first created, create a table to store dogs.
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE flights(id INTEGER PRIMARY KEY, note TEXT, datetime INTEGER)",
      );
    },
    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    version: 1,
  );

  Future<void> insertFlight(Flight flight) async {
    // Get a reference to the database.
    final Database db = await database;

    // Insert the Dog into the correct table. Also specify the
    // `conflictAlgorithm`. In this case, if the same dog is inserted
    // multiple times, it replaces the previous data.
    await db.insert(
      'flights',
      flight.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Flight>> flights() async {
    // Get a reference to the database.
    final Database db = await database;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> maps = await db.query('flights');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(maps.length, (i) {
      return Flight(
        id: maps[i]['id'],
        note: maps[i]['note'],
        datetime: maps[i]['datetime'],
      );
    });
  }

  Future<void> updateFlight(Flight flight) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given Dog.
    await db.update(
      'flight',
      flight.toMap(),
      // Ensure that the Dog has a matching id.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [flight.id],
    );
  }

  Future<void> deleteFlight(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'flights',
      // Use a `where` clause to delete a specific dog.
      where: "id = ?",
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  var fido = Flight(
    id: 0,
    note: 'Startabbruch',
    datetime: 35,
  );

  // Insert a dog into the database.
  await insertFlight(fido);

  // Print the list of dogs (only Fido for now).
  print(await flights());

  // Update Fido's age and save it to the database.
  fido = Flight(
    id: fido.id,
    note: fido.note,
    datetime: fido.datetime + 7,
  );
  await updateFlight(fido);

  // Print Fido's updated information.
  print(await flights());

  // Delete Fido from the database.
  await deleteFlight(fido.id);

  // Print the list of dogs (empty).
  print(await flights());
}

class Flight {
  final int id;
  final String note;
  final int datetime;

  Flight({this.id, this.note, this.datetime});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'note': note,
      'datetime': datetime,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Flight{id: $id, note: $note, datetime: $datetime}';
  }
}