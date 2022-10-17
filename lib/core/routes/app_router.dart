import 'package:charts/features/charts/presentation/screens/candlesticks_screen.dart';
import 'package:charts/features/login/presentaion/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/charts/presentation/cubit/charts_cubit.dart';
import '../../features/charts/presentation/screens/home_screen.dart';
import '../../features/login/presentaion/screens/login_screen.dart';
import '../../features/splash/presentaion/screens/splash_screen.dart';
import '../utils/app_strings.dart';
import 'app_routes.dart';
import '../../injection.dart' as di;

class AppRouter {
  static ChartsCubit chartsCubit = di.instance<ChartsCubit>();
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashScreenRoute:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case Routes.loginScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<LoginCubit>(
                  create: (BuildContext context) =>
                      di.instance<LoginCubit>()..isBiometricsEnabled(),
                  child: LoginScreen(),
                ));

      case Routes.homeScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ChartsCubit>.value(
                  value: chartsCubit,
                  child: HomeScreen(),
                ));

      case Routes.candlesticksScreenRoute:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ChartsCubit>.value(
                  value: chartsCubit,
                  child: CandlesticksScreen(),
                ));

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
