part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersSuccess extends OrdersState {}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError({required this.message});
}

final class ClaimOrderLoading  extends OrdersState {}

final class ClaimOrderSuccess extends OrdersState {}

final class ClaimOrderError extends OrdersState {
  final String message;
  ClaimOrderError({required this.message});
}

final class CloseShiftLoading extends OrdersState {}

final class CloseShiftSuccess extends OrdersState {}

final class CloseShiftError extends OrdersState {
  final String message;
  CloseShiftError({required this.message});
}
