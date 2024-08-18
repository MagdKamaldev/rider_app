import 'package:dartz/dartz.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';

abstract class ZonesRepo {
  Future<Either<Failure, List<InfoModel>>> getZones();
  Future<Either<Failure, void>> startShift(int id);
}
