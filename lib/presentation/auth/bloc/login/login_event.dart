part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginRequested extends LoginEvent {
  final LoginRequestModel requestModel;

  LoginRequested({required this.requestModel});
}