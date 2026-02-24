class Ad {
  final String image;
  final String title;
  final String desc;
  final int price;
  final String location;
  final String? category;

  Ad({
    required this.image,
    required this.title,
    required this.desc,
    required this.price,
    required this.location,
    this.category,
  });

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        image: json['Image'] ?? '',
        title: json['Title'] ?? 'No Title',
        desc: json['description'] ?? 'No Description',
        price: json['price'] is int
            ? json['price']
            : int.tryParse(json['price']?.toString() ?? '0') ?? 0,
        location: json['location'] ?? 'Unknown Location',
        category: json['category'],
      );

  Map<String, dynamic> toJson() => {
        'Image': image,
        'Title': title,
        'description': desc,
        'price': price,
        'location': location,
        if (category != null) 'category': category,
      };
  Map<String, dynamic> toJsonLiked() {
    return {
      'title': title,
      'price': price,
      'location': location,
      'image': image, // or 'image': image if it's a string
      'desc': desc,
      if (category != null) 'category': category,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ad &&
        other.image == image &&
        other.title == title &&
        other.desc == desc &&
        other.price == price &&
        other.location == location &&
        other.category == category;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        title.hashCode ^
        desc.hashCode ^
        price.hashCode ^
        location.hashCode ^
        category.hashCode;
  }
}

