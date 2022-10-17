import 'package:charts/features/charts/domain/entities/candle.dart';

class CandleModel extends Candle {
  CandleModel({
    required DateTime date,
    required double open,
    required double high,
    required double low,
    required double close,
    required double adj_close,
    required double volume,
  }) : super(
            date: date,
            open: open,
            high: high,
            low: low,
            close: close,
            adj_close: adj_close,
            volume: volume);

  factory CandleModel.fromCsvList(List<dynamic> data, List<dynamic> keys) {
    return CandleModel(
        date: DateTime.tryParse(data[keys.indexOf('Date')])!,
        open: data[keys.indexOf('Open')].toDouble(),
        high: data[keys.indexOf('High')].toDouble(),
        low: data[keys.indexOf('Low')].toDouble(),
        close: data[keys.indexOf('Close')].toDouble(),
        adj_close: data[keys.indexOf('Adj Close')].toDouble(),
        volume: data[keys.indexOf('Volume')].toDouble());
  }
}
