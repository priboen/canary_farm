import 'package:bloc/bloc.dart';
import 'package:canary_farm/data/models/request/admin/admin_profile_request.dart';
import 'package:canary_farm/data/models/response/admin_profile_response_model.dart';
import 'package:canary_farm/data/repository/profile_admin_repository.dart';

part 'add_profile_event.dart';
part 'add_profile_state.dart';

class AddProfileBloc extends Bloc<AddProfileEvent, AddProfileState> {
  final PrifileAdminRepository adminRepository;
  AddProfileBloc(this.adminRepository) : super(AddProfileInitial()) {
    on<AddProfileRequested>((event, emit) async {
      emit(AddProfileLoading());
      final result = await adminRepository.addProfile(event.requestModel);
      result.fold(
        (l) => emit(AddProfileFailure(error: l)),
        (r) => emit(AddProfileSuccess(responseModel: r)),
      );
    });
  }
}
