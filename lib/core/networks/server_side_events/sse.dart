import 'dart:async';
import 'package:dio/dio.dart';
import 'package:tayaar/core/networks/api_constants.dart';

class SseService {
  final Dio dio;
  final String jwt;
  late final StreamController<dynamic> _controller;
  StreamSubscription<dynamic>? _subscription;

  SseService(this.dio, this.jwt) {
    _controller = StreamController.broadcast();
  }

  Stream<dynamic> get sseStream => _controller.stream;

  // Add a method to manage reconnections
  Future<void> connectToSse({int retryCount = 0}) async {
    const sseUrl = '${ApiConstants.baseUrl}${ApiConstants.orderSse}';
    try {
      final response = await dio.get(
        sseUrl,
        options: Options(
          headers: {
            'Authorization': 'Bearer $jwt',
            'Accept': 'text/event-stream',
          },
          responseType: ResponseType.stream,
        ),
      );

      _subscription = response.data.stream.listen(
        (data) {
          final event = String.fromCharCodes(data);
          _controller.add(event);
        },
        onError: (error) {
          _controller.addError(error);
          handleDisconnection(retryCount); // Handle disconnection on error
        },
        onDone: () {
          handleDisconnection(retryCount); // Handle disconnection when stream is closed
        },
      );
    } catch (e) {
      //print('Error connecting to SSE: $e');
      handleDisconnection(retryCount); // Handle disconnection on catch
    }
  }

  // Handle disconnections and retry connections
  void handleDisconnection(int retryCount) {
    _subscription?.cancel();
    _controller.addError('Disconnected from SSE');

    // Retry mechanism with exponential backoff
    if (retryCount < 5) {
      final delay = Duration(seconds: 2 * (retryCount + 1));
      //print('Attempting to reconnect in ${delay.inSeconds} seconds...');
      Future.delayed(delay, () => connectToSse(retryCount: retryCount + 1));
    } else {
      //print('Max retries reached. Could not reconnect to SSE.');
    }
  }

  void disconnectFromSse() {
    _subscription?.cancel();
    _controller.close();
  }
}