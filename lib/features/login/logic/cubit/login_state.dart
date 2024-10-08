part of 'login_cubit.dart';

sealed class LoginStates {}

final class LoginInitial extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String jwt;
  LoginSuccessState(this.jwt);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

final class InfoLoading extends LoginStates {}

final class InfoSuccess extends LoginStates {
  final InfoModel info;
  InfoSuccess({required this.info});
}

final class GetLocationLoading extends LoginStates {}

final class GetLocationSuccess extends LoginStates {
  final Position position;
  GetLocationSuccess({required this.position});
}

final class GetLocationError extends LoginStates {
  final String message;
  GetLocationError(this.message);
}

final class InfoError extends LoginStates {
  final String message;
  InfoError(this.message);
}
