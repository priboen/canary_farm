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
    context.read<IndukBloc>().add(IndukGetAllEvent());
    super.initState();
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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SpaceHeight(16.0),
              Container(
                height:
                    MediaQuery.of(context).size.height *
                    0.5, // batas tinggi container
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
                      const SpaceHeight(16.0),
                      Expanded(
                        // tambahkan Expanded supaya ListView dapat scroll dan memenuhi ruang
                        child: BlocBuilder<IndukBloc, IndukState>(
                          builder: (context, state) {
                            if (state is IndukLoadingState) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is IndukErrorState) {
                              return Center(child: Text(state.errorMessage));
                            } else if (state is IndukSuccessState) {
                              if (state.responseModel.data.isEmpty) {
                                return Center(
                                  child: Text('Tidak ada data induk burung'),
                                );
                              }
                              return ListView.builder(
                                shrinkWrap:
                                    false, // biarkan false agar ListView bisa scroll
                                physics:
                                    const AlwaysScrollableScrollPhysics(), // scroll bisa aktif
                                itemCount: state.responseModel.data.length,
                                itemBuilder: (context, index) {
                                  final induk = state.responseModel.data[index];
                                  return ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundImage: Assets.images.canary
                                          .provider(),
                                    ),
                                    title: Text(induk.noRing ?? 'No Ring'),
                                    subtitle: Text(
                                      '${induk.tanggalLahir} - ${induk.keterangan}',
                                    ),
                                  );
                                },
                              );
                            }
                            return Center(
                              child: Text('Ada masalah, silakan coba lagi'),
                            );
                          },
                        ),
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
      ),
    );
  }
}
