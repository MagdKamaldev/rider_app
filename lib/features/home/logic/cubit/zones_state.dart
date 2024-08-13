part of 'zones_cubit.dart';

sealed class ZonesState {}

final class ZonesInitial extends ZonesState {}

final class ZonesLoading extends ZonesState {}

final class ZonesSuccess extends ZonesState {
  final List<ZoneReponse> zones;
  ZonesSuccess({required this.zones});
}

final class ZonesError extends ZonesState {
  final String message;
  ZonesError(this.message);
}

final class OpenShifLoading extends ZonesState {}

final class OpenShiftSuccess extends ZonesState {}

final class OpenShifError extends ZonesState {
  final String message;
  OpenShifError(this.message);
}
