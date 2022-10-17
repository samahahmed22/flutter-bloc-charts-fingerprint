import 'package:charts/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../entities/candle.dart';

abstract class ChartsRepository {
  Future<Either<Failure, Unit>> downloadSPUSFile(
      DateTime from, DateTime to, String interval);

  Future<Either<Failure, List<Candle>>> getCandlesFromDownloadedFile();
}
