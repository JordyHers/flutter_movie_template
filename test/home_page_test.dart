import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/src/core/constants/strings.dart';
import 'package:movieapp/src/ui/pages/home_page.dart';
import 'package:movieapp/src/ui/theme/theme.dart';
import 'package:provider/provider.dart';
import 'mocks.dart';



void main() {
  testWidgets('Test Homepage Widgets', (WidgetTester tester) async {
    final textsWidgets = find.text('Movies');
    // Provide the childWidget to the Container.
    await tester.pumpWidget(
        ListenableProvider<MockMovieDatabase>(
    create:(_)=> MockMovieDatabase.instance,
    dispose: (_,database) => database.close(),
        builder:(_,child){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: UiText.appTitle,
            theme: AppTheme.appTheme,
            home:  HomePage(),
          );
        }
    ));

    // Search for the childWidget in the tree and verify it exists.
    expect(textsWidgets, findsWidgets);
  },skip: true);
}
