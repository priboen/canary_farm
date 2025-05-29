import 'package:canary_farm/data/models/response/buyer/buyer_profile_response_model.dart';
import 'package:flutter/material.dart';

class ProfileViewBuyer extends StatelessWidget {
  final Data profile;
  const ProfileViewBuyer({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Nama: ${profile.name}"),
            Text("Alamat: ${profile.address}"),
            Text("No HP: ${profile.phone}"),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Misal bisa buat navigasi ke edit profile
              },
              child: Text("Edit Profil"),
            ),
          ],
        ),
      ),
    );
  }
}
