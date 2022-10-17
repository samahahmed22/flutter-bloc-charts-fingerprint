import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../repositories/charts_repository.dart';

class DownloadFileUsecase {
  final ChartsRepository repository;
  DownloadFileUsecase(this.repository);

  Future<Either<Failure, Unit>> call(
      DateTime from, DateTime to, String interval) async {
    return await repository.downloadSPUSFile(from, to, interval);
  }
}
