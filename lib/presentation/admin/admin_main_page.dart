import 'package:canary_farm/core/constants/constants.dart';
import 'package:canary_farm/presentation/admin/canary/anak/anak_canary_screen.dart';
import 'package:canary_farm/presentation/admin/canary/induk/induk_canary_screen.dart';
import 'package:canary_farm/presentation/admin/home/admin_home_screen.dart';
import 'package:canary_farm/presentation/admin/posting/posting_screen.dart';
import 'package:flutter/material.dart';

class AdminMainPage extends StatefulWidget {
  const AdminMainPage({super.key});

  @override
  State<AdminMainPage> createState() => _AdminMainPageState();
}

class _AdminMainPageState extends State<AdminMainPage> {
  int _selectedIndex = 0;
  final _widgets = [
    const AdminHomeScreen(),
    const IndukCanaryScreen(),
    const AnakCanaryScreen(),
    const PostingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgets),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10.0,
              blurStyle: BlurStyle.outer,
              offset: const Offset(0, -8),
              spreadRadius: 0,
            ),
          ],
        ),
        child: Theme(
          data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            backgroundColor: AppColors.primary,
            useLegacyColorScheme: false,
            currentIndex: _selectedIndex,
            onTap: (value) => setState(() {
              _selectedIndex = value;
            }),
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: const TextStyle(color: AppColors.lightSheet),
            selectedIconTheme: const IconThemeData(color: AppColors.lightSheet),
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _selectedIndex == 0
                      ? AppColors.lightSheet
                      : AppColors.grey,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.pets,
                  color: _selectedIndex == 1
                      ? AppColors.lightSheet
                      : AppColors.grey,
                ),
                label: 'Induk',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add,
                  color: _selectedIndex == 2
                      ? AppColors.lightSheet
                      : AppColors.grey,
                ),
                label: 'Anak',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: _selectedIndex == 3
                      ? AppColors.lightSheet
                      : AppColors.grey,
                ),
                label: 'Posting',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
