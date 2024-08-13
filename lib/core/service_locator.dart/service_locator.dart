import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tayaar/core/networks/api_services/api_services.dart';
import 'package:tayaar/features/home/data/repos/zone_repos_impl.dart';
import 'package:tayaar/features/login/data/repos/login_repo_impl.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo%7C_impl.dart';

final getIt = GetIt.instance;
void setupLocator() {
  getIt.registerLazySingleton<ApiServices>(
    () => ApiServices(
      Dio(),
    ),
  );
  getIt.registerLazySingleton<LoginRepositoryImpelemntation>(
    () => LoginRepositoryImpelemntation(
      apiServices: getIt<ApiServices>(),
    ),
  );

  getIt.registerLazySingleton<ZonesRepoImpl>(
    () => ZonesRepoImpl(
      apiServices: getIt<ApiServices>(),
    ),
  );

  getIt.registerLazySingleton<OrdersRepoImpl>(
    () => OrdersRepoImpl(
      apiServices: getIt<ApiServices>(),
    ),
  );
}
