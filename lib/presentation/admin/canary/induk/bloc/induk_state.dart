part of 'induk_bloc.dart';

sealed class IndukState {}

final class IndukInitial extends IndukState {}

final class IndukLoadingState extends IndukState {}

final class IndukSuccessState extends IndukState {
  final GetAllIndukModel responseModel;

  IndukSuccessState({required this.responseModel});
}

final class IndukAddSuccessState extends IndukState {
  final GetIndukById responseModel;

  IndukAddSuccessState({required this.responseModel});
}

final class IndukErrorState extends IndukState {
  final String errorMessage;

  IndukErrorState({required this.errorMessage});
}
