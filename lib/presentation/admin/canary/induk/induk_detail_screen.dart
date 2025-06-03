import 'package:canary_farm/data/models/response/get_all_induk_response.dart';
import 'package:flutter/material.dart';

class IndukDetailScreen extends StatelessWidget {
  final GetInduk data;
  const IndukDetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Induk'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ID: ${data.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Nama: ${data.noRing}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Jenis: ${data.jenisKelamin}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Harga: Rp ${data.tanggalLahir}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                //image
                data.gambarBurung == null
                    ? const SizedBox.shrink()
                    : Image.network(
                        data.gambarBurung!,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.fitHeight,
                      ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
