import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/data/models/request/admin/anak_request_model.dart';
import 'package:canary_farm/data/models/response/get_all_induk_response.dart';
import 'package:canary_farm/presentation/admin/admin_main_page.dart';
import 'package:canary_farm/presentation/admin/canary/anak/bloc/anak_bloc.dart';
import 'package:canary_farm/presentation/admin/canary/induk/bloc/induk_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnakCanaryFormScreen extends StatefulWidget {
  const AnakCanaryFormScreen({super.key});

  @override
  State<AnakCanaryFormScreen> createState() => _AnakCanaryFormScreenState();
}

class _AnakCanaryFormScreenState extends State<AnakCanaryFormScreen> {
  final _formKey = GlobalKey<FormState>();

  List<GetInduk> indukList = [];
  GetInduk? selectedAyah;
  GetInduk? selectedIbu;

  final TextEditingController noRingController = TextEditingController();
  final TextEditingController tanggalLahirController = TextEditingController();
  final TextEditingController jenisKelaminController = TextEditingController();
  final TextEditingController jenisKenariController = TextEditingController();
  final TextEditingController keteranganController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<IndukBloc>().add(IndukGetAllEvent());
  }

  @override
  void dispose() {
    noRingController.dispose();
    tanggalLahirController.dispose();
    jenisKelaminController.dispose();
    jenisKenariController.dispose();
    keteranganController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      tanggalLahirController.text =
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Anak Burung'),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: BlocListener<IndukBloc, IndukState>(
        listener: (context, state) {
          if (state is IndukSuccessState) {
            setState(() {
              indukList = state.responseModel.data;
            });
          } else if (state is IndukErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gagal load data induk: ${state.errorMessage}'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  controller: noRingController,
                  label: 'Nomor Ring',
                  validator: 'Nomor ring tidak boleh kosong',
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: tanggalLahirController,
                  decoration: const InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: _pickDate,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Tanggal lahir wajib diisi'
                      : null,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: jenisKelaminController,
                  label: 'Jenis Kelamin',
                  validator: 'Jenis kelamin tidak boleh kosong',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: jenisKenariController,
                  label: 'Jenis Kenari',
                  validator: 'Jenis kenari tidak boleh kosong',
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  controller: keteranganController,
                  label: 'Keterangan',
                  validator: 'Keterangan tidak boleh kosong',
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<GetInduk>(
                  decoration: const InputDecoration(
                    labelText: 'Pilih Ayah',
                    border: OutlineInputBorder(),
                  ),
                  items: indukList
                      .map(
                        (induk) => DropdownMenuItem(
                          value: induk,
                          child: Text('${induk.noRing} - ${induk.jenisKenari}'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => selectedAyah = value),
                  validator: (value) =>
                      value == null ? 'Ayah harus dipilih' : null,
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<GetInduk>(
                  decoration: const InputDecoration(
                    labelText: 'Pilih Ibu',
                    border: OutlineInputBorder(),
                  ),
                  items: indukList
                      .map(
                        (induk) => DropdownMenuItem(
                          value: induk,
                          child: Text('${induk.noRing} - ${induk.jenisKenari}'),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() => selectedIbu = value),
                  validator: (value) =>
                      value == null ? 'Ibu harus dipilih' : null,
                ),
                const SizedBox(height: 32),
                BlocConsumer<AnakBloc, AnakState>(
                  listener: (context, state) {
                    if (state is AnakAddSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.responseModel.message)),
                      );
                      context.pushAndRemoveUntil(
                        const AdminMainPage(),
                        (route) => false,
                      );
                    } else if (state is AnakFailureState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Button.filled(
                      onPressed: state is AnakLoadingState
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final anakRequest = AnakRequestModel(
                                  noRing: noRingController.text,
                                  tanggalLahir: DateTime.parse(
                                    tanggalLahirController.text,
                                  ),
                                  jenisKelamin: jenisKelaminController.text,
                                  jenisKenari: jenisKenariController.text,
                                  keterangan: keteranganController.text,
                                  // gambarBurung: '', // optional if needed
                                  ayahId: selectedAyah!.id,
                                  ibuId: selectedIbu!.id,
                                );
                                context.read<AnakBloc>().add(
                                  AnakRequestEvent(requestModel: anakRequest),
                                );
                              }
                            },
                      label: state is AnakLoadingState
                          ? 'Menyimpan...'
                          : 'Simpan',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
