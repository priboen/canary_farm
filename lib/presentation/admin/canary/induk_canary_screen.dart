import 'package:canary_farm/core/assets/assets.gen.dart';
import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/presentation/admin/canary/induk/bloc/induk_bloc.dart';
import 'package:canary_farm/presentation/admin/canary/induk/induk_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndukCanaryScreen extends StatefulWidget {
  const IndukCanaryScreen({super.key});

  @override
  State<IndukCanaryScreen> createState() => _IndukCanaryScreenState();
}

class _IndukCanaryScreenState extends State<IndukCanaryScreen> {
  @override
  void initState() {
    super.initState();
    context.read<IndukBloc>().add(IndukGetAllEvent());
  }

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          width: double.infinity,
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
            child: BlocBuilder<IndukBloc, IndukState>(
              builder: (context, state) {
                if (state is IndukLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is IndukErrorState) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is IndukSuccessState) {
                  final data = state.responseModel.data;
                  if (data.isEmpty) {
                    return const Center(
                      child: Text('Tidak ada data induk burung'),
                    );
                  }

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Daftar Induk Burung",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: () {
                              context.push(const IndukFormPage());
                            },
                            child: const Text("Lihat Semua"),
                          ),
                        ],
                      ),
                      const SpaceHeight(16.0),
                      ListView.separated(
                        itemCount: data.length,
                        shrinkWrap: true, // 🟢 penting
                        physics:
                            const NeverScrollableScrollPhysics(), // biar scroll ikut SingleChildScrollView
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final induk = data[index];
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 20,
                              backgroundImage:
                                  (induk.gambarBurung != null &&
                                      induk.gambarBurung!.isNotEmpty)
                                  ? NetworkImage(induk.gambarBurung!)
                                  : Assets.images.canary.provider(),
                              backgroundColor: AppColors.lightSheet,
                            ),
                            title: Text(induk.noRing),
                            subtitle: Text(
                              '${_formatDate(induk.tanggalLahir)}'
                              '${induk.keterangan != null ? ' - ${induk.keterangan}' : ''}',
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }

                return const Center(
                  child: Text('Ada masalah, silakan coba lagi'),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}";
  }
}
