import 'package:canary_farm/core/components/spaces.dart';
import 'package:canary_farm/core/extensions/build_context_ext.dart';
import 'package:canary_farm/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canary_farm/presentation/admin/posting/posting_form_screen.dart';
import 'package:canary_farm/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostingScreen extends StatefulWidget {
  const PostingScreen({super.key});

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GetBurungTersediaBloc>().add(GetAllBurungTersediaEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh data burung tersedia
            context.read<GetBurungTersediaBloc>().add(
              GetAllBurungTersediaEvent(),
            );
          },
          child: Column(
            children: [
              const SpaceHeight(10),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Daftar Burung Tersedia",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SpaceHeight(10),
              //search bar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Cari burung...",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.search),
                  ),
                  onChanged: (value) {
                    // Implement search functionality if needed
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: BlocBuilder<GetBurungTersediaBloc, GetBurungTersediaState>(
                    builder: (context, state) {
                      if (state is GetBurungTersediaLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state is GetBurungTersediaError) {
                        return Center(
                          child: Text("Terjadi kesalahan: ${state.message}"),
                        );
                      }

                      if (state is GetBurungTersediaLoaded) {
                        final List<DataBurungTersedia> burungList =
                            state.burungTersedia.data;

                        if (burungList.isEmpty) {
                          return const Center(
                            child: Text("Tidak ada burung tersedia."),
                          );
                        }

                        return GridView.builder(
                          itemCount: burungList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // 2 kolom
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio:
                                    0.75, // rasio aspek untuk kartu
                              ),
                          itemBuilder: (context, index) {
                            final burung = burungList[index];

                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    //use ios dialog
                                    return CupertinoAlertDialog(
                                      title: Text("Detail Burung"),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("No Ring: ${burung.noRing}"),
                                          Text("Usia: ${burung.usia}"),

                                          Text(
                                            "Jenis Kenari: ${burung.jenisKenari}",
                                          ),
                                          Text(
                                            "Jenis Kelamin: ${burung.jenisKelamin}",
                                          ),
                                          Text("Harga: Rp${burung.harga}"),

                                          // Tambahkan informasi lain yang diperlukan
                                          Text(
                                            "Deskripsi: ${burung.deskripsi.isNotEmpty ? burung.deskripsi : 'Tidak ada deskripsi'}",
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text("Tutup"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Card(
                                elevation: 4,
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(12),
                                      ),
                                      child: burung.image.isNotEmpty
                                          ? Image.network(
                                              burung.image,
                                              height: 100,
                                              width: double.infinity,
                                              fit: BoxFit.fitHeight,
                                            )
                                          : Container(
                                              height: 100,
                                              width: double.infinity,
                                              color: Colors.grey[300],
                                              child: const Icon(
                                                Icons.image_not_supported,
                                              ),
                                            ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              burung.noRing,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "Jenis: ${burung.jenisKenari}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              "Kelamin: ${burung.jenisKelamin}",
                                              overflow: TextOverflow.ellipsis,
                                            ),

                                            Text(
                                              "Harga: Rp${burung.harga}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              "Status: ${burung.status}",
                                              style: const TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return const SizedBox(); // default kosong
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to posting form screen
          context.push(const PostingFormPage());
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
