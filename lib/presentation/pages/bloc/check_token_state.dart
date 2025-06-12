part of 'check_token_bloc.dart';

sealed class CheckTokenState {}

final class CheckTokenInitial extends CheckTokenState {}

class SplashLoading extends CheckTokenState {}

class SplashAuthenticated extends CheckTokenState {
  final String role;
  SplashAuthenticated(this.role);
}

class SplashUnauthenticated extends CheckTokenState {}
