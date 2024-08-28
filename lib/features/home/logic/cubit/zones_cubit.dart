import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/home/data/repos/zone_repos_impl.dart';
import 'package:tayaar/features/orders/UI/orders_screen.dart';

part 'zones_state.dart';

class ZonesCubit extends Cubit<ZonesState> {
  final ZonesRepoImpl repoImpl;
  ZonesCubit(this.repoImpl) : super(ZonesInitial());
  static ZonesCubit get(context) => BlocProvider.of(context);
  List<InfoModel> zones = [];

  void getZones(BuildContext context) async {
    emit(ZonesLoading());
    final response = await repoImpl.getZones();
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

  void openShift(BuildContext context, int id,Position position,String hubName,int orders) async {
    emit(OpenShifLoading());
    final response = await repoImpl.startShift(id,position);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(OpenShifError(
          l.message,
        ));
        getZones(context);
      },
      (r) {

       navigateAndFinish(context,OrdersScreen(hubName: hubName,todaysOrders: orders,));
       emit(OpenShiftSuccess());
      },
    );
  }
}
