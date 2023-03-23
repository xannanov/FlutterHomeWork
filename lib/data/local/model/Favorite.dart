import 'dart:convert';

Favorite clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Favorite.fromMap(jsonData);
}

String clientToJson(Favorite data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Favorite {
  int id = 0;
  String word;

  Favorite.word(this.word);
  Favorite.idWord(this.id, this.word);
  
  factory Favorite.fromMap(Map<String, dynamic> json) =>
      Favorite.idWord(json['id'], json['word']);

  Map<String, dynamic> toMap() => {
    'id': id,
    'word': word,
  };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Favorite && other.word == word && other.id == id;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => id.hashCode ^ word.hashCode;

}