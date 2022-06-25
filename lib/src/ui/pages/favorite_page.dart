import 'package:flutter/material.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/database/movie_database.dart';
import 'package:movieapp/src/core/utils/size_config.dart';
import 'package:movieapp/src/ui/widgets/movie_card.dart';
import 'package:provider/provider.dart';

import '../../core/models/movie_model.dart';


class FavoritePage extends StatefulWidget {
  final MovieDatabase database;
   const FavoritePage({Key? key,required this.database}) : super(key: key);

  static Widget create(BuildContext context) {
      final database = Provider.of<MovieDatabase>(context,listen: false);
      return  ChangeNotifierProvider<MovieDatabase>(
        create: (_) => MovieDatabase.instance,
        child: Consumer<MovieDatabase>(
          builder: (context, model, child) => FavoritePage(database: database),
        ),
      );
  }



  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  MovieDatabase get database => widget.database;


  @override
  void dispose() {
    database.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _buildContents(context);
  }

  Widget _buildContents(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body:  CustomScrollView(
        physics: BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  elevation: 0,
                  centerTitle: true,
                  backgroundColor: Theme
                      .of(context)
                      .appBarTheme
                      .backgroundColor,
                  expandedHeight: SizeConfig.screenHeight! * 0.10,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: Text(UiText.favoriteTitle, style: TextStyle(color: Theme
                        .of(context)
                        .textTheme
                        .bodyText1
                        ?.color),),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      childCount: favoriteMovieList.length,
                          (BuildContext context, int index) {
                        return MovieCard(movie: favoriteMovieList[index]);
                      }
                  ),
                ),

              ],
            )

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
