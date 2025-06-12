import 'package:canary_farm/data/repository/posting_repostory.dart';
import 'package:canary_farm/data/repository/profile_admin_repository.dart';
import 'package:canary_farm/data/repository/anak_repository.dart';
import 'package:canary_farm/data/repository/auth_repository.dart';
import 'package:canary_farm/data/repository/induk_repository.dart';
import 'package:canary_farm/presentation/admin/canary/anak/bloc/anak_bloc.dart';
import 'package:canary_farm/presentation/admin/canary/induk/bloc/induk_bloc.dart';
import 'package:canary_farm/presentation/admin/home/bloc/admin_stats_bloc.dart';
import 'package:canary_farm/presentation/admin/posting/bloc/posting_bloc.dart';
import 'package:canary_farm/presentation/admin/profile/bloc/add_profile/add_profile_bloc.dart';
import 'package:canary_farm/presentation/admin/profile/bloc/get_profile/get_profile_bloc.dart';
import 'package:canary_farm/data/repository/get_all_burung_tersedia_repository.dart';
import 'package:canary_farm/data/repository/profile_buyer_repository.dart';
import 'package:canary_farm/presentation/auth/bloc/login/login_bloc.dart';
import 'package:canary_farm/presentation/auth/bloc/register/register_bloc.dart';
import 'package:canary_farm/presentation/bloc/get_all_burung_tersedia/get_burung_tersedia_bloc.dart';
import 'package:canary_farm/presentation/buyer/profile/bloc/profile_buyer_bloc.dart';
import 'package:canary_farm/presentation/pages/bloc/check_token_bloc.dart';
import 'package:canary_farm/presentation/pages/splashscreen.dart';
import 'package:canary_farm/services/service_http_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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
        BlocProvider(
          create: (context) => ProfileBuyerBloc(
            profileBuyerRepository: ProfileBuyerRepository(ServiceHttpClient()),
          ),
        ),

        BlocProvider(
          create: (context) => GetBurungTersediaBloc(
            GetAllBurungTersediaRepository(ServiceHttpClient()),
          ),
        ),
        BlocProvider(
          create: (context) =>
              AddProfileBloc(PrifileAdminRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              GetProfileBloc(PrifileAdminRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) =>
              GetProfileBloc(PrifileAdminRepository(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) => IndukBloc(IndukRepository(ServiceHttpClient())),
        ),

        BlocProvider(
          create: (context) => AnakBloc(AnakRepository(ServiceHttpClient())),
        ),

        BlocProvider(
          create: (context) => CheckTokenBloc(
            const FlutterSecureStorage(),
            PrifileAdminRepository(ServiceHttpClient()),
            ProfileBuyerRepository(ServiceHttpClient()),
          )..add(CheckToken()),
        ),

        //posting
        BlocProvider(
          create: (context) =>
              PostingBloc(PostingRepostory(ServiceHttpClient())),
        ),
        BlocProvider(
          create: (context) => AdminStatsBloc(
            IndukRepository(ServiceHttpClient()),
            AnakRepository(ServiceHttpClient()),
            GetAllBurungTersediaRepository(ServiceHttpClient()),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const Splashscreen(),
      ),
    );
  }
}
