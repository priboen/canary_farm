import 'package:canary_farm/data/repository/admin_repository.dart';
import 'package:canary_farm/data/repository/auth_repository.dart';
import 'package:canary_farm/presentation/admin/profile/bloc/add_profile/add_profile_bloc.dart';
import 'package:canary_farm/presentation/admin/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:canary_farm/presentation/admin/profile/pages/admin_confirm_screen.dart';
import 'package:canary_farm/data/repository/get_all_burung_tersedia_repository.dart';
import 'package:canary_farm/data/repository/profile_buyer_repository.dart';
import 'package:canary_farm/presentation/auth/bloc/login/login_bloc.dart';
import 'package:canary_farm/presentation/auth/bloc/register/register_bloc.dart';
import 'package:canary_farm/presentation/auth/login_screen.dart';
import 'package:canary_farm/presentation/buyer/home/bloc/get_burung_tersedia_bloc.dart';
import 'package:canary_farm/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:canary_farm/presentation/pages/splashscreen.dart';
import 'package:canary_farm/services/service_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: AuthRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              RegisterBloc(authRepository: AuthRepository(ServiceHttpClient())),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
