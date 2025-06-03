part of 'posting_bloc.dart';

sealed class PostingState {}

final class PostingInitial extends PostingState {}

final class PostingLoading extends PostingState {}

final class PostingSuccess extends PostingState {
  final BurungSemuaTersediabyIdModel burung;

  PostingSuccess({required this.burung});
}

final class PostingFailure extends PostingState {
  final String error;

  PostingFailure({required this.error});
}

final class GetAllBurungState extends PostingState {
  final GetAllBurungModel responseModel;

  GetAllBurungState({required this.responseModel});
}
