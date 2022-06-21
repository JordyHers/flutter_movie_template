import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/models/movie_model.dart';



Map<String, String> get headers => {
  "Content-Type": "application/json",
  "Accept": "application/json",
  "Authorization": ApiPath.authorization,
};
///This function returns The list of Albums from The Api
@override
Future <List<Movie>> getMovies() async {
  var data = await http.get(Uri.parse(ApiPath.endpoint),headers: headers);
  var jsonData = json.decode(data.body);
  List<Movie> movies =[];
  var movieData = jsonData['movies'];
  for (var mov in movieData){
    Movie movie = Movie.fromJson(mov);
    movies.add(movie);
  }

    return movies;
}