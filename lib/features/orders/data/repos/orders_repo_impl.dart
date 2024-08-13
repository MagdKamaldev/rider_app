import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/networks/api_constants.dart';
import 'package:tayaar/core/networks/api_services/api_services.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo.dart';

class OrdersRepoImpl implements OrdersRepo {
  final ApiServices apiServices;
  OrdersRepoImpl({required this.apiServices});
  @override
  Future<Either<Failure, List<OrderModel>>> getOrders() async {
    try {
      final response = await apiServices.get(
          endPoint: ApiConstants.getOrders,
          jwt: kTokenBox.get(kTokenBoxString).toString());
      if (response['data'] == null) {
        return const Right([]);
      }
      final List<dynamic> data = response['data'];
      final List<OrderModel> orders =
          data.map((orderJson) => OrderModel.fromJson(orderJson)).toList();

      return Right(orders);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> claimOrder(int id) async {
    try {
      final response = await apiServices.post(
          endPoint: ApiConstants.claimOrder,
          data: {"order_id": id},
          jwt: kTokenBox.get(kTokenBoxString).toString());
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> closeShift() async {
    try {
      final response = await apiServices.get(
          endPoint: ApiConstants.closeShift,
          jwt: kTokenBox.get(kTokenBoxString).toString());
      return const Right(null);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }
}