List<Ad> getDummyAds() {
  return [
    Ad(
      image:
          'https://images.unsplash.com/photo-1558981806-ec527fa84c3d?auto=format&fit=crop&w=500&q=60', // Royal Enfield style
      title: 'Royal Enfield Classic 350',
      desc:
          '2021 Model, Single owner, mint condition.\nDriven only 15,000 kms, regularly serviced.',
      price: 135000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=500&q=60', // Sofa
      title: 'Green Velvet Sofa Set',
      desc:
          '3+2 Seater luxury sofa, hardly used.\nReason for selling: Moving abroad.',
      price: 25000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?auto=format&fit=crop&w=500&q=60', // iPhone
      title: 'iPhone 13 Pro - 256GB',
      desc:
          'Sierra Blue color, 85% battery health.\nComes with original box and cable.',
      price: 68000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=500&q=60', // Laptop
      title: 'MacBook Air M1',
      desc:
          'Space Grey, 8GB RAM, 256GB SSD.\nUnder warranty for 3 more months.',
      price: 55000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?auto=format&fit=crop&w=500&q=60', // Camera
      title: 'Canon DSLR 1500D',
      desc:
          'Includes 18-55mm and 55-250mm lens.\nPerfect for beginners, includes bag and memory card.',
      price: 32000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1581235720704-06d3acfcb36f?auto=format&fit=crop&w=500&q=60', // PS5 controller/gaming
      title: 'PlayStation 5 Console',
      desc:
          'Disc edition, bought last month.\nIncludes 2 controllers and FIFA 24.',
      price: 45000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=500&q=60', // Nike Shoes
      title: 'Nike Air Max Red',
      desc: 'Size UK 9, worn only twice.\nOriginal bill available.',
      price: 8500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=500&q=60', // Headphones
      title: 'Sony WH-1000XM4',
      desc:
          'Noise cancelling headphones, black color.\nExcellent condition with travel case.',
      price: 18000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=500&q=60', // Watch
      title: 'Smart Watch Series 7',
      desc:
          'GPS + Cellular model, 45mm.\nMidnight aluminum case with sport band.',
      price: 22000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1585386959984-a4155224a1ad?auto=format&fit=crop&w=500&q=60', // Pot/Decor
      title: 'Antique Flower Vase',
      desc:
          'Ceramic handcrafted vase for living room.\nHeight 2 feet, perfect for corner piece.',
      price: 3500,
      location: 'Ahmedabad',
    ),

    // --- MUMBAI ADS (10 Items) ---
    Ad(
      image:
          'https://images.unsplash.com/photo-1532298229144-0ec0c57515c7?auto=format&fit=crop&w=500&q=60', // Accordion/Music
      title: 'Yamaha Acoustic Guitar',
      desc: 'F310 model, rosewood fretboard.\nComes with tuner, picks and bag.',
      price: 7500,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1593642702821-c8da6771f0c6?auto=format&fit=crop&w=500&q=60', // Dell Laptop
      title: 'Dell XPS 13 Laptop',
      desc:
          'Core i7 11th Gen, Touch screen 4K.\nIdeal for coding and graphic design.',
      price: 85000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1598327777177-3511980632b5?auto=format&fit=crop&w=500&q=60', // Designer Chair
      title: 'Office Ergonomic Chair',
      desc:
          'Herman Miller style, fully adjustable.\nMesh back support, barely used.',
      price: 12000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1560343090-f0409e92791a?auto=format&fit=crop&w=500&q=60', // Leather Shoes
      title: 'Formal Leather Shoes',
      desc: 'Tan brown, pure leather, Size 8.\nWorn once for a wedding.',
      price: 4500,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1504274066651-8d31a536b300?auto=format&fit=crop&w=500&q=60', // Phone
      title: 'Samsung S22 Ultra',
      desc:
          'Burgundy color, 512GB Storage.\nScreen guard installed, no scratches.',
      price: 62000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1484788984921-03950022c9ef?auto=format&fit=crop&w=500&q=60', // Monitor
      title: 'LG 27 inch 4K Monitor',
      desc:
          'IPS Display, color calibrated.\nGreat for video editing and gaming.',
      price: 28000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?auto=format&fit=crop&w=500&q=60', // Car
      title: 'Honda City i-VTEC',
      desc:
          '2019 Model, ZX Variant, Sunroof.\nWhite color, insurance paid till 2026.',
      price: 850000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1526170375885-4d8ecf77b99f?auto=format&fit=crop&w=500&q=60', // Camera Lens
      title: 'Sony 50mm Prime Lens',
      desc:
          'F1.8 aperture, E-mount for Alpha series.\nRazor sharp images, box available.',
      price: 15000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1517336714731-489689fd1ca4?auto=format&fit=crop&w=500&q=60', // Macbook
      title: 'MacBook Pro 16 inch',
      desc:
          'Intel i9, 32GB RAM, 1TB SSD.\nPowerhouse machine for heavy editing.',
      price: 110000,
      location: 'Mumbai',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1559563458-527698bf527e?auto=format&fit=crop&w=500&q=60', // Handbag
      title: 'Designer Handbag',
      desc: 'Genuine leather, beige color.\nReceived as gift, never used.',
      price: 8000,
      location: 'Mumbai',
    ),

    // --- DELHI ADS (10 Items) ---
    Ad(
      image:
          'https://images.unsplash.com/photo-1502877338535-766e1452684a?auto=format&fit=crop&w=500&q=60', // Car Interior/Car
      title: 'Maruti Swift ZXi+',
      desc:
          '2020 Model, Red Color, Manual.\nTop model with alloy wheels and touch screen.',
      price: 520000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1546868871-7041f2a55e12?auto=format&fit=crop&w=500&q=60', // Smart Watch
      title: 'Apple Watch Ultra',
      desc:
          'Rugged titanium case, orange alpine loop.\nBattery life 2 days, adventure ready.',
      price: 72000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1544441893-675973e31985?auto=format&fit=crop&w=500&q=60', // Jacket/Clothing
      title: 'Winter Leather Jacket',
      desc:
          'Pure leather biker jacket, Black.\nSize L, bought from Zara last winter.',
      price: 4500,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1550009158-9ebf69173e03?auto=format&fit=crop&w=500&q=60', // Electronics
      title: 'iPad Air 5th Gen',
      desc: 'M1 Chip, 64GB, Purple color.\nWith Apple Pencil 2nd Generation.',
      price: 48000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1493723843684-a4368d8b6cd9?auto=format&fit=crop&w=500&q=60', // Table/Furniture
      title: 'Wooden Dining Table',
      desc: '6 Seater Sheesham wood table.\nIncludes 6 cushioned chairs.',
      price: 18000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1584735935682-2f2b69dff9d2?auto=format&fit=crop&w=500&q=60', // Controller
      title: 'Xbox Series X',
      desc:
          '1TB Console, immaculate condition.\nIncludes GamePass ultimate for 2 months.',
      price: 42000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1481207860058-63213d274c5b?auto=format&fit=crop&w=500&q=60', // Camera
      title: 'GoPro Hero 10',
      desc:
          'Action camera with waterproof housing.\nIncludes 2 extra batteries and floaty.',
      price: 26000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1618424181497-157f25b6ddd5?auto=format&fit=crop&w=500&q=60', // Kitchen Mixer
      title: 'Kitchen Aid Mixer',
      desc:
          'Heavy duty stand mixer, red color.\nBest for baking cakes and dough.',
      price: 22000,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1629198688000-71f23e745b6e?auto=format&fit=crop&w=500&q=60', // Study Table
      title: 'Study Desk White',
      desc: 'Engineered wood, ample storage drawers.\nClean modern look.',
      price: 6500,
      location: 'Delhi',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1551107696-a4b0c5a0d9a2?auto=format&fit=crop&w=500&q=60', // Shoes
      title: 'Adidas Ultraboost',
      desc: 'Running shoes, very comfortable.\nWhite color, Size UK 10.',
      price: 9000,
      location: 'Delhi',
    ),
  ];
}

