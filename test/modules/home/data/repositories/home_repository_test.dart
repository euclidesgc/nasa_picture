import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture/modules/home/data/datasources/i_home_datasource.dart';
import 'package:nasa_picture/modules/home/data/models/media_model.dart';
import 'package:nasa_picture/modules/home/data/repositories/home_repository.dart';

class HomeDatasourceyMock extends Mock implements IHomeDatasource {}

void main() {
  late HomeDatasourceyMock datasource;
  late HomeRepository repository;

  final List<MediaModel> listMediaModel = [];
  final String today = DateTime.now().toString().substring(0, 10);
  final String yesterday = DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10);
  final String tomorrow = DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10);

  setUp(() {
    datasource = HomeDatasourceyMock();
    repository = HomeRepository(datasource: datasource);
  });

  test('should return a list of MediaModel when HomeRepository.getNasaMedia is called', () async {
    // Arrange
    when(
      () => datasource.getNasaMedia(initialDate: any(named: 'initialDate'), finalDate: any(named: 'finalDate')),
    ).thenAnswer(
      (_) async => listMediaModel,
    );

    // Act
    final result = await repository.getNasaMedia(initialDate: yesterday, finalDate: today);

    // Assert
    expect(result, listMediaModel);

    verify(() => datasource.getNasaMedia(
        initialDate: any(named: 'initialDate'),
        finalDate: any(
          named: 'finalDate',
        ))).called(1);
  });

  test('should return a error when HomeRepository.getNasaMedia is called with an invalidDate', () async {
    when(
      () => datasource.getNasaMedia(initialDate: any(named: 'initialDate'), finalDate: tomorrow),
    ).thenThrow(Exception());

    // Assert
    expect(() => repository.getNasaMedia(initialDate: yesterday, finalDate: tomorrow), throwsA(isA<Exception>()));

    verify(() => datasource.getNasaMedia(initialDate: any(named: 'initialDate'), finalDate: tomorrow)).called(1);
  });
}
