import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/data/models/request/admin/admin_profile_request.dart';
import 'package:canary_farm/presentation/admin/admin_main_page.dart';
import 'package:canary_farm/presentation/admin/profile/bloc/add_profile/add_profile_bloc.dart';
import 'package:canary_farm/presentation/admin/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminConfirmScreen extends StatefulWidget {
  const AdminConfirmScreen({super.key});

  @override
  State<AdminConfirmScreen> createState() => _AdminConfirmScreenState();
}

class _AdminConfirmScreenState extends State<AdminConfirmScreen> {
  late final TextEditingController nameController;
  late final GlobalKey<FormState> _key;

  @override
  void initState() {
    nameController = TextEditingController();
    _key = GlobalKey<FormState>();
    context.read<GetProfileBloc>().add(FetchProfileEvent());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    _key.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetProfileBloc, GetProfileState>(
        builder: (context, state) {
          bool isReadOnly = false;
          bool hasData = false;
          if (state is GetProfileSuccess && state.responseModel.data != null) {
            final profile = state.responseModel.data!;
            nameController.text = profile.name ?? '';
            isReadOnly = true;
            hasData = true;
          }
          return Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Admin Confirmation',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomTextField(
                    readOnly: isReadOnly,
                    controller: nameController,
                    label: 'Nama Lengkap',
                    validator: "Nama Lengkap tidak boleh kosong",
                  ),
                  const SpaceHeight(32),
                  if (hasData)
                    Button.filled(
                      onPressed: () {
                        context.pushAndRemoveUntil(
                          const AdminMainPage(),
                          (route) => false,
                        );
                      },
                      label: "Lanjutkan",
                    )
                  else
                    BlocConsumer<AddProfileBloc, AddProfileState>(
                      listener: (context, state) {
                        if (state is AddProfileSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Profile added successfully!'),
                            ),
                          );
                          context.pushAndRemoveUntil(
                            const AdminMainPage(),
                            (route) => false,
                          );
                        } else if (state is AddProfileFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Failed to add profile: ${state.error}',
                              ),
                              backgroundColor: AppColors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return Button.filled(
                          onPressed: state is AddProfileLoading
                              ? null
                              : () {
                                  if (_key.currentState!.validate()) {
                                    final request = AdminProfileRequestModel(
                                      name: nameController.text,
                                    );
                                    context.read<AddProfileBloc>().add(
                                      AddProfileRequested(
                                        requestModel: request,
                                      ),
                                    );
                                  }
                                },
                          label: state is AddProfileLoading
                              ? 'Memuat...'
                              : 'Konfirmasi',
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
