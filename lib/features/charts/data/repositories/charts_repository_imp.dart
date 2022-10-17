import 'package:charts/features/charts/domain/repositories/charts_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/candle.dart';
import '../data_sources/charts_remote_data_source.dart';

class ChartsRepositoryImpl extends ChartsRepository {
  final ChartsRemoteDataSource _chartsRemoteDataSource;
  final NetworkInfo _networkInfo;

  ChartsRepositoryImpl(this._chartsRemoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Unit>> downloadSPUSFile(
      DateTime from, DateTime to, String interval) async {
    if (await _networkInfo.isConnected) {
      try {
        await _chartsRemoteDataSource.downloadSPUSFile(from, to, interval);
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Candle>>> getCandlesFromDownloadedFile() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _chartsRemoteDataSource.readCandlesFromCsvFile();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
