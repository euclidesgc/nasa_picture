import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_picture/modules/data_access/http_client/i_http_client.dart';
import 'package:nasa_picture/modules/data_access/local_storage/i_local_storage.dart';
import 'package:nasa_picture/modules/home/data/datasources/home_datasource.dart';
import 'package:nasa_picture/modules/home/data/models/local_media_model.dart';

import '../../../../fixtures.dart';

class ClientMock extends Mock implements IHttpClient {}

class LocalDbMock extends Mock implements ILocalStorage {}

class ConectivityMock extends Mock implements Connectivity {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  late ClientMock clientMock;
  late LocalDbMock localDbMock;
  late HomeDatasource datasource;
  late ConectivityMock conectivityMock;

  final String today = DateTime.now().toString().substring(0, 10);
  final String yesterday = DateTime.now().subtract(const Duration(days: 1)).toString().substring(0, 10);
  // final String tomorrow = DateTime.now().add(const Duration(days: 1)).toString().substring(0, 10);

  setUp(() {
    clientMock = ClientMock();
    localDbMock = LocalDbMock();
    conectivityMock = ConectivityMock();
    datasource = HomeDatasource(client: clientMock, localDb: localDbMock, connectivity: conectivityMock);
    registerFallbackValue(LocalMediaModel(
      id: 1,
      copyright: 'copyright',
      date: 'date',
      explanation: 'explanation',
      hdurl: 'hdurl',
      mediaType: 'media_type',
      serviceVersion: 'service_version',
      title: 'title',
      url: 'url',
    ));
  });

  test('should return a list of MediaModel when HomeDatasource.getNasaMedia is called', () async {
    // Arrange
    final List<LocalMediaModel> listMediaModelMock = List<Map<String, dynamic>>.from(fixture('media_list.json'))
        .map((e) => LocalMediaModel(
            id: 1,
            copyright: e['copyright'] ?? '',
            date: e['date'] ?? '',
            explanation: e['explanation'] ?? '',
            hdurl: e['hdurl'] ?? '',
            mediaType: e['media_type'] ?? '',
            serviceVersion: e['service_version'] ?? '',
            title: e['title'] ?? '',
            url: e['url'] ?? ''))
        .toList();

    when(() => conectivityMock.checkConnectivity()).thenAnswer(
      (_) async => ConnectivityResult.wifi,
    );

    when(() => localDbMock.getMediaList()).thenAnswer(
      (_) async => listMediaModelMock,
    );

    when(() => localDbMock.insertMedia(any())).thenAnswer((_) async {
      return;
    });

    when(
      () => clientMock.request(method: Method.GET, path: any(named: 'path'), queryParameters: any(named: 'queryParameters')),
    ).thenAnswer((_) async => Response(requestOptions: RequestOptions(path: ''), statusCode: 200, data: fixture('media_list.json')));

    // Act
    final result = await datasource.getNasaMedia(initialDate: yesterday, finalDate: today);

    // Assert
    expect(result, listMediaModelMock);
  });
}
