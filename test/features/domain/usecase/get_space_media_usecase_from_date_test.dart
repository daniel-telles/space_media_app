import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/failures.dart';
import 'package:space_media_app/features/space_media/domain/entities/space_media_entity.dart';
import 'package:space_media_app/features/space_media/domain/repository/space_media_repository.dart';
import 'package:space_media_app/features/space_media/domain/usecase/get_space_media_from_date_usecase.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {

  //Definindo variáveis a serem utilizadas posteriormente.

  late GetSpaceMediaFromDateUsecase spaceMediaUsecase;
  late ISpaceMediaRepository repository;

  setUp(() => {

        //Inicializando minhas variáveis definidas.

        repository = MockSpaceMediaRepository(),
        spaceMediaUsecase = GetSpaceMediaFromDateUsecase(repository: repository)
      });


  //Instanciando minha Entidade.
  const tSpaceMedia = SpaceMediaEntity(
      description: 'description',
      mediaType: 'mediaType',
      title: 'title',
      mediaUrl: 'mediaUrl');

  final tDate = DateTime(2023, 11, 10);

  test('should get space media entity for a given date from the repository',
      () async {
        //Configurando o comportamento do mock
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => const Right<Failure, SpaceMediaEntity>(tSpaceMedia));

    final result = await spaceMediaUsecase(tDate);
    expect(result, const Right(tSpaceMedia));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });

  test('should return a ServerFailure when don\'t succeed', () async {
    when(() => repository.getSpaceMediaFromDate(tDate)).thenAnswer(
        (_) async => Left<Failure, SpaceMediaEntity>(ServerFailure()));

    final result = await spaceMediaUsecase(tDate);
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDate));
  });
}
