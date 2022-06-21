import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:movieapp/src/core/models/movie_model.dart';
import 'package:movieapp/src/core/utils/size_config.dart';
import 'package:movieapp/src/ui/pages/movie_detail_page.dart';
import 'package:movieapp/src/ui/theme/theme.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      height: SizeConfig.screenHeight! * 0.15,
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: SizeConfig.smallPadding),
        child: GestureDetector(
          onTap: () {
            showCupertinoModalBottomSheet(
              /// We set the useRootNavigator to true to remove the [CupertinoBottomBar]
              useRootNavigator: true,
              duration: const Duration(milliseconds: 400),
              context: context,
              builder: (context) =>
                  MovieDetailPage(context: context, movie: movie),
            );
          },
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin:  EdgeInsets.symmetric(
                      horizontal: SizeConfig.smallPadding, vertical:
                  SizeConfig.screenHeight! * 0.005),

                  width: SizeConfig.screenWidth! * 0.25,
                  decoration: BoxDecoration(
                    color: textColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(movie.poster!),
                        fit: BoxFit.fitWidth
                    ),
                  ),
                ),

                //Title Box
                Padding(
                  padding:  EdgeInsets.symmetric(
                      vertical: SizeConfig.screenHeight! * 0.005),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_parseListOfGenresIntoString(movie.genres), style: Theme
                          .of(context)
                          .textTheme
                          .caption,),
                      SizedBox(height: SizeConfig.screenHeight! * 0.010),
                      SizedBox(
                          height: SizeConfig.screenHeight! * 0.05,
                          width: SizeConfig.screenWidth! * 0.45,
                          child: Text(movie.title!, style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2, maxLines: 2,)),
                    ],
                  ),
                ),
                const Spacer(flex: 3),
                const Icon(Icons.arrow_forward_ios,),
                const Spacer(flex: 1),
              ]),
        ),
      ),


    );
  }

  /// This Functions takes care of parsing the list of
  /// genres obtained into a string [RegEx] could be used here to
  /// Refer to documentation if needed.

  String _parseListOfGenresIntoString(genres) {
    String result = genres.toString().replaceAll('[','')
        .replaceAll(']', '').replaceAll(',', ' |');
    return result;
  }


}
