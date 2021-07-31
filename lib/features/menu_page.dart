import 'package:power_monitor_app/features/profile/presentation/pages/profile_page.dart';

import '../core/utils/app_colors.dart';
import '../core/utils/view.dart';
import 'package:flutter/material.dart';

import 'history/presentation/pages/history_page.dart';
import 'home/presentation/pages/home_page.dart';

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int pageIndex = 0;

  final _pages = <Widget>[
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];

  final _bottomNavBarItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home_filled),
      label: 'Beranda',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      label: 'Riwayat',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profil',
    )
  ];

  @override
  Widget build(BuildContext context) {
    View().init(context);
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: IndexedStack(
            index: pageIndex,
            children: _pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: _bottomNavBarItems,
            backgroundColor: AppColors.primary,
            currentIndex: pageIndex,
            selectedItemColor: AppColors.secondary,
            unselectedItemColor: Colors.white,
            onTap: (selected) => setState(() => pageIndex = selected),
          ),
        ),
      ),
    );
  }
}
