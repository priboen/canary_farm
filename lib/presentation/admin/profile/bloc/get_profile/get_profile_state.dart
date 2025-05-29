part of 'get_profile_bloc.dart';

sealed class GetProfileState {}

final class GetProfileInitial extends GetProfileState {}

final class GetProfileLoading extends GetProfileState {}

final class GetProfileSuccess extends GetProfileState {
  final AdminProfileResponseModel responseModel;

  GetProfileSuccess({required this.responseModel});
}

final class GetProfileFailure extends GetProfileState {
  final String error;

  GetProfileFailure({required this.error});
}