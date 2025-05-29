import 'package:canary_farm/data/models/request/admin/anak_request_model.dart';
import 'package:canary_farm/data/models/response/get_all_anak_response.dart';
import 'package:canary_farm/data/repository/anak_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'anak_event.dart';
part 'anak_state.dart';

class AnakBloc extends Bloc<AnakEvent, AnakState> {
  final AnakRepository anakRepository;
  AnakBloc(this.anakRepository) : super(AnakInitial()) {
    on<AnakRequestEvent>((event, emit) async {
      emit(AnakLoadingState());
      final result = await anakRepository.addAnak(event.requestModel);
      result.fold(
        (l) => emit(AnakFailureState(error: l)),
        (r) => emit(AnakAddSuccessState(responseModel: r)),
      );
    });

    on<AnakGetAllEvent>((event, emit) async {
      emit(AnakLoadingState());
      final result = await anakRepository.getAllAnak();
      result.fold(
        (l) => emit(AnakFailureState(error: l)),
        (r) => emit(AnakSuccessState(responseModel: r)),
      );
    });
  }
}
