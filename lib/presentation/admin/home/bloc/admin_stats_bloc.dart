import 'package:canary_farm/data/repository/anak_repository.dart';
import 'package:canary_farm/data/repository/get_all_burung_tersedia_repository.dart';
import 'package:canary_farm/data/repository/induk_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'admin_stats_bloc_event.dart';
part 'admin_stats_bloc_state.dart';

class AdminStatsBloc extends Bloc<AdminStatsEvent, AdminStatsState> {
  final IndukRepository indukRepo;
  final AnakRepository anakRepo;
  final GetAllBurungTersediaRepository burungRepo;

  AdminStatsBloc(this.indukRepo, this.anakRepo, this.burungRepo)
    : super(AdminStatsInitial()) {
    on<LoadAdminDasboarStats>(_onLoadDashboard);
  }

  Future<void> _onLoadDashboard(
    AdminStatsEvent event,
    Emitter<AdminStatsState> emit,
  ) async {
    emit(AdminStatsLoading());

    final indukResult = await indukRepo.getAllInduk();
    final anakResult = await anakRepo.getAllAnak();
    final burungResult = await burungRepo.getAllBurungTersedia();

    if (indukResult.isRight() &&
        anakResult.isRight() &&
        burungResult.isRight()) {
      final indukCount = indukResult.getOrElse(() => throw {}).data.length;
      final anakCount = anakResult.getOrElse(() => throw {}).data.length;
      final burungCount = burungResult.getOrElse(() => throw {}).data.length;

      emit(
        AdminStatsSuccess(
          totalInduk: indukCount,
          totalAnak: anakCount,
          totalBurungTersedia: burungCount,
        ),
      );
    } else {
      emit(AdminStatsFailure(message: "Gagal mengambil data dashboard"));
    }
  }
}
