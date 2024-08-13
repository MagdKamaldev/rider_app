import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/networks/api_constants.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo_impl.dart';
import 'package:web_socket_channel/io.dart';
part 'orders_state.dart';




class OrdersCubit extends Cubit<OrdersState> {
  final OrdersRepoImpl repo;
  OrdersCubit(this.repo) : super(OrdersInitial());
  static OrdersCubit get(context) => BlocProvider.of(context);

  IOWebSocketChannel? _channel;
  Timer? _reconnectTimer;

  void openSocket(context) {
    final wsUrl = Uri.parse("ws://${ApiConstants.serverIp}:3006/api/rider/OrderWS");
    String token = kTokenBox.get(kTokenBoxString).toString();

    // Establish a new WebSocket connection
    _channel = IOWebSocketChannel.connect(
      wsUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    getOrders(context);
    // Listen for messages on the WebSocket stream
    _channel?.stream.listen(
      (message) {
        getOrders(context);
      },
      onError: (error) {
        _reconnect(context); // Attempt to reconnect on error
      },
      onDone: () {
        _reconnect(context); // Attempt to reconnect on closure
      },
    );

     // Initial call to getOrders
  }

  // Function to attempt reconnection with a delay
  void _reconnect(context) {
    if (_reconnectTimer == null || !_reconnectTimer!.isActive) {
      _reconnectTimer = Timer(const Duration(seconds: 5), () {
        openSocket(context);
      });
    }
  }

  // Function to manually close the WebSocket connection
  void closeSocket() {
    _reconnectTimer?.cancel();
    _channel?.sink.close();
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
}
