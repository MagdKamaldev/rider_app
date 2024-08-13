import 'package:dartz/dartz.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';

abstract class LoginRepo {
  Future<Either<Failure, String>> login(String name, String password);
  Future<Either<Failure, InfoModel>> getInfo();
}
