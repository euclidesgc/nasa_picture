import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture/modules/home/domain/entities/media_entity.dart';
import 'package:nasa_picture/modules/home/domain/repositories/i_home_repository.dart';
import 'package:nasa_picture/modules/home/domain/usecases/get_nasa_media_usecase.dart';

class HomeRepositoryMock extends Mock implements IHomeRepository {}

void main() {
  late HomeRepositoryMock repository;
  late GetNasaMediaUsecase usecase;

  final List<MediaEntity> listMedia = [];
  final DateTime today = DateTime.now();
  final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
  final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

  setUp(() {
    repository = HomeRepositoryMock();
    usecase = GetNasaMediaUsecase(repository: repository);
  });

  test('should return a list of MediaEntity when GetNasaMediaUsecase is called', () async {
    // Arrange
    when(
      () => repository.getNasaMedia(initialDate: any(named: 'initialDate'), finalDate: any(named: 'finalDate')),
    ).thenAnswer(
      (_) async => listMedia,
    );

    // Act
    final result = await usecase(initialDate: yesterday, finalDate: today);

    // Assert
    expect(result, listMedia);

    verify(() => repository.getNasaMedia(
        initialDate: any(named: 'initialDate'),
        finalDate: any(
          named: 'finalDate',
        ))).called(1);
  });

  test('should return a error when getNasaMedia is called with an invalidDate', () async {
    // Arrange
    String futureDate = tomorrow.toString().substring(0, 10);

    when(
      () => repository.getNasaMedia(initialDate: any(named: 'initialDate'), finalDate: futureDate),
    ).thenThrow(Exception());

    // Assert
    expect(() => usecase(initialDate: yesterday, finalDate: tomorrow), throwsA(isA<Exception>()));

    verify(() => repository.getNasaMedia(initialDate: any(named: 'initialDate'), finalDate: futureDate)).called(1);
  });
}
