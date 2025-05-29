import 'package:bloc/bloc.dart';
import 'package:canary_farm/data/models/response/admin_profile_response_model.dart';
import 'package:canary_farm/data/repository/admin_repository.dart';

part 'get_profile_event.dart';
part 'get_profile_state.dart';

class GetProfileBloc extends Bloc<GetProfileEvent, GetProfileState> {
  final AdminRepository adminRepository;
  GetProfileBloc(this.adminRepository) : super(GetProfileInitial()) {
    on<FetchProfileEvent>((event, emit) async {
      final result = await adminRepository.getProfile();
      result.fold(
        (l) => emit(GetProfileFailure(error: l)),
        (r) => emit(GetProfileSuccess(responseModel: r)),
      );
    });
  }
}
