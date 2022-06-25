import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/core/database/movie_database.dart';
import 'package:movieapp/src/core/utils/size_config.dart';
import 'package:movieapp/src/ui/theme/theme.dart';
import '../../core/models/movie_model.dart';



enum ButtonState{ Add, Remove}

class CustomButton extends StatefulWidget {
  final Movie movie;
   final ButtonState state;
  const CustomButton({Key? key,required this.state,required this.movie}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  Color backgroundColor = Colors.transparent;
  Color textColoredRemove = Colors.red;
  Color textColoredAdd = backgroundButtonColorAdd;

  late  String AddText = UiText.buttonFavAdd;
  late String RemoveText = UiText.buttonFavRemove;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
     switch(widget.state) {
       case ButtonState.Add:
         return Center(
           child: OutlinedButton(
               style: OutlinedButton.styleFrom(
                 backgroundColor: backgroundColor,
                 side:  BorderSide(width: 1.5, color: backgroundButtonColorAdd),
                 minimumSize: Size(MediaQuery
                     .of(context)
                     .size
                     .width * 0.80, SizeConfig.screenHeight! * 0.06),
               ),
               onPressed: () {
                 setState(() {
                   backgroundColor = backgroundButtonColorAdd;
                   AddText = UiText.buttonFavAddedToFavorite;
                 textColoredAdd = Colors.white;});
                  MovieDatabase.instance.update(
                     widget.movie.copy(isFavorite: 0));
                    MovieDatabase.instance.readAllMovies();
                   MovieDatabase.instance.readFavoriteMovies();
                       //.whenComplete(() => Navigator.pop(context));

                 print('Add to favorite ');
               },
               child:  Text(AddText,
                 style: TextStyle(color: textColoredAdd, fontSize: 16),)),
         );
         break;
       case ButtonState.Remove:
         return  Center(
           child: OutlinedButton(
               style: OutlinedButton.styleFrom(
                 backgroundColor: backgroundColor,
                 side:  BorderSide(width: 1.5, color: backgroundButtonColorRemove),
                 minimumSize: Size(MediaQuery.of(context).size.width * 0.80, SizeConfig.screenHeight! * 0.06),
               ),
               onPressed: ()  {
                 setState(() {
                   backgroundColor = backgroundButtonColorRemove;
                   RemoveText = UiText.buttonFromFavRemove;
                 textColoredRemove = Colors.white;});
                 MovieDatabase.instance.update(widget.movie.copy(isFavorite: 1));
                  MovieDatabase.instance.readAllMovies();
                  MovieDatabase.instance.readFavoriteMovies();
                     // .whenComplete(() => Navigator.pop(context));

                 print('Remove from Favorite ');
               }, child:  Text(RemoveText,style: TextStyle(color: textColoredRemove,fontSize: 16),)),
         );
     }


  }
}
