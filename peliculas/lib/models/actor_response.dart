import 'dart:convert';

class ActorResponse {
    bool adult;
    List<String>? alsoKnownAs;
    String biography;
    DateTime birthday;
    dynamic deathday;
    int gender;
    dynamic homepage;
    int id;
    String imdbId;
    String knownForDepartment;
    String name;
    String? placeOfBirth;
    double popularity;
    String? profilePath;

    ActorResponse({
        required this.adult,
        this.alsoKnownAs,
        required this.biography,
        required this.birthday,
        this.deathday,
        required this.gender,
        this.homepage,
        required this.id,
        required this.imdbId,
        required this.knownForDepartment,
        required this.name,
        this.placeOfBirth,
        required this.popularity,
        this.profilePath,
    });

    // Método para obtener la URL del perfil
  String get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    } else {
      return 'https://i.stack.imgur.com/GNhxO.png'; // Imagen de respaldo
    }
  }

    factory ActorResponse.fromJson(String str) => ActorResponse.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ActorResponse.fromMap(Map<String, dynamic> json) => ActorResponse(
        adult: json["adult"],
        alsoKnownAs: List<String>.from(json["also_known_as"].map((x) => x)),
        biography: json["biography"],
        birthday: DateTime.parse(json["birthday"]),
        deathday: json["deathday"],
        gender: json["gender"],
        homepage: json["homepage"],
        id: json["id"],
        imdbId: json["imdb_id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        placeOfBirth: json["place_of_birth"],
        popularity: json["popularity"]?.toDouble(),
        profilePath: json["profile_path"],
    );

    Map<String, dynamic> toMap() => {
        "adult": adult,
        "also_known_as": List<dynamic>.from(alsoKnownAs!.map((x) => x)),
        "biography": biography,
        "birthday": "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "deathday": deathday,
        "gender": gender,
        "homepage": homepage,
        "id": id,
        "imdb_id": imdbId,
        "known_for_department": knownForDepartment,
        "name": name,
        "place_of_birth": placeOfBirth,
        "popularity": popularity,
        "profile_path": profilePath,
    };
}
