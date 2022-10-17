import 'dart:io';

import 'package:charts/core/utils/app_strings.dart';
import 'package:charts/core/utils/constants.dart';
import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/error/exceptions.dart';
import '../../domain/entities/candle.dart';
import '../models/candle_model.dart';

abstract class ChartsRemoteDataSource {
  Future<Unit> downloadSPUSFile(DateTime from, DateTime to, String interval);
  Future<List<Candle>> readCandlesFromCsvFile();
}

class ChartsRemoteDataSourceImpl implements ChartsRemoteDataSource {
  ApiConsumer apiConsumer;

  ChartsRemoteDataSourceImpl(this.apiConsumer);

  @override
  Future<Unit> downloadSPUSFile(
      DateTime from, DateTime to, String interval) async {
    String downloadPath = await Constants.downloadPath;
    String savePath = downloadPath + AppStrings.fileName;

    int fromTimestamp = (from.millisecondsSinceEpoch / 1000).toInt();
    int toTimestamp = (to.millisecondsSinceEpoch / 1000).toInt();

    final response = await apiConsumer.download(
      EndPoints.downloadSPUSFile,
      savePath: savePath,
      queryParameters: {
        'period1': fromTimestamp,
        'period2': toTimestamp,
        'interval': interval
      },
    );
    if (response.statusCode == 200) {
     print('**********************1');
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  Future<List<Candle>> readCandlesFromCsvFile() async {
     print('**********************2');
    String filePath = await Constants.downloadPath + AppStrings.fileName;
    try {
      final fileString = await File(filePath).readAsString();

      List<List<dynamic>> rowsAsListOfValues =
          const CsvToListConverter(eol: '\n').convert(fileString);
      List<dynamic> candleKeys = rowsAsListOfValues.removeAt(0);
      List<List<dynamic>> candlesValues = rowsAsListOfValues;

      List<Candle> candles = [];

      candlesValues.forEach((candle) {
        candles.add(CandleModel.fromCsvList(candle, candleKeys));
      });

      return candles;
    } catch (e) {
      throw NoDataException();
    }
  }
}
