import 'dart:io';
import 'package:image/image.dart' as img;

void main() {
  var newImage = img.Image(
      width: 10, height: 10, numChannels: 4); // fully transparent by default
  File('assets/images/transparent.png')
      .writeAsBytesSync(img.encodePng(newImage));
  print('Valid Transparent image created!');
}
