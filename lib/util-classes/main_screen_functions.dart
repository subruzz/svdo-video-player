import 'package:flutter/material.dart';

class MainScreenFunctions {
  static void onTabTapped(
      int index, IconData? icon, IconData? icon2, int currentIndex) {
    currentIndex = index;
    switch (index) {
      case 0:
        {
          icon = Icons.search;
          icon2 = Icons.sort;
        }
        break;
      case 1:
        {
          icon = null;
          icon2 = Icons.search;
        }
        break;
      case 2:
        {
          icon = null;
          icon2 = Icons.search;
        }
        break;
      case 3:
        {
          icon = null;
          icon2 = Icons.settings;
        }
        break;
    }
  }
}
