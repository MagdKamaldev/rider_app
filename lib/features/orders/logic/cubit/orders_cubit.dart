import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/core/networks/server_side_events/sse.dart';
import 'package:tayaar/features/orders/UI/order_details_screen.dart';
import 'package:tayaar/features/orders/UI/orders_screen.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo_impl.dart';
part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepoImpl repo;
  OrdersCubit(
    this.repo,
  ) : super(OrdersInitial());

  static OrdersCubit get(context) => BlocProvider.of(context);
  
  final SseService sseService = SseService(Dio(), kTokenBox.get(kTokenBoxString));

  void startListeningToOrders(context) {
    sseService.connectToSse(context: context);
    sseService.sseStream.listen(
      (event) {
        getOrders(context);
        fetchQueueNumber(context);
      },
      onError: (error) {
        showErrorSnackbar(context, error.toString());
      },
    );
  }

  void stopListeningToOrders() {
    sseService.disconnectFromSse();
  }

  List<OrderModel> orders = [];

  void getOrders(context) async {
    final response = await repo.getOrders();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(OrdersError(
          message: l.message,
        ));
      },
      (r) {
        orders = r;
        emit(OrdersSuccess());
      },
    );
  }

  void claimOrder(BuildContext context, int id, String hubName, int orders) async {
    emit(ClaimOrderLoading());
    final response = await repo.claimOrder(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(ClaimOrderError(
          message: l.message,
        ));
      },
      (r) {
        navigateAndFinish(
          context,
          OrderDetailsScreen(
            hubName: hubName,
            todaysOrders: orders,
          ),
        );
        emit(ClaimOrderSuccess());
      },
    );
  }

  void closeShift(BuildContext context) async {
    emit(CloseShiftLoading());
    final response = await repo.closeShift();
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(CloseShiftError(
          message: l.message,
        ));
      },
      (r) {
        emit(CloseShiftSuccess());
      },
    );
  }

  OrderModel? currentOrder;

  void getOrder() {
    emit(GetOrderLoading());
    repo.getCurrentOrder().then((value) {
      value.fold((l) {
        emit(GetOrderError(message: l.message));
      }, (r) {
        currentOrder = r;
        emit(GetOrderSuccess());
      });
    });
  }

  void closeOrder(BuildContext context, int id, String hubName, int orders) async {
    emit(CloseOrderLoading());
    final response = await repo.closeOrder(id);
    response.fold(
      (l) {
        showErrorSnackbar(context, l.message);
        emit(CloseOrderError(
          message: l.message,
        ));
      },
      (r) {
        fetchQueueNumber(context); // Re-fetch queue number after closing order
        navigateAndFinish(
          context,
          OrdersScreen(
            hubName: hubName,
            todaysOrders: orders,
          ),
        );
        emit(CloseOrderSuccess());
      },
    );
  }

  int? queueNumber;

  Future<void> fetchQueueNumber(BuildContext context) async {
    emit(FetchQueueNumebrLoading());
    final response = await repo.fetchQueueNumber();
    response.fold(
      (l) {
        emit(FetchQueueNumebrError(message: l.message));
        return;
      },
      (r) {
        queueNumber = r;
        emit(FetchQueueNumebrSuccess(queueNumber: r));
        
        // Check if queue number is zero
        if (queueNumber == 0) {
          stopListeningToOrders(); // Disconnect from SSE
          startListeningToOrders(context); // Reconnect to SSE
        }
        return;
      },
    );
  }
}
