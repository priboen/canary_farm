import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/presentation/admin/canary/anak/anak_canary_screen.dart';
import 'package:canary_farm/presentation/admin/canary/induk/induk_canary_screen.dart';
import 'package:canary_farm/presentation/admin/home/bloc/admin_stats_bloc.dart';
import 'package:canary_farm/presentation/admin/posting/posting_screen.dart';
import 'package:canary_farm/presentation/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AdminStatsBloc>().add(LoadAdminDasboarStats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Konfirmasi Logout'),
                    content: const Text('Apakah Anda yakin ingin logout?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Batal'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Logika untuk logout
                          context.pushAndRemoveUntil(
                            const LoginScreen(),
                            (_) => false,
                          );
                        },
                        child: const Text('Logout'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AdminStatsBloc, AdminStatsState>(
          builder: (context, state) {
            if (state is AdminStatsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AdminStatsFailure) {
              return Center(child: Text('Gagal memuat data: ${state.message}'));
            }

            if (state is AdminStatsSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistik Data',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  _buildStatCard(
                    'Total Induk',
                    state.totalInduk,
                    Colors.orange,
                    () {
                      context.push(const IndukCanaryScreen());
                    },
                  ),
                  _buildStatCard(
                    'Total Anak',
                    state.totalAnak,
                    Colors.green,
                    () {
                      context.push(const AnakCanaryScreen());
                    },
                  ),
                  _buildStatCard(
                    'Burung Tersedia',
                    state.totalBurungTersedia,
                    Colors.blue,
                    () {
                      context.push(const PostingScreen());
                    },
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    int count,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: color,
            child: Text(
              count.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(title),
        ),
      ),
    );
  }
}
