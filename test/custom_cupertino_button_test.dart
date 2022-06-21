
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/ui/pages/movie_page.dart';
import 'package:movieapp/src/ui/widgets/cupertino_custom_button.dart';

import 'mocks.dart';


void main(){


  group('Test All Custom Button Cases', () {

    /// This syntax is used to test widgets
    ///
    /// we use it to build and interact in a test environment
    ///
    testWidgets('When Button State Add ', (WidgetTester tester) async {
      MockModel mock = MockModel();
      /// pumpWidget is always called for the widget we want to build
      ///don't forget to surround it with a [Material Widget]
      await tester.pumpWidget(MaterialApp(home: CustomButton(
        movie: mock.movie, state: ButtonState.Add,
      )));

      ///This code tries to find if in CustomButton there is a Outlined
      final button = find.byType(OutlinedButton);
      ///we use it a finder which finds fromType
      expect(button,findsOneWidget);
      await tester.pump();

      ///findsNothing is used to check if no widget are found
      expect(find.text(UiText.buttonFavRemove), findsNothing);
      await tester.pump();

      ///here we try to find if a widget text holds tap me as value
      expect(find.text(UiText.buttonFavAdd), findsOneWidget);

      /// always use await keyword we check if the button
      /// works well. Here we send a tap event to trigger the button
      await tester.tap(button);
      await tester.pump();


    });

    testWidgets('When Button State Remove ', (WidgetTester tester) async {
      final mock = MockModel();
      final mockObserver = MockNavigatorObserver();
      final mockDatabase = MockMovieDatabase.instance;

      /// pumpWidget is always called for the widget we want to build
      ///don't forget to surround it with a [Material Widget]
      await tester.pumpWidget(MaterialApp(home: CustomButton(
        movie: mock.movie, state: ButtonState.Remove,
      )));

      ///This code tries to find if in CustomButton there is a Outlined
      final button = find.byType(OutlinedButton);
      ///we use it a finder which finds fromType
      expect(button,findsOneWidget);
      await tester.pump();

      ///findsNothing is used to check if no widget are found
      expect(find.text(UiText.buttonFavAdd), findsNothing);
      await tester.pump();

      ///here we try to find if a widget text holds tap me as value
      expect(find.text(UiText.buttonFavRemove), findsOneWidget);

      /// always use await keyword we check if the button
      /// works well. Here we send a tap event to trigger the button
      await tester.tap(button);
      verifyNever(mockObserver.didPop(MaterialPageRoute(builder: (context) => MoviePage(database: mockDatabase,)), any));
      await tester.pump();


    });
  });

}