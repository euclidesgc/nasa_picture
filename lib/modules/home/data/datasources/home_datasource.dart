import 'dart:convert';
import 'dart:developer' as develop;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../data_access/http_client/i_http_client.dart';
import '../../../data_access/local_storage/i_local_storage.dart';
import '../models/local_media_model.dart';
import '../models/media_model.dart';
import 'i_home_datasource.dart';

class HomeDatasource implements IHomeDatasource {
  final IHttpClient client;
  final ILocalStorage localDb;

  HomeDatasource({required this.localDb, required this.client});

  List<MediaModel> mediaModelFromJson(String str) => List<MediaModel>.from(jsonDecode(str).map((x) => MediaModel.fromJson(x)));

  @override
  Future<List<MediaModel>> getNasaMedia({required String initialDate, required String finalDate}) async {
    final String _nasaApiKey = dotenv.env['NASA_API_KEY']!;
    final String urlPath = dotenv.env['BASE_URL']!;

    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      //Pega os dados do armazenamento local

      List<MediaModel> listMediaModels = await localDb.getMediaList();

      final filteredList = listMediaModels
          .where((element) {
            DateTime dataDoElemento = DateTime.parse(element.date);
            DateTime dataInicial = DateTime.parse(initialDate);
            DateTime dataFinal = DateTime.parse(finalDate);

            final inBetween = dataDoElemento.isAfter(dataInicial.subtract(const Duration(days: 1))) &&
                dataDoElemento.isBefore(dataFinal.add(const Duration(days: 1)));

            return inBetween;
          })
          .toSet()
          .toList();

      return filteredList;
    } else {
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

        final List<MediaModel> myList = List<Map<String, dynamic>>.from(response.data).map((e) => MediaModel.fromMap(e)).toList();

        for (var item in myList) {
          localDb.insertMedia(LocalMediaModel(
              id: int.parse(item.date.replaceAll('-', '')),
              copyright: item.copyright,
              date: item.date,
              explanation: item.explanation,
              hdurl: item.hdurl,
              mediaType: item.mediaType,
              serviceVersion: item.serviceVersion,
              title: item.title,
              url: item.url));
        }

        return myList;
      } catch (error, stackTrace) {
        develop.log('🟡 Erro ao obter media', error: error, stackTrace: stackTrace, name: 'Home_datasource.dart');
        throw Exception();
      }
    }
  }
}
