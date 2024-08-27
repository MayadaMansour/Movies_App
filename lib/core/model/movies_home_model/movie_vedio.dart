class MovieTrailer {
  MovieTrailer({
    this.id,
    this.trailers,
  });

  MovieTrailer.fromJson(dynamic json) {
    id = json['id'];
    if (json['results'] != null) {
      trailers = [];
      json['results'].forEach((v) {
        trailers?.add(Trailer.fromJson(v));
      });
    }
  }

  num? id;
  List<Trailer>? trailers;

  MovieTrailer copyWith({
    num? id,
    List<Trailer>? trailers,
  }) =>
      MovieTrailer(
        id: id ?? this.id,
        trailers: trailers ?? this.trailers,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (trailers != null) {
      map['results'] = trailers?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Trailer {
  Trailer({
    this.iso6391,
    this.iso31661,
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  Trailer.fromJson(dynamic json) {
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    key = json['key'];
    site = json['site'];
    size = json['size'];
    type = json['type'];
    official = json['official'];
    publishedAt = json['published_at'];
    id = json['id'];
  }

  String? iso6391;
  String? iso31661;
  String? name;
  String? key;
  String? site;
  num? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Trailer copyWith({
    String? iso6391,
    String? iso31661,
    String? name,
    String? key,
    String? site,
    num? size,
    String? type,
    bool? official,
    String? publishedAt,
    String? id,
  }) =>
      Trailer(
        iso6391: iso6391 ?? this.iso6391,
        iso31661: iso31661 ?? this.iso31661,
        name: name ?? this.name,
        key: key ?? this.key,
        site: site ?? this.site,
        size: size ?? this.size,
        type: type ?? this.type,
        official: official ?? this.official,
        publishedAt: publishedAt ?? this.publishedAt,
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['iso_639_1'] = iso6391;
    map['iso_3166_1'] = iso31661;
    map['name'] = name;
    map['key'] = key;
    map['site'] = site;
    map['size'] = size;
    map['type'] = type;
    map['official'] = official;
    map['published_at'] = publishedAt;
    map['id'] = id;
    return map;
  }
}
