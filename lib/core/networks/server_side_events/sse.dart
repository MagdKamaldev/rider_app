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

  void connectToSse() {
    const sseUrl = '${ApiConstants.baseUrl}${ApiConstants.orderSse}';

    dio.get(
      sseUrl,
      options: Options(
        headers: {
          'Authorization': 'Bearer $jwt',
          'Accept': 'text/event-stream',
        },
        responseType: ResponseType.stream,
      ),
    ).then((response) {
      _subscription = response.data.stream.listen(
        (data) {
          final event = String.fromCharCodes(data);
          _controller.add(event);
        },
        onError: (error) {
          _controller.addError(error);
        },
        onDone: () {
          _controller.close();
        },
      );
    }).catchError((error) {
      print('Error connecting to SSE: $error');
    });
  }

  void disconnectFromSse() {
    _subscription?.cancel();
    _controller.close();
  }
}