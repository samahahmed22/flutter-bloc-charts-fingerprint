import 'package:equatable/equatable.dart';

class Candle extends Equatable {
  final DateTime date;
  final double open;
  final double high;
  final double low;
  final double close;
  final double adj_close;
  final double volume;

  Candle({
    required this.date,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.adj_close,
    required this.volume,
  });

  @override
  List<Object?> get props => [date, open, high, low, close, adj_close, volume];
}
