import 'package:olxad/model/ad_model.dart';

List<Ad> getCategoryDummyAds(String category) {
  switch (category) {
    case 'Cars':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1549399542-7e3f8b79c341?auto=format&fit=crop&w=500&q=60',
          title: 'Hyundai Creta SX',
          desc:
              '2019 Model, Diesel Automatic, Sunroof.\nWhite color, driven 45,000 km. Maintained well.',
          price: 1150000,
          location: 'Ahmedabad',
          category: 'Cars',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1568772585407-9361f9bf3a87?auto=format&fit=crop&w=500&q=60',
          title: 'Volkswagen Polo GT',
          desc: 'Red Polo GT TSI, 2018 model.\nPetrol automatic, new tires.',
          price: 725000,
          location: 'Delhi',
          category: 'Cars',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1533473359331-0135ef1bcfb0?auto=format&fit=crop&w=500&q=60',
          title: 'Toyota Innova Crysta',
          desc:
              '7 Seater, Captain seats. 2.4Z Diesel.\nFamily used car, excellent condition.',
          price: 1850000,
          location: 'Mumbai',
          category: 'Cars',
        ),
      ];
    case 'Bikes':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?auto=format&fit=crop&w=500&q=60',
          title: 'KTM Duke 390',
          desc:
              '2022 Model, Orange color. Scratchless condition.\nValid insurance, dual channel ABS.',
          price: 240000,
          location: 'Ahmedabad',
          category: 'Bikes',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1558981806-ec527fa84c3d?auto=format&fit=crop&w=500&q=60',
          title: 'Royal Enfield Classic 350',
          desc:
              '2021 Model, Single owner, mint condition.\nDriven only 15,000 kms, regularly serviced.',
          price: 135000,
          location: 'Delhi',
          category: 'Bikes',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1591635566278-10dca0ca76ee?auto=format&fit=crop&w=500&q=60',
          title: 'Honda Activa 6G',
          desc:
              'Matte Grey, 2023 purchase.\nDriven only 4,000 kms. Single owner lady driven.',
          price: 78000,
          location: 'Mumbai',
          category: 'Bikes',
        ),
      ];
    case 'Properties':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1600596542815-ffad4c1539a9?auto=format&fit=crop&w=500&q=60',
          title: '3 BHK Luxury Apartment',
          desc:
              'Fully furnished 3 BHK with pool view.\nIncludes modular kitchen, ACs, and wardrobes.',
          price: 12500000,
          location: 'Navrangpura, Ahmedabad',
          category: 'Properties',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=500&q=60',
          title: '2 BHK Flat for Rent',
          desc:
              'Spacious 2 BHK available for family.\nClose to metro station and schools.',
          price: 25000,
          location: 'Andheri West, Mumbai',
          category: 'Properties',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1583608205776-bfd35f0d9f83?auto=format&fit=crop&w=500&q=60',
          title: 'Independent House',
          desc:
              '4 Bedroom independent villa.\nGated community with security and club house.',
          price: 35000000,
          location: 'Gurgaon, Delhi NCR',
          category: 'Properties',
        ),
      ];
    case 'Electronics & Appliances':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?auto=format&fit=crop&w=500&q=60',
          title: 'MacBook Air M1',
          desc:
              'Space Grey, 8GB RAM, 256GB SSD.\nUnder warranty for 3 more months.',
          price: 55000,
          location: 'Ahmedabad',
          category: 'Electronics & Appliances',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=500&q=60',
          title: 'LG Front Load 7kg',
          desc:
              'Direct Drive motor, Steam wash.\n3 years old, working perfectly.',
          price: 14000,
          location: 'Mumbai',
          category: 'Electronics & Appliances',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1484788984921-03950022c9ef?auto=format&fit=crop&w=500&q=60',
          title: 'LG 27 inch 4K Monitor',
          desc:
              'IPS Display, color calibrated.\nGreat for video editing and gaming.',
          price: 28000,
          location: 'Delhi',
          category: 'Electronics & Appliances',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1581235720704-06d3acfcb36f?auto=format&fit=crop&w=500&q=60',
          title: 'PlayStation 5 Console',
          desc: 'Disc edition, bought last month.\nIncludes 2 controllers.',
          price: 45000,
          location: 'Ahmedabad',
          category: 'Electronics & Appliances',
        ),
      ];
    case 'Mobiles':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1510557880182-3d4d3cba35a5?auto=format&fit=crop&w=500&q=60',
          title: 'iPhone 13 Pro - 256GB',
          desc:
              'Sierra Blue color, 85% battery health.\nComes with original box and cable.',
          price: 68000,
          location: 'Ahmedabad',
          category: 'Mobiles',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1504274066651-8d31a536b300?auto=format&fit=crop&w=500&q=60',
          title: 'Samsung S22 Ultra',
          desc:
              'Burgundy color, 512GB Storage.\nScreen guard installed, no scratches.',
          price: 62000,
          location: 'Mumbai',
          category: 'Mobiles',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1616348436168-de43ad0db179?auto=format&fit=crop&w=500&q=60',
          title: 'iPhone 14 Plus',
          desc:
              'Blue color, 128GB. 10 months warranty left.\nBill box and cable available. Battery 100%.',
          price: 58000,
          location: 'Delhi',
          category: 'Mobiles',
        ),
      ];
    case 'Commercial Vehicles & Spares':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1586191582006-8d827f804555?auto=format&fit=crop&w=500&q=60',
          title: 'Tata Ace Gold',
          desc:
              '2020 Model, purely commercial use.\nAll papers clear, tires 80% new.',
          price: 320000,
          location: 'Sarkhej, Ahmedabad',
          category: 'Commercial Vehicles & Spares',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1600880292089-90a7e086ee3c?auto=format&fit=crop&w=500&q=60',
          title: 'Ashok Leyland Dost',
          desc:
              '2019 Diesel model in good condition.\nSingle owner, ready for immediate sale.',
          price: 450000,
          location: 'Vashi, Mumbai',
          category: 'Commercial Vehicles & Spares',
        ),
      ];
    case 'Jobs':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1486406146926-c627a92ad1ab?auto=format&fit=crop&w=500&q=60',
          title: 'Software Developer Wanted',
          desc:
              'Required Flutter developer with 2+ years experience.\nFull-time remote position.',
          price: 60000,
          location: 'Remote',
          category: 'Jobs',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1522071820081-009f0129c71c?auto=format&fit=crop&w=500&q=60',
          title: 'Marketing Executive',
          desc:
              'Looking for a dynamic person to lead marketing campaigns.\nBase salary + high incentives.',
          price: 35000,
          location: 'Ahmedabad',
          category: 'Jobs',
        ),
      ];
    case 'Furniture':
      return [
        Ad(
          image:
              'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?auto=format&fit=crop&w=500&q=60',
          title: 'Green Velvet Sofa Set',
          desc:
              '3+2 Seater luxury sofa, hardly used.\nReason for selling: Moving abroad.',
          price: 25000,
          location: 'Ahmedabad',
          category: 'Furniture',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1505693314120-0d443867891c?auto=format&fit=crop&w=500&q=60',
          title: 'King Size Bed',
          desc:
              'Solid Teak wood bed with storage.\nMattress not included. 6x6.5 feet.',
          price: 22000,
          location: 'Mumbai',
          category: 'Furniture',
        ),
        Ad(
          image:
              'https://images.unsplash.com/photo-1493723843684-a4368d8b6cd9?auto=format&fit=crop&w=500&q=60',
          title: 'Wooden Dining Table',
          desc: '6 Seater Sheesham wood table.\nIncludes 6 cushioned chairs.',
          price: 18000,
          location: 'Delhi',
          category: 'Furniture',
        ),
      ];
    default:
      return [];
  }
}
