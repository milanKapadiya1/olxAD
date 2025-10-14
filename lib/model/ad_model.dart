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
        title: json['Title'] ,
        desc: json['description'],
        price: json['price'],
        location: json['location'],
        // image: json['image'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': desc,
        'price': price,
        'location': location,
      };
}

