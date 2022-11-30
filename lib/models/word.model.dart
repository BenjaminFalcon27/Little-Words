class Word {
  final int? uid;
  final String author;
  final String content;
  final String latitude;
  final String longitude;

  const Word({
    required this.uid,
    required this.author,
    required this.content,
    required this.latitude,
    required this.longitude,
  });

  factory Word.fromJson(Map<String, dynamic> json) => Word(
        uid: json['uid'],
        author: json['author'],
        content: json['content'],
        latitude: json['latitude'],
        longitude: json['longitude'],
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'author': author,
        'content': content,
        'longitude': longitude,
        'latitude': latitude
      };
}
