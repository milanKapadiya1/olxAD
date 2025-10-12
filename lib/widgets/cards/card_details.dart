class CardDetails {
  final String image;
  final String text;

  const CardDetails({
    required this.image,
    required this.text,
  });
}

final List<CardDetails> cardDetails1 = [
  const CardDetails(image: 'car.png', text: 'Car'),
  const CardDetails(image: 'house.png', text: 'Properties'),
  const CardDetails(image: 'job.png', text: 'Jobs'),
  const CardDetails(image: 'mobile.png', text: 'Mobile'),
  const CardDetails(image: 'job.png', text: 'Jobs'),
  const CardDetails(image: 'bike.png', text: 'Bike'),
];
  final List<CardDetails> cardDetails2 = [
  const CardDetails(image: 'bike.png', text: 'Bike'),
  const CardDetails(image: 'fashion.png', text: 'Fashion'),
  const CardDetails(image: 'furniture.jpg', text: 'Furniture'),
  const CardDetails(image: 'house.png', text: 'House'),
  const CardDetails(image: 'job.png', text: 'Jobs'),

  //  const CardDetails(image: 'Car.png', text: 'car'),
];
