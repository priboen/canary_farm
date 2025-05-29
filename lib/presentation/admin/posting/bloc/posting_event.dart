part of 'posting_bloc.dart';

sealed class PostingEvent {}

class PostingRequestEvent extends PostingEvent {
  final PostingJualRequestModel requestModel;

  PostingRequestEvent({required this.requestModel});
}
