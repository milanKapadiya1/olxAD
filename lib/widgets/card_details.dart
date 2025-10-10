class CardDetails {
  final String image;
  final String text;

  const CardDetails({
    required this.image,
    required this.text,
  });
}

final List<CardDetails> cardDetails = [
  const CardDetails(image: 'car.png', text: 'Car'),
  const CardDetails(image: 'house.png', text: 'House'),
  const CardDetails(image: 'job.png', text: 'Jobs'),
  const CardDetails(image: 'mobile.png', text: 'Mobile'),
  const CardDetails(image: 'house.png', text: 'House'),
  const CardDetails(image: 'job.png', text: 'Jobs'),

  //  const CardDetails(image: 'Car.png', text: 'car'),
];
