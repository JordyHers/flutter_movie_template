import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/database/movie_database.dart';

import 'package:movieapp/src/core/utils/size_config.dart';
import 'package:movieapp/src/ui/theme/theme.dart';
import 'package:movieapp/src/ui/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatefulWidget {
  final MovieDatabase database;
  const MoviePage({Key? key,required this.database}) : super(key: key);

  /// The [context]  here is the context of the JobsPage
  ///
  /// as the result we can get the provider of Database
  static create(BuildContext context)  {
    final database = Provider.of<MovieDatabase>(context,listen: false);
    return  ChangeNotifierProvider<MovieDatabase>(
      create: (context) => MovieDatabase.instance,
      child: Consumer<MovieDatabase>(
        builder: (context, model, child) => MoviePage(database: database),
      ),
    );

  }
  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  MovieDatabase get database => widget.database;

  @override
  void dispose() {
    database.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return  CupertinoPageScaffold(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    bottom: PreferredSize(preferredSize: Size(SizeConfig.screenWidth!,0.5),
                    child: Container(color: inactiveColor,height: 1),),
                    elevation: 0,
                    backgroundColor: Theme
                        .of(context)
                        .appBarTheme
                        .backgroundColor,
                    expandedHeight: SizeConfig.screenHeight! * 0.10,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      title: Text(UiText.appTitle, style: TextStyle(color: Theme
                          .of(context)
                          .textTheme
                          .bodyText1
                          ?.color),),
                    ),
                  ),

                  SliverPadding(
                    padding:  EdgeInsets.only(bottom: SizeConfig.screenHeight! * 0.15),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: movieList.length,
                              (BuildContext context, int index) {
                            return MovieCard(movie: movieList[index]);
                          }
                      ),
                    ),
                  ),
                ],
                // This trailing comma makes auto-formatting nicer for build methods.
              ));

  }


}
