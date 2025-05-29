import 'package:bloc/bloc.dart';

part 'admin_profile_event.dart';
part 'admin_profile_state.dart';

class AdminProfileBloc extends Bloc<AdminProfileEvent, AdminProfileState> {
  AdminProfileBloc() : super(AdminProfileInitial()) {
    on<AdminProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
