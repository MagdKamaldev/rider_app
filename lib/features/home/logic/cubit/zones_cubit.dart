import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/home/data/models/zone_reponse/zone_reponse.dart';
import 'package:tayaar/features/home/data/repos/zone_repos_impl.dart';
import 'package:tayaar/features/orders/UI/orders_screen.dart';

part 'zones_state.dart';

class ZonesCubit extends Cubit<ZonesState> {
  final ZonesRepoImpl repoImpl;
  ZonesCubit(this.repoImpl) : super(ZonesInitial());
  static ZonesCubit get(context) => BlocProvider.of(context);
  List<ZoneReponse> zones = [];

  void getZones(BuildContext context) async {
    emit(ZonesLoading());
    final response = await repoImpl.getzones();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(ZonesError(
          l.message,
        ));
      },
      (r) {
        emit(ZonesSuccess(zones: r));
      },
    );
  }

  void openShift(BuildContext context, int id) async {
    emit(OpenShifLoading());
    final response = await repoImpl.startShift(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(OpenShifError(
          l.message,
        ));
      },
      (r) {
        navigateAndFinish(context, const OrdersScreen());
        emit(OpenShiftSuccess());
      },
    );
  }
}
