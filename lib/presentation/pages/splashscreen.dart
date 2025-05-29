import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/presentation/admin/admin_main_page.dart';
import 'package:canary_farm/presentation/auth/login_screen.dart';
import 'package:canary_farm/presentation/buyer/home/buyer_home_screen.dart';
import 'package:canary_farm/presentation/buyer/profile/buyer_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  final _storage = const FlutterSecureStorage();
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () async {
      final token = await _storage.read(key: 'authToken');
      if (token != null) {
        final role = await _storage.read(key: 'userRole');
        if (role?.toLowerCase() == 'admin') {
          context.pushAndRemoveUntil(const AdminMainPage(), (route) => false);
        } else {
          context.pushAndRemoveUntil(
            const BuyerProfilePage(),
            (route) => false,
          );
        }
      } else {
        context.pushAndRemoveUntil(const LoginScreen(), (route) => false);
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Canary Farm',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
