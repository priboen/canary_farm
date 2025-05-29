import 'package:bloc/bloc.dart';
import 'package:canary_farm/data/models/request/admin/induk_request_model.dart';
import 'package:canary_farm/data/models/response/get_all_induk_response.dart';
import 'package:canary_farm/data/repository/induk_repository.dart';

part 'induk_event.dart';
part 'induk_state.dart';

class IndukBloc extends Bloc<IndukEvent, IndukState> {
  final IndukRepository repository;
  IndukBloc(this.repository) : super(IndukInitial()) {
    on<IndukGetAllEvent>((event, emit) async {
      emit(IndukLoadingState());
      final result = await repository.getAllInduk();
      result.fold(
        (l) => emit(IndukErrorState(errorMessage: l)),
        (r) => emit(IndukSuccessState(responseModel: r)),
      );
    });
    on<IndukRequestEvent>((event, emit) async {
      emit(IndukLoadingState());
      final result = await repository.addInduk(event.requestModel);
      result.fold(
        (l) => emit(IndukErrorState(errorMessage: l)),
        (r) => emit(IndukAddSuccessState(responseModel: r)),
      );
    });
  }
}
