import 'package:charts/features/charts/data/data_sources/charts_remote_data_source.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:local_auth/local_auth.dart';

import 'core/api/api_consumer.dart';
import 'core/api/app_interceptors.dart';
import 'core/api/dio_consumer.dart';
import 'core/helpers/biometrics_helper.dart';
import 'core/network/network_info.dart';
import 'features/charts/data/repositories/charts_repository_imp.dart';
import 'features/charts/domain/repositories/charts_repository.dart';
import 'features/charts/domain/usecases/download_file.dart';
import 'features/charts/domain/usecases/get_candles.dart';
import 'features/charts/presentation/cubit/charts_cubit.dart';
import 'features/login/presentaion/cubit/login_cubit.dart';

final instance = GetIt.instance;
Future<void> init() async {
  // Features - login

// Bloc

  instance.registerLazySingleton<LoginCubit>(() => LoginCubit(instance()));

// Usecases
// Repository
// Datasources

  // Features - charts

// Bloc

  instance.registerLazySingleton<ChartsCubit>(
      () => ChartsCubit(downloadFile: instance(), getCandles: instance()));

// Usecases
  instance.registerLazySingleton<DownloadFileUsecase>(
      () => DownloadFileUsecase(instance()));
  instance.registerLazySingleton<GetCandlesUsecase>(
      () => GetCandlesUsecase(instance()));

// Repository

  instance.registerLazySingleton<ChartsRepository>(
      () => ChartsRepositoryImpl(instance(), instance()));

// Datasources

  instance.registerLazySingleton<ChartsRemoteDataSource>(
      () => ChartsRemoteDataSourceImpl(instance()));

// Core

  instance.registerLazySingleton<BiometricsHelper>(
      () => BiometricsHelperImpl(instance()));

  instance
      .registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(instance()));

  instance.registerLazySingleton<Dio>(() => Dio());
  instance.registerLazySingleton<AppIntercepters>(() => AppIntercepters());
  instance.registerLazySingleton<LogInterceptor>(() => LogInterceptor());
  instance.registerLazySingleton<ApiConsumer>(() => DioConsumer(instance()));

// External
  instance.registerLazySingleton(() => LocalAuthentication());
  instance.registerLazySingleton(() => InternetConnectionChecker());
}
