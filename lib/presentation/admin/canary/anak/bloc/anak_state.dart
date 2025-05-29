part of 'anak_bloc.dart';

sealed class AnakState {}

final class AnakInitial extends AnakState {}

final class AnakLoadingState extends AnakState {}

final class AnakSuccessState extends AnakState {
  final GetAllAnakModel responseModel;

  AnakSuccessState({required this.responseModel});
}

final class AnakAddSuccessState extends AnakState {
  final GetAnakById responseModel;

  AnakAddSuccessState({required this.responseModel});
}

final class AnakFailureState extends AnakState {
  final String error;

  AnakFailureState({required this.error});
}
