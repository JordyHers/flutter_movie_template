
/// The following fields are necessary to access the correct path in the database
/// Please refer to [sqflite] documentation for more details

class MovieFields {
  static final List<String> values = [
    /// Add all fields
    id, backdrop, classification, director, genres,
    imdb_rating,title,poster,released_on,length,slug,overview,cast,isFavorite
  ];
  static const String id = 'id';
  static const String backdrop = 'backdrop';
  static const String classification = 'classification';
  static const String  director = 'director';
  static const String genres = 'genres' ;
  static const String imdb_rating = 'imdb_rating';
  static const String title = 'title';
  static const String poster = 'poster';
  static const String released_on = 'released_on';
  static const String length ='length';
  static const String slug = 'slug';
  static const String overview = 'overview';
  static const String cast = 'cast';
  static const String isFavorite = 'isFavorite';


}



/// The package [Freezed] was downloaded and could be used to ensure the format
/// of the model is not altered.
///
/// In this case use flutter run build_runner --watch --conflicting-outputs

class Movie  {
   Movie({
      this.id,
     required this.backdrop,
     this.classification,
     this.director,
     required this.cast,
     required this.genres,
     this.imdb_rating,
     required this.title,
     this.poster,
     this.released_on,
     this.length,
     this.slug,
     this.overview,
     this.isFavorite = 1
  }) ;

  final String? id;
  final String? backdrop;
  final String? classification;
  final dynamic  director;
  final dynamic genres;
  final double? imdb_rating;
  final String? title;
  final String? poster;
  final String? released_on;
  final String? length;
  final String? slug;
  final String? overview;
  final dynamic cast;
  final int isFavorite;


      factory Movie.fromJson(Map<String, dynamic> json) {
        final String? id = json['id'] ;
        final String? backdrop = json['backdrop'];
        final String? classification = json['classification'];
        final dynamic director = json['director'] ;
        final dynamic genres = json['genres'];
        final double? imdbRating = json['imdb_rating'];
        final String? title = json['title'];
        final String? poster = json['poster'];
        final String? releasedOn = json['released_on'];
        final  String? length = json['length'];
        final String? slug = json['slug'];
        final String? overview= json['overview'];
        final dynamic cast = json['cast'];
        final int  isFavorite = json['isFavorite'] ?? 1;



        return Movie(
          id: id,
          backdrop: backdrop,
          classification: classification,
          director: director,
          genres: genres,
          imdb_rating: imdbRating,
          title: title,
          poster: poster,
          released_on: releasedOn,
          length: length,
          slug: slug,
          overview: overview,
          cast: cast.toString(),
          isFavorite: isFavorite,
        );
  }
   Movie copy({
     final String? id,
     final String? backdrop,
     final String? classification,
     final dynamic  director,
     final List<dynamic>? genres,
     final double? imdb_rating,
     final String? title,
     final String? poster,
     final String? released_on,
     final String? length,
     final String? slug,
     final String? overview,
     final List<dynamic>? cast,
     final int? isFavorite,
   }) =>
       Movie(
         id: id ?? this.id,
         backdrop: backdrop ?? this.backdrop,
         classification: classification ?? this.classification,
         director: director ?? this.director,
         genres: genres ?? this.genres,
         imdb_rating: imdb_rating ?? this.imdb_rating,
         title: title ?? this.title,
         poster: poster ?? this.poster,
         released_on: released_on ?? this.released_on,
         length: length ?? this.length,
         slug: slug ?? this.slug,
         overview: overview ?? this.overview,
         cast: cast ?? this.cast,
         isFavorite: isFavorite ?? this.isFavorite,
       );

   Map<String, Object?> toJson() => {
     MovieFields.id: id,
     MovieFields.title: title,
     MovieFields.backdrop: backdrop,
     MovieFields.classification: classification,
     MovieFields.director: director.toString(),
     MovieFields.genres: genres.toString(),
     MovieFields.imdb_rating: imdb_rating,
     MovieFields.poster: poster,
     MovieFields.released_on: released_on,
     MovieFields.length: length,
     MovieFields.slug: slug,
     MovieFields.overview: overview,
     MovieFields.cast: cast.toString(),
     MovieFields.isFavorite: isFavorite,

   };

   @override
   String toString() =>
       'id: $id , backdrop: $backdrop , classification:$classification} , director:$director ,genres:$genres ,isFavorite: $isFavorite';
}



