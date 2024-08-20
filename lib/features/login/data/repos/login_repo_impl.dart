import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/networks/api_constants.dart';
import 'package:tayaar/core/networks/api_services/api_services.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/login/data/repos/login_repo.dart';
import 'package:tayaar/main.dart';

class LoginRepositoryImpelemntation implements LoginRepo {
  final ApiServices apiServices;
  LoginRepositoryImpelemntation({required this.apiServices});

  @override
  Future<Either<Failure, String>> login(
      String username, String password) async {
    try {
      final response = await apiServices.post(
        data: {"username": username, "password": password},
        endPoint: ApiConstants.login,
      );

      token = response["jwt"];
      kTokenBox.put(kTokenBoxString, token);
      return Right(response["jwt"]);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, InfoModel>> getInfo() async {
   // try {
      final response = await apiServices.get(
          endPoint: ApiConstants.getInfo,
          jwt: kTokenBox.get(kTokenBoxString).toString());
      final model = InfoModel.fromJson(response["data"]);
      return Right(model);
  //  } catch (e) {
   //   if (e is DioException) {
   //     if (e.response!.statusCode == 401) {
   //       return Left(ServerFailure("Unauthorized"));
   //     }
   //     return Left(ServerFailure.fromDioError(e));
  //    } else {
   //     return Left(ServerFailure(e.toString()));
   //   }
  //   }
  }
}
