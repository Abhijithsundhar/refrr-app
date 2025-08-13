// import 'package:flutter/material.dart' hide CarouselController; // 👈 hide the unwanted one
// import 'package:carousel_slider/carousel_controller.dart' as cs;
// import 'package:carousel_slider/carousel_slider.dart';
//
// class CarouselHomePage extends StatefulWidget {
//   final int initialPage;
//   const CarouselHomePage({super.key, this.initialPage = 0});
//
//   @override
//   State<CarouselHomePage> createState() => _CarouselHomePageState();
// }
//
// class _CarouselHomePageState extends State<CarouselHomePage> {
//   final CarouselController _controller = CarouselController();
//   int _currentIndex = 0;
//
//   final List<String> images = [
//     'https://via.placeholder.com/400x200',
//     'https://via.placeholder.com/400x200/ff4444',
//     'https://via.placeholder.com/400x200/44ff44',
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     _currentIndex = widget.initialPage;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Scrollable content
//           SingleChildScrollView(
//             child: Column(
//               children: [
//                 const SizedBox(height: 40),
//
//                 // Carousel
//                 CarouselSlider.builder(
//                   itemCount: images.length,
//                   itemBuilder: (context, index, realIdx) {
//                     return Container(
//                       width: size.width,
//                       margin: const EdgeInsets.symmetric(horizontal: 8),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         image: DecorationImage(
//                           image: NetworkImage(images[index]),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     );
//                   },
//                   options: CarouselOptions(
//                     initialPage: widget.initialPage,
//                     height: size.height * 0.25,
//                     enlargeCenterPage: true,
//                     onPageChanged: (index, reason) {
//                       setState(() {
//                         _currentIndex = index;
//                       });
//                     },
//                   ),
//                   carouselController: _controller,
//                 ),
//
//                 // Carousel dots
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: images.asMap().entries.map((entry) {
//                     return GestureDetector(
//                       onTap: () => _controller.animateToPage(entry.key),
//                       child: Container(
//                         width: 12.0,
//                         height: 12.0,
//                         margin:
//                         const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: _currentIndex == entry.key
//                               ? Colors.blueAccent
//                               : Colors.grey,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//
//                 const SizedBox(height: 200), // Just to push up the curved container
//               ],
//             ),
//           ),
//
//           // Curved Container at Bottom
//           Positioned(
//             bottom: 0,
//             child: ClipPath(
//               clipper: CurvedClipper(),
//               child: Container(
//                 height: size.height * 0.4,
//                 width: size.width,
//                 color: Colors.blueAccent,
//                 child: const Center(
//                   child: Text(
//                     'Curved Bottom Container',
//                     style: TextStyle(color: Colors.white, fontSize: 20),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class CurvedClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(0, size.height - 60);
//     path.quadraticBezierTo(
//         size.width / 2, size.height, size.width, size.height - 60);
//     path.lineTo(size.width, 0);
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
