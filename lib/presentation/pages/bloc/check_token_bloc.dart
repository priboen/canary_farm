import 'package:bloc/bloc.dart';
import 'package:canary_farm/data/repository/profile_admin_repository.dart';
import 'package:canary_farm/data/repository/profile_buyer_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

part 'check_token_event.dart';
part 'check_token_state.dart';

class CheckTokenBloc extends Bloc<CheckTokenEvent, CheckTokenState> {
  final FlutterSecureStorage _storage;
  final PrifileAdminRepository adminRepository;
  final ProfileBuyerRepository buyerRepository;

  CheckTokenBloc(this._storage, this.adminRepository, this.buyerRepository)
    : super(CheckTokenInitial()) {
    on<CheckToken>(_onCheckAuth);
  }

  Future<void> _onCheckAuth(
    CheckToken event,
    Emitter<CheckTokenState> emit,
  ) async {
    emit(SplashLoading());

    final token = await _storage.read(key: 'authToken');
    if (token == null) {
      emit(SplashUnauthenticated());
      return;
    }

    final role = (await _storage.read(key: 'userRole'))?.toLowerCase();

    if (role == 'admin') {
      final result = await adminRepository.getProfile();
      if (result.isLeft()) {
        await _storage.deleteAll();
        if (!isClosed) emit(SplashUnauthenticated());
      } else {
        if (!isClosed) emit(SplashAuthenticated(role ?? 'admin'));
      }
    } else {
      final result = await buyerRepository.getProfileBuyer();
      if (result.isLeft()) {
        await _storage.deleteAll();
        if (!isClosed) emit(SplashUnauthenticated());
      } else {
        if (!isClosed) emit(SplashAuthenticated(role ?? 'buyer'));
      }
    }
  }
}
