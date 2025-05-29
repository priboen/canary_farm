part of 'induk_bloc.dart';

sealed class IndukEvent {}

class IndukRequestEvent extends IndukEvent {
  final IndukRequestModel requestModel;

  IndukRequestEvent({required this.requestModel});
}

class IndukGetAllEvent extends IndukEvent {}
