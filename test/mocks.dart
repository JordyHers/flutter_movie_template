import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/database/movie_database.dart';
import 'package:movieapp/src/core/models/movie_model.dart';
import 'package:sqflite/sqflite.dart';


class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockSqfliteDatabase extends Mock implements Database {}

class MockMovieDatabase extends Mock implements MovieDatabase {

  static final MockMovieDatabase instance = MockMovieDatabase._init();
  static MockSqfliteDatabase? _database;

  MockMovieDatabase._init();


  Future<MockSqfliteDatabase> get database async {
    if (_database != null) return _database!;
    _database = (await _initDB('movie.db')) as MockSqfliteDatabase?;
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // I could use a different location to store the data in the database;
    final dbPath = await getDatabasesPath();
    final path = 'join(dbPath, filePath)';
    return await openDatabase(path, version: 1, onCreate: _createDB,);
  }
  Future _createDB(Database db, int version) async {
    const idType = 'TEXT NOT NULL PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const doubleType = 'REAL NOT NULL';


    await db.execute('''
      CREATE TABLE $movieTable( 
      ${MovieFields.id} $idType, 
      ${MovieFields.backdrop} $textType, 
      ${MovieFields.classification} $textType, 
      ${MovieFields.director} $textType, 
      ${MovieFields.genres} $textType, 
      ${MovieFields.imdb_rating} $doubleType, 
      ${MovieFields.title} $textType, 
      ${MovieFields.poster} $textType, 
      ${MovieFields.released_on} $textType, 
      ${MovieFields.length} $textType, 
      ${MovieFields.slug} $textType, 
      ${MovieFields.overview} $textType, 
      ${MovieFields.isFavorite} $boolType)
 '''
    );
    notifyListeners();
  }


  @override
  Future<int> update(Movie movie) async {
    bool result = false;
    final db = await instance.database;
    db.update(
      movieTable,
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    ).whenComplete(() => notifyListeners()).then((value) => result = true);
     if(result) {return 0;}
     else {return 1;}
  }
}

/// Mock Movie to test
 class MockModel {
   Movie get movie => _movie;

   Movie _movie = Movie(
     id: '0000000',
     backdrop: 'backdrop',
     classification: 'classification',
     director: 'director',
     genres: 'genres',
     imdb_rating: 9.0,
     title: "title",
     poster: "poster",
     released_on: "releasedOn",
     length: "length",
     slug: "slug",
     overview: 'overview',
     cast: 'cast.toString()',
     isFavorite: 1,
   );
 }
