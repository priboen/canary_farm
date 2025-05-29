part of 'get_burung_tersedia_bloc.dart';

sealed class GetBurungTersediaState {}

final class GetBurungTersediaInitial extends GetBurungTersediaState {}

final class GetBurungTersediaLoading extends GetBurungTersediaState {}

final class GetBurungTersediaLoaded extends GetBurungTersediaState {
  final BurungSemuaTersediaModel burungTersedia;
  GetBurungTersediaLoaded({required this.burungTersedia});
}

final class GetBurungTersediaError extends GetBurungTersediaState {
  final String message;
  GetBurungTersediaError({required this.message});
}
