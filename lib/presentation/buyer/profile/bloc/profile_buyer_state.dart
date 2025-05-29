part of 'profile_buyer_bloc.dart';

sealed class ProfileBuyerState {}

final class ProfileBuyerInitial extends ProfileBuyerState {}

final class ProfileBuyerLoading extends ProfileBuyerState {}

final class ProfileBuyerLoaded extends ProfileBuyerState {
  final BuyerProfileResponseModel profile;

  ProfileBuyerLoaded({required this.profile});
}

final class ProfileBuyerError extends ProfileBuyerState {
  final String message;

  ProfileBuyerError({required this.message});
}

final class ProfileBuyerAdded extends ProfileBuyerState {
  final BuyerProfileResponseModel profile;

  ProfileBuyerAdded({required this.profile});
}

final class ProfileBuyerAddError extends ProfileBuyerState {
  final String message;

  ProfileBuyerAddError({required this.message});
}
