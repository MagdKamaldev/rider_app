import 'package:dartz/dartz.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';

abstract class OrdersRepo {
  Future<Either<Failure, List<OrderModel>>> getOrders();
  Future<Either<Failure, dynamic>> claimOrder(int id);
  Future<Either<Failure, dynamic>> closeShift();
  Future<Either<Failure, OrderModel>> getCurrentOrder();
  Future<Either<Failure, dynamic>> closeOrder(int id);
}
