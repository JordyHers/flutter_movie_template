import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/database/movie_database.dart';
import 'package:movieapp/src/core/utils/size_config.dart';
import 'package:movieapp/src/ui/theme/theme.dart';
import '../../core/models/movie_model.dart';



enum ButtonState{ Add, Remove}

class CustomButton extends StatelessWidget {
  final Movie movie;
   final ButtonState state;
  const CustomButton({Key? key,required this.state,required this.movie}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     switch(state) {
       case ButtonState.Add:
         return Center(
           child: OutlinedButton(
               style: OutlinedButton.styleFrom(
                 side:  BorderSide(width: 1.5, color: inactiveColor),
                 minimumSize: Size(MediaQuery
                     .of(context)
                     .size
                     .width * 0.80, SizeConfig.screenHeight! * 0.06),
               ),
               onPressed: () {
                  MovieDatabase.instance.update(
                     movie.copy(isFavorite: 0));
                    MovieDatabase.instance.readAllMovies();
                   MovieDatabase.instance.readFavoriteMovies();
                 Navigator.of(context).pop();
                 print('Add to favorite ');
               },
               child:  Text(UiText.buttonFavAdd,
                 style: TextStyle(color: inactiveColor, fontSize: 16),)),
         );
         break;
       case ButtonState.Remove:
         return  Center(
           child: OutlinedButton(
               style: OutlinedButton.styleFrom(
                 side: const BorderSide(width: 1.5, color: Colors.red),
                 minimumSize: Size(MediaQuery.of(context).size.width * 0.80, SizeConfig.screenHeight! * 0.06),
               ),
               onPressed: ()  {
                 MovieDatabase.instance.update(movie.copy(isFavorite: 1));
                  MovieDatabase.instance.readAllMovies();
                  MovieDatabase.instance.readFavoriteMovies();
                 Navigator.of(context).pop();
                 print('Remove from Favorite ');
               }, child: const Text(UiText.buttonFavRemove,style: TextStyle(color: Colors.red,fontSize: 16),)),
         );
     }


  }
}
