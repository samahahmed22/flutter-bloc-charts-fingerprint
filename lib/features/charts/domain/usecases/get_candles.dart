import 'package:charts/features/charts/domain/entities/candle.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/charts_repository.dart';

class GetCandlesUsecase {
  final ChartsRepository repository;
  GetCandlesUsecase(this.repository);

  Future<Either<Failure, List<Candle>>> call() async {
    return await repository.getCandlesFromDownloadedFile();
  }
}
