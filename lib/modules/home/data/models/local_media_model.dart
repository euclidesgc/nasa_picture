import 'media_model.dart';

class LocalMediaModel extends MediaModel {
  LocalMediaModel({
    required int id,
    required String copyright,
    required String date,
    required String explanation,
    required String hdurl,
    required String mediaType,
    required String serviceVersion,
    required String title,
    required String url,
  }) : super(
          copyright: copyright,
          date: date,
          explanation: explanation,
          hdurl: hdurl,
          mediaType: mediaType,
          serviceVersion: serviceVersion,
          title: title,
          url: url,
        );
}