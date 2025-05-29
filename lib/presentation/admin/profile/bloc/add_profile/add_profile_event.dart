part of 'add_profile_bloc.dart';

sealed class AddProfileEvent {}

class AddProfileRequested extends AddProfileEvent {
  final AdminProfileRequestModel requestModel;

  AddProfileRequested({required this.requestModel});
}