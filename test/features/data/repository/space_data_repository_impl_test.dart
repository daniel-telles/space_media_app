import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:space_media_app/core/errors/exceptions.dart';
import 'package:space_media_app/core/errors/failures.dart';
import 'package:space_media_app/features/space_media/data/datasource/space_media_datasource.dart';
import 'package:space_media_app/features/space_media/data/models/space_media_model.dart';
import 'package:space_media_app/features/space_media/data/repository/space_media_repository_impl.dart';

class MockSpaceMediaSource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImpl repositoryImpl;
  late ISpaceMediaDatasource spaceMediaDatasource;

  setUp(() {
    spaceMediaDatasource = MockSpaceMediaSource();
    repositoryImpl = SpaceMediaRepositoryImpl(spaceMediaDatasource);
  });

  const tSpaceMediaModel = SpaceMediaModel(
      description: 'description',
      mediaType: 'mediaType',
      title: 'title',
      mediaUrl: 'mediaUrl');

  final tDate = DateTime(2023, 11, 11);

  test('should return space media model when calls the datasource', () async {
    //Arrange
    when(() => spaceMediaDatasource.getSpaceMediaFromDate(tDate))
        .thenAnswer((_) async => tSpaceMediaModel);

    //Act
    final result = await repositoryImpl.getSpaceMediaFromDate(tDate);

    //Assert
    expect(result, const Right(tSpaceMediaModel));
    verify(() => spaceMediaDatasource.getSpaceMediaFromDate(tDate));
  });

  test(
      'should return a server failure when the call t datasource is unsuccessful',
      () async {
    //Arrange
    when(() => spaceMediaDatasource.getSpaceMediaFromDate(tDate))
        .thenThrow(ServerException());

    //Act
    final result = await repositoryImpl.getSpaceMediaFromDate(tDate);

    //Assert
    expect(result, Left(ServerFailure()));
  });
}
