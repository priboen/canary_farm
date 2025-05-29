part of 'anak_bloc.dart';

sealed class AnakEvent {}

class AnakRequestEvent extends AnakEvent {
  final AnakRequestModel requestModel;

  AnakRequestEvent({required this.requestModel});
}

class AnakGetAllEvent extends AnakEvent {}
