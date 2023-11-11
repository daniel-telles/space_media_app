import 'package:dartz/dartz.dart';
import 'package:space_media_app/core/errors/failures.dart';
import 'package:space_media_app/features/space_media/domain/entities/space_media_entity.dart';
import 'package:space_media_app/features/space_media/domain/repository/space_media_repository.dart';

import '../../../../core/errors/exceptions.dart';
import '../datasource/space_media_datasource.dart';

class SpaceMediaRepositoryImpl implements ISpaceMediaRepository {
  final ISpaceMediaDatasource spaceMediaDatasource;

  SpaceMediaRepositoryImpl(this.spaceMediaDatasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(
      DateTime date) async {
    try {
      final result = await spaceMediaDatasource.getSpaceMediaFromDate(date);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
