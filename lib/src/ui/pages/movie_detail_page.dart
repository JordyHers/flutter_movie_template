import 'package:flutter/material.dart';
import 'package:movieapp/src/core/models/movie_model.dart';
import 'package:movieapp/src/core/utils/size_config.dart';
import 'package:movieapp/src/ui/theme/theme.dart';
import 'package:movieapp/src/ui/widgets/cupertino_custom_button.dart';

class MovieDetailPage extends StatelessWidget {
  final BuildContext? context;
  final  Movie movie;
  const MovieDetailPage({Key? key,required this.movie,this.context}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildDetailPageForMovie(context, movie);
  }
}
/// THis build Method created the MODAl Widget [iOS] page that opens from the bottom.
///
Widget _buildDetailPageForMovie(BuildContext context, Movie movie) {
  SizeConfig().init(context);
  return Scaffold(
    body: SizedBox(
      height: double.maxFinite,
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SizeConfig.screenHeight! * 0.05,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: SizeConfig.smallPadding),
                  child: IconButton(
                    icon: Icon(Icons.cancel,size: SizeConfig.screenHeight! * 0.04 ,color: inactiveColor,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),

          Container(
            padding:  EdgeInsets.symmetric(horizontal: SizeConfig.mediumPadding,),
            height: SizeConfig.screenHeight! * 0.06,
            width: SizeConfig.screenHeight! * 0.30,
            child: Text(movie.title!,style: Theme.of(context).
            textTheme.bodyText1?.copyWith(fontSize: SizeConfig.screenHeight! * 0.025,fontWeight: FontWeight.w700), maxLines: 2,),
          ),

          //Rating Stars
          ///
          SizedBox(
            height: SizeConfig.screenHeight! * 0.03,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding:  EdgeInsets.symmetric(horizontal: SizeConfig.mediumPadding),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                        child: Text('${movie.imdb_rating} stars',style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w700,fontSize: SizeConfig.screenHeight! * 0.017),))
                )
              ],
            ),
          ),
          SizedBox(height:SizeConfig.screenHeight! * 0.01),
          Container(
            margin:  EdgeInsets.symmetric(horizontal: SizeConfig.mediumPadding),
            height: SizeConfig.screenHeight! * 0.30 ,
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: textColor,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(movie.backdrop!),

                )
            ),
          ),

          //Released on and Movie length section
          SizedBox(
            height: SizeConfig.screenHeight! * 0.08,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: SizeConfig.mediumPadding),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                          child: Text(movie.length!,style: Theme.of(context).textTheme.caption?.copyWith(fontSize: SizeConfig.screenHeight! * 0.016,fontWeight: FontWeight.w700),))),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: SizeConfig.mediumPadding),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                      child: Text(parseDate(movie.released_on!),style: Theme.of(context).textTheme.caption?.copyWith(fontSize: SizeConfig.screenHeight! * 0.016,fontWeight: FontWeight.w700),)),
                ),
              ],
            ),
          ),
          //Overview
          SizedBox(
              height: SizeConfig.screenHeight! * 0.28,
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: SizeConfig.mediumPadding),
                child: Text(
                  movie.overview!,textAlign: TextAlign.start, maxLines: 17, style:
                Theme.of(context).textTheme.caption?.copyWith(
                    fontSize: SizeConfig.screenHeight! * 0.018,
                    fontWeight: FontWeight.w500,height: 1.5,color: Colors.black.withOpacity(0.6)),
                ),
              )
          ),
          const Spacer(flex: 2),
          CustomButton(movie: movie,state: movie.isFavorite == 0 ? ButtonState.Remove:ButtonState.Add),
          const Spacer(flex: 2),
        ],

      ),
    ),

  );

}

//06:

String parseDate(String date){
  DateTime dates =  DateTime.parse(date);
  var formattedDate = '${dates.day}.${dates.month}.${dates.year}';
  return formattedDate;
}