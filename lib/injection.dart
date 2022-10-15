import 'package:charts/core/helpers/biometrics_helper.dart';
import 'package:charts/features/login/presentaion/cubit/login_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

final instance = GetIt.instance;
Future<void> init() async {
 
  instance.registerLazySingleton(() => LocalAuthentication());
  instance.registerLazySingleton<BiometricsHelper>(
      () => BiometricsHelperImpl(instance()));


  instance.registerLazySingleton<LoginCubit>(() => LoginCubit(instance()));
}
