import 'package:flutter/cupertino.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/models/movie_model.dart';
import 'package:movieapp/src/core/repository/api.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MovieDatabase extends ChangeNotifier{
  static final MovieDatabase instance = MovieDatabase._init();
  static Database? _database;
  MovieDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('movie.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    // I could use a different location to store the data in the database;
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
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
  ${MovieFields.cast} $textType, 
  ${MovieFields.isFavorite} $boolType)
 '''
    );
    notifyListeners();
  }

  Future create() async {
    List<Movie> movies = [];
    await getMovies().then((value) => movies = value);
    final db = await instance.database;

    for (var movie in movies){
      await db.insert(movieTable, movie.toJson());
    }
    notifyListeners();
  }


  Future<List<Movie>> readAllMovies() async {
    final db = await instance.database;
    const orderBy = '${MovieFields.title} ASC';
    final result = await db.query(movieTable, orderBy: orderBy);
    movieList = result.map((json) => Movie.fromJson(json)).toList();
    notifyListeners();
    return movieList;

  }

  Future<List<Movie>> readFavoriteMovies() async {
    final db = await instance.database;
    const orderBy = '${MovieFields.title} ASC';
    final result = await db.query(movieTable, where: '${MovieFields.isFavorite} = 0',orderBy: orderBy);
    favoriteMovieList = result.map((json) => Movie.fromJson(json)).toList();
    notifyListeners();
    return favoriteMovieList;

  }

  Future<int> update(Movie movie) async {
    final db = await instance.database;
    return db.update(
      movieTable,
      movie.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [movie.id],
    ).whenComplete(() => notifyListeners());

  }

  Future close() async {
    final db = await instance.database;
    db.close();
    notifyListeners();
  }
}