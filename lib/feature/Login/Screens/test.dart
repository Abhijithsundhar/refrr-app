// Create a simple test widget to verify SVG loading works
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SVGTestWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SVG Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Test 1: Try loading your SVG
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(border: Border.all()),
              child: SvgPicture.asset(
                'assets/images/svgone.svg',
                errorBuilder: (context, error, stackTrace) {
                  print('SVG Error: $error');
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
            ),
            SizedBox(height: 20),

            // Test 2: Try with network SVG (to test if flutter_svg works)
            Container(
              width: 100,
              height: 100,
              child: SvgPicture.network(
                'https://www.svgrepo.com/show/13656/star.svg',
                errorBuilder: (context, error, stackTrace) {
                  print('Network SVG Error: $error');
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
            ),

            Text('If you see a star above, flutter_svg works'),
            Text('If you see error icon, check your SVG files'),
          ],
        ),
      ),
    );
  }
}