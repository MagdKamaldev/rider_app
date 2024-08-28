// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/networks/api_constants.dart';
import 'package:tayaar/core/networks/errors/error_snckbar.dart';
import 'package:tayaar/features/checkingInfo/checking_info_screen.dart';
import 'package:tayaar/generated/l10n.dart';

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
  Future<void> connectToSse(
      {int retryCount = 0, required BuildContext context}) async {
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
          handleDisconnection(
              retryCount, context); // Handle disconnection on error
        },
        onDone: () {
          handleDisconnection(retryCount,
              context); // Handle disconnection when stream is closed
        },
      );
      if (retryCount > 0) {
        showSuccessSnackbar(context, S.of(context).sseRestoration);
      }
    } catch (e) {
      handleDisconnection(retryCount, context); 
    }
  }

  // Handle disconnections and retry connections
  void handleDisconnection(int retryCount, BuildContext context) {
    _subscription?.cancel();
    _controller.addError(S.of(context).sseDisconnection);

    if (retryCount < 5) {
      final delay = Duration(seconds: 2 * (retryCount + 1));
      Future.delayed(delay,
          () => connectToSse(retryCount: retryCount + 1, context: context));
    } else {
      navigateAndFinish(context, const CheckingInfo());
    }
  }

  void disconnectFromSse() {
    _subscription?.cancel();
    _controller.close();
  }
}
