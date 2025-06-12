import 'package:canary_farm/data/models/request/admin/posting_jual_request_model.dart';
import 'package:canary_farm/presentation/admin/posting/bloc/posting_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostingFormPage extends StatefulWidget {
  const PostingFormPage({super.key});

  @override
  State<PostingFormPage> createState() => _PostingFormPageState();
}

class _PostingFormPageState extends State<PostingFormPage> {
  String? selectedKey; // format: "id-type"
  int? selectedBurungId;
  String? selectedBurungType;
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  @override
  void initState() {
    context.read<PostingBloc>().add(GetAllBurungPostingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Posting Burung')),
      body: BlocConsumer<PostingBloc, PostingState>(
        listener: (context, state) {
          if (state is PostingSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.burung.message)));
            Navigator.pop(context);
          } else if (state is PostingFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is PostingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GetAllBurungState) {
            final data = state.responseModel.data;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedKey,
                    decoration: const InputDecoration(
                      labelText: 'Pilih Burung',
                    ),
                    items: data.map((burung) {
                      final key = '${burung.id}-${burung.tipe.name}';
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text('${burung.noRing} - ${burung.tipe.name}'),
                        onTap: () {
                          selectedBurungId = burung.id;
                          selectedBurungType = burung.tipe.name;
                        },
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedKey = value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: hargaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Harga'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: deskripsiController,
                    decoration: const InputDecoration(labelText: 'Deskripsi'),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedBurungId == null ||
                          selectedBurungType == null ||
                          hargaController.text.isEmpty ||
                          deskripsiController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lengkapi semua field')),
                        );
                        return;
                      }

                      final request = PostingJualRequestModel(
                        burungId: selectedBurungId!,
                        burungType: selectedBurungType!.toLowerCase(),
                        harga: int.parse(hargaController.text),
                        deskripsi: deskripsiController.text,
                      );

                      context.read<PostingBloc>().add(
                        PostingRequestEvent(requestModel: request),
                      );
                    },
                    child: const Text('Posting'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Sedang memuat data burung...'));
        },
      ),
    );
  }
}
