import 'package:charts/core/utils/constants.dart';
import 'package:charts/features/login/presentaion/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/asstes_maneger.dart';
import '../../../../core/widgets/login_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushNamed(Routes.homeScreenRoute);
        } else if (state is BiometricsIsEnabled) {
          LoginCubit.get(context).isAuthenticated();
        } else if (state is NoBiometricFound) {
          Constants.showErrorDialog(
              context: context,
              onPress: () => SystemNavigator.pop(),
              msg:
                  'Finger print or face id is required please enable one of them and try again');
        }
      },
      buildWhen: (previous, current) {
        return false;
      },
      builder: (context, state) {
        return Scaffold(
          body: const Center(
              child: Image(image: AssetImage(ImgAssets.splashLogo))),
        );
        // if (state is BiometricsIsEnabled) {
        //   return Center(
        //     child:
        //      LoginButton(
        //         text: 'Authenticate',
        //         onPress: () {
        //           // LoginCubit.get(context).isAuthenticated();
        //         }),
        //   );
        // } else if (state is NoBiometricFound) {
        //   return Center(
        //     child: Text(
        //         'finger print or face id is required please enable one of them then retry'),
        //   );
        // }
        // return Container();
      },
    );
  }
}
