import 'package:charts/features/charts/domain/entities/candle.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/app_strings.dart';
import '../../domain/usecases/download_file.dart';
import '../../domain/usecases/get_candles.dart';

part 'charts_state.dart';

class ChartsCubit extends Cubit<ChartsState> {
  DownloadFileUsecase downloadFile;
  GetCandlesUsecase getCandles;
  ChartsCubit({required this.downloadFile, required this.getCandles})
      : super(ChartsInitial());

  static ChartsCubit get(context) => BlocProvider.of(context);

  void downloadSPUSFile(DateTime from, DateTime to, String interval) async {
    
    emit(Loading());
    Either<Failure, Unit> response = await downloadFile(from, to, interval);
    response.fold(
        (failure) => emit(ErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (_) => emit(FileDownloaded()));
  }

  void getCandlesFromDownloadedFile() async {
    print('**********************3');
    Either<Failure, List<Candle>> response = await getCandles();
   
    response.fold(
        (failure) => emit(ErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (candles) => emit(CandlesLoaded(candles)));
  }

  String _userFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offlineFailure;
      case NoDataFailure:
        return AppStrings.noDataFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
