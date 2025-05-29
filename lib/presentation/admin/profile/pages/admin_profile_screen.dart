import 'package:canary_farm/core/assets/assets.gen.dart';
import 'package:canary_farm/core/components/spaces.dart';
import 'package:canary_farm/core/constants/colors.dart';
import 'package:flutter/material.dart';

class AdminProfileScreen extends StatelessWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                radius: 90,
                backgroundImage: Assets.images.profile.provider(),
              ),
              const SpaceHeight(16),
              Text(
                'Admin',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SpaceHeight(80),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Ubah Profil',
                  style: TextStyle(color: AppColors.primary, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
