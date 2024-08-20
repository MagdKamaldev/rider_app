// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/login/UI/login_screen.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/core/components/shared_components.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginStates> {
  final LoginRepositoryImpelemntation repoImpl;
  LoginCubit(this.repoImpl) : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of(context);

  InfoModel? model;
  Position? myPosition;


  void login(BuildContext context, String name, String password) async {
    emit(LoginLoadingState());
    final response = await repoImpl.login(name, password);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(LoginErrorState(l.message));
      },
      (r) {
        emit(LoginSuccessState(r));
      },
    );
  }









Future<LocationPermission> checkAndRequestPermissions() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }

  Future<Position?> getCurrentLocation() async {
    LocationPermission permission = await checkAndRequestPermissions();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      emit(GetLocationError("Location permissions denied"));
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print("Current Position: ${position.latitude}, ${position.longitude}");
      return position;
    } catch (e) {
      emit(GetLocationError("Failed to get location: $e"));
      return null;
    }
  }

  void handleLocationPermissions(BuildContext context) async {
    emit(GetLocationLoading());
    Position? position = await getCurrentLocation();
    if (position != null) {
      myPosition = position;
      emit(GetLocationSuccess(position: position));
    }
  }


  void getInfo(BuildContext context) async {
    emit(InfoLoading());

    final response = await repoImpl.getInfo();

    response.fold(
      (l) {
        if (l.message == "Unauthorized") {
          navigateAndFinish(context, const LoginScreen());
          emit(InfoError("Unauthorized"));
          return;
        }
        showErrorSnackbar(context, l.message);
        emit(InfoError(l.message));
      },
      (r) {
        model = r;
        Future.delayed(const Duration(milliseconds: 500), () {
          emit(InfoSuccess(info: model!));
        });
      },
    );
  }
}