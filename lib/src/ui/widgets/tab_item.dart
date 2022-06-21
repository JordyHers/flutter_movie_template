import 'package:flutter/material.dart';

enum TabItem {movie , favorite , account }

class TabItemData{
  const  TabItemData({required this.title,required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem , TabItemData> allTabs ={
    TabItem.movie : TabItemData(title: 'Movies', icon: Icons.list),
    TabItem.favorite : TabItemData(title: 'Favorites', icon: Icons.favorite),

  };

}