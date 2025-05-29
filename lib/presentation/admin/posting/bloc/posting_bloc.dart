import 'package:bloc/bloc.dart';
import 'package:canary_farm/data/models/request/admin/posting_jual_request_model.dart';
import 'package:meta/meta.dart';

part 'posting_event.dart';
part 'posting_state.dart';

class PostingBloc extends Bloc<PostingEvent, PostingState> {
  PostingBloc() : super(PostingInitial()) {
    on<PostingEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
