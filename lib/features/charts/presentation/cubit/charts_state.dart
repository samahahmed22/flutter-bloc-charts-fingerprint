part of 'charts_cubit.dart';

abstract class ChartsState extends Equatable {
  const ChartsState();

  @override
  List<Object> get props => [];
}

class ChartsInitial extends ChartsState {}

class ErrorOccurred extends ChartsState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}

class Loading extends ChartsState {}

class FileDownloaded extends ChartsState {}

class CandlesLoaded extends ChartsState {
  final List<Candle> candles;
  CandlesLoaded(this.candles);
}

class ChartDrawen extends ChartsState {}
