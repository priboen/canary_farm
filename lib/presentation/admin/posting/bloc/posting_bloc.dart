import 'package:canary_farm/data/models/request/admin/posting_jual_request_model.dart';
import 'package:canary_farm/data/models/response/burung_semua_tersedia_model.dart';
import 'package:canary_farm/data/models/response/get_all_burung_response_model.dart';
import 'package:canary_farm/data/repository/posting_repostory.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posting_event.dart';
part 'posting_state.dart';

class PostingBloc extends Bloc<PostingEvent, PostingState> {
  final PostingRepostory postingRepostory;
  PostingBloc(this.postingRepostory) : super(PostingInitial()) {
    on<PostingRequestEvent>(_onPostingRequest);
    on<GetAllBurungPostingEvent>(_onGetAllBurungPosting);
  }

  Future<void> _onPostingRequest(
    PostingRequestEvent event,
    Emitter<PostingState> emit,
  ) async {
    emit(PostingLoading());
    final result = await postingRepostory.addPostBurung(event.requestModel);
    result.fold(
      (error) => emit(PostingFailure(error: error)),
      (burung) => emit(PostingSuccess(burung: burung)),
    );
  }

  Future<void> _onGetAllBurungPosting(
    GetAllBurungPostingEvent event,
    Emitter<PostingState> emit,
  ) async {
    final result = await postingRepostory.getAllBurung();
    result.fold(
      (error) => emit(PostingFailure(error: error)),
      (responseModel) => emit(GetAllBurungState(responseModel: responseModel)),
    );
  }
}
