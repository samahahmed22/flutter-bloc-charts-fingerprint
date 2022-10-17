import 'package:charts/core/utils/constants.dart';
import 'package:charts/features/charts/domain/entities/candle.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:charts/features/charts/presentation/cubit/charts_cubit.dart';
import 'package:charts/features/charts/presentation/widgets/drop_down_field.dart';
import 'package:charts/features/charts/presentation/widgets/submitButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/routes/app_routes.dart';
import '../widgets/date_picker_field.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<FormState> _userFormKey = GlobalKey();

  Map<String, String> _intervals = {
    '1d': 'Daily',
    '1wk': 'weekly',
    '1mo': 'Monthly'
  };
  DateTime? dateFrom;
  DateTime? dateTo;
  String? selectedInterval;

  Future<void> downloadSPUSFile(BuildContext context) async {
    if (!_userFormKey.currentState!.validate()) {
      return;
    } else {
      _userFormKey.currentState!.save();
      ChartsCubit.get(context)
          .downloadSPUSFile(dateFrom!, dateTo!, selectedInterval!);
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedInterval = _intervals.keys.first;

    return Scaffold(
        body: BlocConsumer<ChartsCubit, ChartsState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          Constants.showErrorDialog(context: context, msg: errorMsg);
        } else if (state is Loading) {
          Constants.showProgressIndicator(context);
        } else if (state is FileDownloaded) {
          ChartsCubit.get(context).getCandlesFromDownloadedFile();
        } else if (state is CandlesLoaded) {
          Navigator.pop(context);
          Navigator.of(context).pushNamed(Routes.candlesticksScreenRoute);
        }
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        if (state is FileDownloaded) {
        }
        return Form(
            key: _userFormKey,
            // child: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      DatePickerField('Start Date', (DateTime? from) {
                        dateFrom = from;
                      }),
                      DatePickerField('End Date', (DateTime? to) {
                        dateTo = to;
                      }),
                      DropDownField('Interval', _intervals,
                          (String? selectedItem) {
                        selectedInterval = selectedItem;
                      }),
                      SizedBox(height: 50),
                      SubmitButton(
                          onPress: () {
                            downloadSPUSFile(context);
                          },
                          text: 'Draw Chart')
                    ])
                // )
                ));
      },
    ));
  }
}
