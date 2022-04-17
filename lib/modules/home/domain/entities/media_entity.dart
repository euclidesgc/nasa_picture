class MediaEntity {
  final String date;
  final String explanation;
  final String hdurl;
  final String mediaType;
  final String title;
  final String url;

  MediaEntity({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.title,
    required this.url,
  });

  MediaEntity.empty({
    this.date = '',
    this.explanation = '',
    this.hdurl = '',
    this.mediaType = '',
    this.title = '',
    this.url = '',
  });

  MediaEntity copyWith({
    String? date,
    String? explanation,
    String? hdurl,
    String? mediaType,
    String? title,
    String? url,
  }) {
    return MediaEntity(
      date: date ?? this.date,
      explanation: explanation ?? this.explanation,
      hdurl: hdurl ?? this.hdurl,
      mediaType: mediaType ?? this.mediaType,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  @override
  String toString() {
    return 'MediaEntity(date: $date, explanation: $explanation, hdurl: $hdurl, mediaType: $mediaType, title: $title, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MediaEntity &&
        other.date == date &&
        other.explanation == explanation &&
        other.hdurl == hdurl &&
        other.mediaType == mediaType &&
        other.title == title &&
        other.url == url;
  }

  @override
  int get hashCode {
    return date.hashCode ^ explanation.hashCode ^ hdurl.hashCode ^ mediaType.hashCode ^ title.hashCode ^ url.hashCode;
  }
}
