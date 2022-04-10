import 'dart:convert';

import '../../domain/entities/media_entity.dart';

class MediaModel {
  final String copyright;
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String serviceVersion;
  final String title;
  final String url;

  MediaModel({
    this.copyright = '',
    this.date = '',
    this.explanation = '',
    this.hdurl = '',
    this.mediaType = '',
    this.serviceVersion = '',
    this.title = '',
    this.url = '',
  });

  MediaModel copyWith({
    String? copyright,
    String? date,
    String? explanation,
    String? hdurl,
    String? mediaType,
    String? serviceVersion,
    String? title,
    String? url,
  }) {
    return MediaModel(
      copyright: copyright ?? this.copyright,
      date: date ?? this.date,
      explanation: explanation ?? this.explanation,
      hdurl: hdurl ?? this.hdurl,
      mediaType: mediaType ?? this.mediaType,
      serviceVersion: serviceVersion ?? this.serviceVersion,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'copyright': copyright});
    result.addAll({'date': date});
    result.addAll({'explanation': explanation});
    result.addAll({'hdurl': hdurl});
    result.addAll({'mediaType': mediaType});
    result.addAll({'serviceVersion': serviceVersion});
    result.addAll({'title': title});
    result.addAll({'url': url});

    return result;
  }

  factory MediaModel.fromMap(Map<String, dynamic> map) {
    return MediaModel(
      copyright: map['copyright'] ?? '',
      date: map['date'] ?? '',
      explanation: map['explanation'] ?? '',
      hdurl: map['hdurl'] ?? '',
      mediaType: map['mediaType'] ?? '',
      serviceVersion: map['serviceVersion'] ?? '',
      title: map['title'] ?? '',
      url: map['url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  MediaEntity toMediaEntity() => MediaEntity(date: date, explanation: explanation, hdurl: hdurl, mediaType: mediaType, title: title, url: url);

  factory MediaModel.fromJson(String source) => MediaModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MediaModel(copyright: $copyright, date: $date, explanation: $explanation, hdurl: $hdurl, mediaType: $mediaType, serviceVersion: $serviceVersion, title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MediaModel &&
        other.copyright == copyright &&
        other.date == date &&
        other.explanation == explanation &&
        other.hdurl == hdurl &&
        other.mediaType == mediaType &&
        other.serviceVersion == serviceVersion &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode {
    return copyright.hashCode ^
        date.hashCode ^
        explanation.hashCode ^
        hdurl.hashCode ^
        mediaType.hashCode ^
        serviceVersion.hashCode ^
        title.hashCode ^
        url.hashCode;
  }
}
