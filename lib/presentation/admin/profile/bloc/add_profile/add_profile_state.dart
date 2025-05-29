part of 'add_profile_bloc.dart';

sealed class AddProfileState {}

final class AddProfileInitial extends AddProfileState {}

final class AddProfileLoading extends AddProfileState {}

final class AddProfileSuccess extends AddProfileState {
  final AdminProfileResponseModel responseModel;

  AddProfileSuccess({required this.responseModel});
}

final class AddProfileFailure extends AddProfileState {
  final String error;

  AddProfileFailure({required this.error});
}
