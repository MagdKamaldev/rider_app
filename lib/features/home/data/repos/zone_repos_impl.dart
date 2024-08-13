// ignore_for_file: unused_local_variable
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/networks/api_constants.dart';
import 'package:tayaar/core/networks/api_services/api_services.dart';
import 'package:tayaar/core/networks/errors/error.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/home/data/models/zone_reponse/zone_reponse.dart';
import 'package:tayaar/features/home/data/repos/zone_repo.dart';

class ZonesRepoImpl implements ZonesRepo {
  final ApiServices apiServices;
  ZonesRepoImpl({required this.apiServices});

  @override
  Future<Either<Failure, List<ZoneReponse>>> getzones() async {
    try {
      final response = await apiServices.getList(
          endPoint: ApiConstants.fetchZones,
          jwt: kTokenBox.get(kTokenBoxString).toString());
      final List<dynamic> zonesJson = response;

      // Map the JSON array to a List<ZoneResponse>
      final List<ZoneReponse> zones =
          zonesJson.map((json) => ZoneReponse.fromJson(json)).toList();

      return Right(zones);
    } catch (e) {
      if (e is DioException) {
        return Left(ServerFailure.fromDioError(e));
      } else {
        return Left(ServerFailure(e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> startShift(int id) async {
    try {
      final response = apiServices.post(
          endPoint: ApiConstants.startShift,
          data: {"zone_id": id},
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
