import 'package:canary_farm/core/assets/assets.gen.dart';
import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/presentation/admin/canary/anak/anak_canary_form_screen.dart';

import 'package:canary_farm/presentation/admin/canary/anak/bloc/anak_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnakCanaryScreen extends StatefulWidget {
  const AnakCanaryScreen({super.key});

  @override
  State<AnakCanaryScreen> createState() => _AnakCanaryScreenState();
}

class _AnakCanaryScreenState extends State<AnakCanaryScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger fetch data saat widget diinisialisasi
    context.read<AnakBloc>().add(AnakGetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Anak Burung'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: BlocBuilder<AnakBloc, AnakState>(
        builder: (context, state) {
          if (state is AnakLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AnakFailureState) {
            return Center(child: Text(state.error));
          } else if (state is AnakSuccessState) {
            final anakList = state.responseModel.data;
            if (anakList.isEmpty) {
              return const Center(child: Text('Tidak ada data anak burung'));
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: anakList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final anak = anakList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 3,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: anak.gambarBurung.isNotEmpty
                          ? NetworkImage(anak.gambarBurung)
                          : Assets.images.canary.provider(),
                      backgroundColor: AppColors.lightSheet,
                    ),
                    title: Text(
                      anak.noRing,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Tanggal Lahir: ${_formatDate(anak.tanggalLahir)}',
                        ),
                        Text('Jenis Kelamin: ${anak.jenisKelamin}'),
                        Text('Jenis Kenari: ${anak.jenisKenari}'),
                        Text('Ayah No Ring: ${anak.ayahNoRing}'),
                        Text('Ibu No Ring: ${anak.ibuNoRing}'),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text('Mulai untuk melihat data anak burung'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const AnakCanaryFormScreen());
        },
        child: const Icon(Icons.add),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  static String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
