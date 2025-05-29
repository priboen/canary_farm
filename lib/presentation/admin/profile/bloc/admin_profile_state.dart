part of 'admin_profile_bloc.dart';

sealed class AdminProfileState {}

final class AdminProfileInitial extends AdminProfileState {}

final class AdminProfileLoadingState extends AdminProfileState {}

final class AdminProfileLoadedState extends AdminProfileState {
  final String name;

  AdminProfileLoadedState({required this.name});
}
