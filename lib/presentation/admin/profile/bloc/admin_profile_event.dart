part of 'admin_profile_bloc.dart';

sealed class AdminProfileEvent {}

class AdminProfileLoadEvent extends AdminProfileEvent {}

class AddAdminProfileEvent extends AdminProfileEvent {
  final String name;

  AddAdminProfileEvent({required this.name});
}
