import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';

abstract class ZonesRepo {
  Future<Either<Failure, List<InfoModel>>> getZones();
  Future<Either<Failure, dynamic>> startShift(int id,Position position);
}
