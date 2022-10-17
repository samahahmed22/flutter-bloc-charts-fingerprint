import 'package:charts/core/utils/constants.dart';
import 'package:charts/features/login/presentaion/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../../../../core/utils/asstes_maneger.dart';
import '../../../../core/widgets/submitButton.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).pushReplacementNamed(Routes.homeScreenRoute);
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
          body: Center(
              child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Image(image: AssetImage(ImgAssets.splashLogo)),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom:60.0),
                  child: SubmitButton(
        
                      text: 'START',
                      onPress: () {
                        LoginCubit.get(context).isAuthenticated();
                      }),
                ),
              ),
            ],
          )),
        );
      },
    );
  }
}
