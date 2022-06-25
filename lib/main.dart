import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/database/movie_database.dart';
import 'package:movieapp/src/ui/pages/home_page.dart';
import 'package:movieapp/src/ui/theme/theme.dart';
import 'package:provider/provider.dart';

 main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// After Making sure the app is correctly initialized the
  /// future functions are triggered before
  /// [runApp()] is called. The functions take care of:
  /// 1. Fetching Json file.
  /// 2. Creating database
  /// 3. Loading database with json converted
    MovieDatabase.instance.create().whenComplete(() =>
        MovieDatabase.instance.readAllMovies().whenComplete(() =>
            MovieDatabase.instance.readFavoriteMovies())
   ).whenComplete(() => runApp(const MyApp()));

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    /// The [ListenableProvider] has been chosen in the current example
    /// to provide both [create] and [dispose] functions
    /// Make Sure the Main root provider is either
    /// Listenable Provider
    /// ChangeNotifierProvider
    return ListenableProvider<MovieDatabase>(
      create:(context)=> MovieDatabase.instance,
      dispose: (_,database) => database.close(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: UiText.appTitle,
        theme: AppTheme.appTheme,
        home:  HomePage(),
      ),
    );
  }
}


