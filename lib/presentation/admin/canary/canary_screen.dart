import 'package:canary_farm/core/assets/assets.gen.dart';
import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/presentation/admin/canary/induk/induk_form_page.dart';
import 'package:flutter/material.dart';

class CanaryScreen extends StatefulWidget {
  const CanaryScreen({super.key});

  @override
  State<CanaryScreen> createState() => _CanaryScreenState();
}

class _CanaryScreenState extends State<CanaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Canary Farm',
          style: TextStyle(color: AppColors.lightSheet),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SpaceHeight(16.0),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.06),
                    blurRadius: 10.0,
                    blurStyle: BlurStyle.outer,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Daftar Induk Burung"),
                        Spacer(flex: 1),
                        TextButton(
                          onPressed: () {
                            context.push(const IndukFormPage());
                          },
                          child: Text("Lihat Semua"),
                        ),
                      ],
                    ),
                    const SpaceHeight(8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: Assets.images.canary.provider(),
                          ),
                          title: Text('Induk Burung ${index + 1}'),
                          subtitle: Text('Detail Induk Burung ${index + 1}'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SpaceHeight(32.0),
            Container(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.06),
                    blurRadius: 10.0,
                    blurStyle: BlurStyle.outer,
                    offset: const Offset(0, 0),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text("Daftar Anak Burung"),
                        Spacer(flex: 1),
                        TextButton(
                          onPressed: () {},
                          child: Text("Lihat Semua"),
                        ),
                      ],
                    ),
                    const SpaceHeight(8.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3, // Example count
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: Assets.images.canary.provider(),
                          ),
                          title: Text('Induk Burung ${index + 1}'),
                          subtitle: Text('Detail Induk Burung ${index + 1}'),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
