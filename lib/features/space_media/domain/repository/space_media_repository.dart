import 'package:dartz/dartz.dart';
import 'package:space_media_app/core/errors/failures.dart';
import 'package:space_media_app/features/space_media/domain/entities/space_media_entity.dart';

abstract class ISpaceMediaRepository {

  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime date);
  
}