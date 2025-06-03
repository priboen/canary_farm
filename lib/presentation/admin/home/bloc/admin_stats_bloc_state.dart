part of 'admin_stats_bloc.dart';

abstract class AdminStatsState {}

class AdminStatsInitial extends AdminStatsState {}

class AdminStatsLoading extends AdminStatsState {}

class AdminStatsSuccess extends AdminStatsState {
  final int totalInduk;
  final int totalAnak;
  final int totalBurungTersedia;

  AdminStatsSuccess({
    required this.totalInduk,
    required this.totalAnak,
    required this.totalBurungTersedia,
  });
}

class AdminStatsFailure extends AdminStatsState {
  final String message;

  AdminStatsFailure({required this.message});
}
