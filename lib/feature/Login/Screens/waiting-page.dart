import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/common/global variables.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.04),

                _buildHeader(width),

                SizedBox(height: height * 0.06),

                // Circular logo
                _buildLogo(width),

                SizedBox(height: height * 0.03),

                // Welcome text
                _buildWelcomeText(width),

                SizedBox(height: height * 0.05),

                // Tutorials section
                _buildTutorialsSection(width, height),

                SizedBox(height: height * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Anjali K',
          style: GoogleFonts.roboto(
            fontSize: width * 0.045,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        Container(
          width: width * 0.08,
          height: width * 0.08,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey.shade400,
          ),
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: width * 0.05,
          ),
        ),
      ],
    );
  }

  Widget _buildLogo(double width) {
    return SizedBox(
      width: width * 0.25,
      height: width * 0.25,
      child: SvgPicture.asset('assets/svg/refrrRoundLogo.svg'),
    );
  }

  Widget _buildWelcomeText(double width) {
    return Column(
      children: [
        Text(
          'Welcome to Refrr !!!',
          style: GoogleFonts.roboto(
            fontSize: width * 0.055,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: width * 0.03),
        Text(
          'We are verifying your account.',
          style: GoogleFonts.roboto(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w400,
            color:  Color(0xFF5D5D5D),
          ),
        ),
        Text(
          'Expect a call from our team shortly...',
          style: GoogleFonts.roboto(
            fontSize: width * 0.035,
            fontWeight: FontWeight.w400,
            color:  Color(0xFF5D5D5D),
          ),
        ),
      ],
    );
  }

  Widget _buildTutorialsSection(double width, double height) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:  EdgeInsets.only(left: width*.23),
          child: Row(
            children: [
              Text(
                'Tutorials ',
                style: GoogleFonts.roboto(
                  fontSize: width * 0.045,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF393939),
                ),
              ),
              Text(
                '(How it works)',
                style: GoogleFonts.roboto(
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF393939),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: height * 0.01),

        // Tutorial cards
        _buildTutorialCard(
          width,
          height,
          'Get Started',
          'Build your profile and start referring',
        ),
        SizedBox(height: height * 0.02),
        _buildTutorialCard(
          width,
          height,
          'Build your network',
          'Connect with professionals and expand',
        ),
      ],
    );
  }

  Widget _buildTutorialCard(double width, double height, String title, String subtitle) {
    return Container(
      width: double.infinity,
      height: height * 0.2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.lightBlue.shade100,
            Colors.lightBlue.shade200,
          ],
        ),
        borderRadius: BorderRadius.circular(width * 0.04),

      ),
      child: Stack(
        children: [
          // Phone mockup illustration
          Positioned(
            right: width * 0.05,
            top: height * 0.02,
            child: Container(
              width: width * 0.25,
              height: height * 0.15,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(width * 0.03),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Phone header
                  Container(
                    width: double.infinity,
                    height: height * 0.03,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E5E5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width * 0.03),
                        topRight: Radius.circular(width * 0.03),
                      ),
                    ),
                  ),
                  // Phone content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: double.infinity,
                            height: height * 0.015,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(width * 0.01),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Container(
                            width: width * 0.12,
                            height: height * 0.02,
                            decoration: BoxDecoration(
                              color: const Color(0xFF00E5E5),
                              borderRadius: BorderRadius.circular(width * 0.01),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Text content
          Positioned(
            left: width * 0.05,
            bottom: height * 0.03,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: height * 0.005),
                SizedBox(
                  width: width * 0.5,
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: width * 0.032,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}