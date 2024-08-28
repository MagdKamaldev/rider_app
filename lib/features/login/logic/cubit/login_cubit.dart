// ignore_for_file: deprecated_member_use

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/login/UI/login_screen.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/core/components/shared_components.dart';

part 'login_state.dart';

late LocationSettings locationSettings;

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
    if (defaultTargetPlatform == TargetPlatform.android) {
  locationSettings = AndroidSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
      forceLocationManager: true,
      intervalDuration: const Duration(seconds: 10),
      //(Optional) Set foreground notification config to keep the app alive 
      //when going to the background
      foregroundNotificationConfig: const ForegroundNotificationConfig(
        notificationText:
        "Example app will continue to receive your location even when you aren't using it",
        notificationTitle: "Running in Background",
        enableWakeLock: true,
      )
  );
} else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
  locationSettings = AppleSettings(
    accuracy: LocationAccuracy.high,
    activityType: ActivityType.fitness,
    distanceFilter: 100,

  );
} else if (kIsWeb) {
  locationSettings = WebSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
    maximumAge: const Duration(minutes: 5),
  );
} else {
  locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
}
    LocationPermission permission = await checkAndRequestPermissions();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      emit(GetLocationError("Location permissions denied"));
      return null;
    }
   
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationSettings: locationSettings,
      );
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