List<Ad> getAhmedabadAds() {
  return [
    // --- VEHICLES ---
    Ad(
      image:
          'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=500&q=60', // Hyundai Car
      title: 'Hyundai Creta SX',
      desc:
          '2019 Model, Diesel Automatic, Sunroof.\nWhite color, driven 45,000 km. Maintained at authorized service center.',
      price: 1150000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=500&q=60', // Sporty Car
      title: 'Volkswagen Polo GT',
      desc:
          'Red Polo GT TSI, 2018 model.\nPetrol automatic, new tires, stage 1 tuned. Fun to drive!',
      price: 725000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=500&q=60', // Bike
      title: 'KTM Duke 390',
      desc:
          '2022 Model, Orange color. Scratchless condition.\nValid insurance, dual channel ABS.',
      price: 240000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1591635566278-10dca0ca76ee?auto=format&fit=crop&w=500&q=60', // Scooter
      title: 'Honda Activa 6G',
      desc:
          'Matte Grey, 2023 purchase.\nDriven only 4,000 kms. Single owner lady driven.',
      price: 78000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1533473359331-0135ef1bcfb0?auto=format&fit=crop&w=500&q=60', // Car
      title: 'Toyota Innova Crysta',
      desc:
          '7 Seater, Captain seats. 2.4Z Diesel.\nFamily used car, excellent engine condition.',
      price: 1850000,
      location: 'Ahmedabad',
    ),

    // --- ELECTRONICS ---
    Ad(
      image:
          'https://images.unsplash.com/photo-1616348436168-de43ad0db179?auto=format&fit=crop&w=500&q=60', // iPhone
      title: 'iPhone 14 Plus',
      desc:
          'Blue color, 128GB. 10 months warranty left.\nBill box and cable available. Battery 100%.',
      price: 58000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1593305841991-05c29736ce07?auto=format&fit=crop&w=500&q=60', // Gaming Mouse
      title: 'Logitech G502 Mouse',
      desc:
          'Hero Gaming mouse, RGB light.\nHigh precision sensor, barely used for gaming.',
      price: 3500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1588872657578-138a6c71097d?auto=format&fit=crop&w=500&q=60', // Laptop
      title: 'HP Pavilion Gaming',
      desc:
          'Ryzen 5, GTX 1650 Graphics, 16GB RAM.\nGreat for editing and heavy work.',
      price: 42000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1546435770-a3e426bf472b?auto=format&fit=crop&w=500&q=60', // Headphones
      title: 'Bose QC 45',
      desc:
          'Noise cancelling premium headphones.\nBlack color, imported from USA. Amazing sound.',
      price: 19500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?auto=format&fit=crop&w=500&q=60', // Monitor
      title: 'BenQ 24 Inch Monitor',
      desc:
          '1080p Full HD, Eye care technology.\nStand included, HDMI cable free.',
      price: 8500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1564466021-91487002cde3?auto=format&fit=crop&w=500&q=60', // Speaker
      title: 'JBL Flip 6 Speaker',
      desc: 'Waterproof bluetooth speaker.\nRed color, loud bass. Box packed.',
      price: 7000,
      location: 'Ahmedabad',
    ),

    // --- FURNITURE & HOME ---
    Ad(
      image:
          'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=500&q=60', // Bed
      title: 'King Size Bed',
      desc:
          'Solid Teak wood bed with storage.\nMattress not included. 6x6.5 feet.',
      price: 22000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=500&q=60', // Chair
      title: 'Modern Accent Chair',
      desc:
          'Yellow velvet fabric, gold legs.\nStatement piece for living room.',
      price: 6500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=500&q=60', // Washing Machine
      title: 'LG Front Load 7kg',
      desc:
          'Direct Drive motor, Steam wash.\n3 years old, working perfectly. Selling due to transfer.',
      price: 14000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1556906781-9a412961d28c?auto=format&fit=crop&w=500&q=60', // Shoes
      title: 'Nike Jordan High',
      desc:
          'Air Jordan 1 Chicago colorway.\nFirst copy premium quality. Size UK 9.',
      price: 2500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1581539250439-c96689b516dd?auto=format&fit=crop&w=500&q=60', // Glass Table
      title: 'Glass Coffee Table',
      desc: 'Tempered glass top, wooden base.\nModern design, scratch free.',
      price: 4500,
      location: 'Ahmedabad',
    ),

    // --- MISC ---
    Ad(
      image:
          'https://images.unsplash.com/photo-1627384113743-6bd5a479fffd?auto=format&fit=crop&w=500&q=60', // Perfume
      title: 'Dior Sauvage Elixir',
      desc:
          'Unwanted gift, 95% full bottle.\nOriginal packaging available. Strong projection.',
      price: 9000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1571781926291-28b46a85e8b5?auto=format&fit=crop&w=500&q=60', // Dumbbells
      title: 'Adjustable Dumbbells',
      desc:
          'Set of 2, adjustable weight 2kg to 10kg.\nRubber coated, good grip.',
      price: 3000,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1503602642458-23211144584b?auto=format&fit=crop&w=500&q=60', // Camera Lens
      title: 'Nikon 35mm Lens',
      desc: 'F1.8 G Prime lens for Nikon DSLR.\nSharp portrait photography.',
      price: 9500,
      location: 'Ahmedabad',
    ),
    Ad(
      image:
          'https://images.unsplash.com/photo-1543512214-318c77a799bf?auto=format&fit=crop&w=500&q=60', // Yoga Mat
      title: 'Premium Yoga Mat',
      desc:
          'Extra thick 6mm mat, non-slip texture.\nPurple color, with carrying strap.',
      price: 800,
      location: 'Ahmedabad',
    ),
  ];
}
