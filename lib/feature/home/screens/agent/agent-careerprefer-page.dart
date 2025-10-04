import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/global variables.dart';

class CareerPreferancePage extends StatelessWidget {
  const CareerPreferancePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(width * .04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * .02),
            _buildInfoItem('I am an...', 'Job Employee', width, height),
            _buildInfoItem('Preferred Industries', '1. Health\n2. Education\n3. Food\n4. Accounting', width, height),
            _buildInfoItem('Preferred Work Location', 'UAE', width, height),
            _buildInfoItem('Desired Job Type', 'Full Time', width, height),
            SizedBox(height: height * .05),
          ],
        ),
      ),
    );
  }

  /// helper widget for info row
  Widget _buildInfoItem(String label, String value, double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: width * .03,
            fontWeight: FontWeight.w400,
            color:Color(0xFF888888),
          ),
        ),
        SizedBox(height: height * .025),
        Padding(
          padding:  EdgeInsets.only(left: width*.02),
          child: Text(
            value,
            style: GoogleFonts.roboto(
              fontSize: width * .042,
              fontWeight: FontWeight.w400,
              color: Color(0xFF111111),
            ),
          ),
        ),
        Divider(color: Colors.grey.shade300, thickness: 1),
        SizedBox(height: height * .02),
      ],
    );
  }
}
