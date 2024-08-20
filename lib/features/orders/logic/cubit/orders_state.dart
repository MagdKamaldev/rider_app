part of 'orders_cubit.dart';

sealed class OrdersState {}

final class OrdersInitial extends OrdersState {}

final class OrdersLoading extends OrdersState {}

final class OrdersSuccess extends OrdersState {}

final class OrdersError extends OrdersState {
  final String message;
  OrdersError({required this.message});
}

final class ClaimOrderLoading extends OrdersState {}

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

final class GetOrderLoading extends OrdersState {}

final class GetOrderSuccess extends OrdersState {}

final class GetOrderError extends OrdersState {
  final String message;
  GetOrderError({required this.message});
}

final class CloseOrderLoading extends OrdersState {}

final class CloseOrderSuccess extends OrdersState {}

final class CloseOrderError extends OrdersState {
  final String message;
  CloseOrderError({required this.message});
}

final class FetchQueueNumebrLoading extends OrdersState {}

final class FetchQueueNumebrSuccess extends OrdersState {
  final int queueNumber;
  FetchQueueNumebrSuccess({required this.queueNumber});
}

final class FetchQueueNumebrError extends OrdersState {
  final String message;
  FetchQueueNumebrError({required this.message});
}