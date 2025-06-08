import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/presentation/admin/admin_main_page.dart';
import 'package:canary_farm/presentation/auth/login_screen.dart';
import 'package:canary_farm/presentation/buyer/profile/buyer_profile_screen.dart';
import 'package:canary_farm/presentation/pages/bloc/check_token_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckTokenBloc, CheckTokenState>(
      listener: (context, state) {
        if (state is SplashAuthenticated) {
          if (state.role == 'admin') {
            context.pushAndRemoveUntil(const AdminMainPage(), (_) => false);
          } else {
            context.pushAndRemoveUntil(
              const BuyerProfileScreen(),
              (_) => false,
            );
          }
        } else if (state is SplashUnauthenticated) {
          context.pushAndRemoveUntil(const LoginScreen(), (_) => false);
        }
      },
      child: const _SplashUI(),
    );
  }
}

class _SplashUI extends StatelessWidget {
  const _SplashUI();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Canary Farm',
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.bold,
                color: AppColors.lightSheet,
              ),
            ),
            const SizedBox(height: 24),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
