import 'package:canary_farm/core/core.dart';
import 'package:canary_farm/data/models/request/admin/induk_request_model.dart';
import 'package:canary_farm/presentation/admin/admin_main_page.dart';
import 'package:canary_farm/presentation/admin/canary/induk/bloc/induk_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IndukFormPage extends StatefulWidget {
  const IndukFormPage({super.key});

  @override
  State<IndukFormPage> createState() => _IndukFormPageState();
}

class _IndukFormPageState extends State<IndukFormPage> {
  late final TextEditingController noRingController;
  late final TextEditingController tanggalLahirController;
  late final TextEditingController keteranganController;

  final _formKey = GlobalKey<FormState>();

  final List<String> canaryType = [
    'Yorkshire',
    'F1 Yorkshire',
    'F2',
    'F3',
    'F4',
    'F5',
    'F6',
    'AF',
    'AFS',
    'Lokal',
  ];

  final List<String> genderItems = ['jantan', 'betina'];

  String? selectedValue;
  String? selectedGender;

  @override
  void initState() {
    noRingController = TextEditingController();
    tanggalLahirController = TextEditingController();
    keteranganController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Induk Burung', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: AppColors.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SpaceHeight(30),
                CustomTextField(
                  controller: noRingController,
                  label: 'Nomor Ring',
                  validator: 'Nomor ring tidak boleh kosong',
                ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: tanggalLahirController,
                  label: 'Tanggal Lahir',
                  validator: 'Tanggal lahir tidak boleh kosong',
                ),
                const SpaceHeight(16),
                Text(
                  'Jenis Burung',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(8),
                DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  hint: const Text(
                    'Pilih Jenis Burung',
                    style: TextStyle(fontSize: 14),
                  ),
                  items: canaryType
                      .map(
                        (item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Jenis burung tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(Icons.arrow_drop_down, color: Colors.black45),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
                const SpaceHeight(16),
                Text(
                  'Jenis Kelamin',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SpaceHeight(8),
                Row(
                  children: genderItems.map((gender) {
                    return Expanded(
                      child: RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        title: Text(gender),
                        value: gender,
                        groupValue: selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ),
                if (selectedGender == null)
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 4),
                    child: Text(
                      'Jenis kelamin harus dipilih',
                      style: TextStyle(color: Colors.red, fontSize: 12),
                    ),
                  ),
                const SpaceHeight(16),
                CustomTextField(
                  controller: keteranganController,
                  label: 'Keterangan',
                  validator: 'Keterangan tidak boleh kosong',
                ),
                const SpaceHeight(32),
                BlocConsumer<IndukBloc, IndukState>(
                  listener: (context, state) {
                    if (state is IndukAddSuccessState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.responseModel.message)),
                      );
                      context.pushAndRemoveUntil(
                        const AdminMainPage(),
                        (route) => false,
                      );
                    } else if (state is IndukErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Button.filled(
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          final indukRequest = IndukRequestModel(
                            noRing: noRingController.text,
                            tanggalLahir: DateTime.parse(
                              tanggalLahirController.text,
                            ),
                            jenisKelamin: selectedGender ?? '',
                            jenisKenari: selectedValue ?? '',
                            keterangan: keteranganController.text,
                            gambarBurung:
                                null, // Assuming image upload is handled elsewhere
                          );

                          context.read<IndukBloc>().add(
                            IndukRequestEvent(requestModel: indukRequest),
                          );
                        }
                      },
                      label: "Simpan",
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
