import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icanyon/model/affiliate-model.dart';

///screen size
double width = 0;
double height = 0;

final affiliateProvider = StateProvider<AffiliateModel?>((ref) {
  return null;
});

final List<String> imageList = [
  'assets/images/image.png',
  'assets/images/image (1).png',
  'assets/images/image (2).png',
  'assets/images/image (3).png',
  'assets/images/image (2).png',
  'assets/images/image.png',
];final List<String> shareImageList = [
  'assets/images/share1.png',
  'assets/images/share2.png',
  'assets/images/share3.png',
];

final List<String> nameList = [
  'Abhijith Sundhar',
  'Kavya Pj',
  'Anjali Krishna',
  'Santhini Vc',
  'Vishnu Suresh',
  'Jamshid',
];
