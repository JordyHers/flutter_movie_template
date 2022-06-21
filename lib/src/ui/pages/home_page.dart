import 'package:flutter/material.dart';
import 'package:movieapp/src/ui/pages/favorite_page.dart';
import 'package:movieapp/src/ui/pages/movie_page.dart';
import 'package:movieapp/src/ui/widgets/tab_item.dart';
import '../widgets/cupertino_bottom_bar.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.movie;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.movie: GlobalKey<NavigatorState>(),
    TabItem.favorite: GlobalKey<NavigatorState>(),

  };

  /// Here a Map Function is implemented to handle enums and widget
  /// builders.
  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.movie: (context) => MoviePage.create(context),
      TabItem.favorite: (context) => FavoritePage.create(context),

    };
  }

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      //Pop to first root
      /// This section allows the user to get back to the root when he presses the
      /// icon on the bottomNavigation bar
      navigatorKeys[tabItem]?.currentState?.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    /// WillpopScope allow us to control the back button and hinders
    /// the users to exit the app when he
    /// just wants to get to the previous page
    return WillPopScope(
      onWillPop: () async =>
      !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
