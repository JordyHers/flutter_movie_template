import 'package:movieapp/src/core/models/movie_model.dart';


/// The following values are set to be globally accessed.
/// The movieList will contain the list of movies gotten from
/// the Movie Database Function
List<Movie> movieList = [];
List<Movie> favoriteMovieList = [];

/// The String table is the name of the movie
/// stored in the local database
const String movieTable = 'movies';

class ApiPath {
  static const String endpoint = 'https://wookie.codesubmit.io/movies';
  static const String authorization = 'Bearer Wookie2021';
  static const String tempImage = 'https://turkcealtyazi.org/images/poster/6285944.jpg';
}

/// The Class UiText provides Strings in case
/// Local Lang. Localization is implemented the strings can easily be accessed
//
class UiText {
  static const String buttonFavAdd = 'Add to favorites';
  static const String buttonFavAddedToFavorite = 'Added to favorites';
  static const String buttonFavRemove = 'Remove from favorites';
  static const String buttonFromFavRemove = 'From favorites removed';
  static const String appTitle = 'Movies';
  static const String favoriteTitle = 'My Favorites';
}

