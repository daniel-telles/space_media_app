import 'package:dartz/dartz.dart';
import 'package:space_media_app/core/errors/failures.dart';
import 'package:space_media_app/core/usecase/usecase.dart';
import 'package:space_media_app/features/space_media/domain/entities/space_media_entity.dart';

import '../repository/space_media_repository.dart';

class GetSpaceMediaFromDateUsecase implements Usecase<SpaceMediaEntity, DateTime> {

  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase({required this.repository});

  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime date) async {
    return await repository.getSpaceMediaFromDate(date);
  }
  

}