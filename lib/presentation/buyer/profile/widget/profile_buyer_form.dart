import 'package:canary_farm/data/models/request/buyer/buyer_profile_request_model.dart';
import 'package:canary_farm/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBuyerInputForm extends StatefulWidget {
  const ProfileBuyerInputForm({super.key});

  @override
  State<ProfileBuyerInputForm> createState() => ProfileBuyerInputFormState();
}

class ProfileBuyerInputFormState extends State<ProfileBuyerInputForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBuyerBloc, ProfileBuyerState>(
      builder: (context, state) {
        final isLoading = state is ProfileBuyerLoading;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: "Nama"),
                  validator: (value) =>
                      value!.isEmpty ? "Nama tidak boleh kosong" : null,
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: "Alamat"),
                  validator: (value) =>
                      value!.isEmpty ? "Alamat tidak boleh kosong" : null,
                ),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(labelText: "No HP"),
                  validator: (value) =>
                      value!.isEmpty ? "Nomor HP tidak boleh kosong" : null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            final request = BuyerProfileRequestModel(
                              name: nameController.text,
                              address: addressController.text,
                              phone: phoneController.text,
                              photo: "",
                            );
                            context.read<ProfileBuyerBloc>().add(
                              AddProfileBuyerEvent(requestModel: request),
                            );
                          }
                        },
                  child: isLoading
                      ? CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                      : Text("Simpan Profil"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
