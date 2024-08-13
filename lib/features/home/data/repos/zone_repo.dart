import 'package:dartz/dartz.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/home/data/models/zone_reponse/zone_reponse.dart';

abstract class ZonesRepo {
  Future<Either<Failure, List<ZoneReponse>>> getzones();
  Future<Either<Failure, void>> startShift(int id);
}
