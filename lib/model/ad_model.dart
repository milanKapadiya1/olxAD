class Ad {
  final String image;
  final String title;
  final String desc;

  Ad({
    required this.image,
    required this.title,
    required this.desc,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        image: json['Image'] ?? '',
        title: json['Title'] ,
        desc: json['description'],
        // image: json['image'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': desc,
      };
}
