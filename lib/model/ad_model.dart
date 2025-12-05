class Ad {
  final String image;
  final String title;
  final String desc;
  final int price;
  final String location;

  Ad({
    required this.image,
    required this.title,
    required this.desc,
    required this.price,
    required this.location,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        image: json['Image'] ?? '',
        title: json['Title'] ?? 'No Title',
        desc: json['description'] ?? 'No Description',
        price: json['price'] is int
            ? json['price']
            : int.tryParse(json['price']?.toString() ?? '0') ?? 0,
        location: json['location'] ?? 'Unknown Location',
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': desc,
        'price': price,
        'location': location,
      };
}
