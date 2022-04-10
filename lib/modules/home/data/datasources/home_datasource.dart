import 'dart:convert';
import 'dart:developer' as develop;

import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../data_access/i_http_client.dart';
import '../models/media_model.dart';
import 'i_home_datasource.dart';

class HomeDatasource implements IHomeDatasource {
  final IHttpClient client;

  HomeDatasource({required this.client});

  List<MediaModel> mediaModelFromJson(String str) => List<MediaModel>.from(jsonDecode(str).map((x) => MediaModel.fromJson(x)));

  @override
  Future<List<MediaModel>> getNasaMedia({required String initialDate, required String finalDate}) async {
    final String _nasaApiKey = dotenv.env['NASA_API_KEY']!;
    final String urlPath = dotenv.env['BASE_URL']!;

    try {
      final response = await client.request(
        method: Method.GET,
        path: urlPath,
        queryParameters: {
          'api_key': _nasaApiKey,
          'start_date': initialDate,
          'end_date': finalDate,
        },
      );

      return List<Map<String, dynamic>>.from(response.data).map((e) => MediaModel.fromMap(e)).toList();
    } catch (error, stackTrace) {
      develop.log('Erro ao obter media', error: error, stackTrace: stackTrace, name: 'Home_datasource.dart');
      throw Exception();
    }
  }
}
