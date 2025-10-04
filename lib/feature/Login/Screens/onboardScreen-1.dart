import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/common/global variables.dart';
import 'login-page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();

  final List<OnboardContent> pages = [
    OnboardContent(
      title: 'Trusted Brands,',
      subtitle1: 'Real Rewards',
      subtitle2: 'Partner with businesses that value your',
      subtitle3: 'network.',
      imagePath: 'assets/svg/SPLASH SCREEN_presentation-02.svg',
    ),
    OnboardContent(
      title: 'Earn From You',
      subtitle1: 'Network',
      subtitle2: 'Turn your personal and professional',
      subtitle3: 'connection in to a steady income stream.',
      imagePath: 'assets/svg/test1.svg',),
    OnboardContent(
      title: 'Track Your Earnings',
      subtitle1: 'in Real-Time',
      subtitle2: 'Stay updated with transparent tracking for',
      subtitle3: 'every referral and commission',
      imagePath: 'assets/svg/SPLASH SCREEN_presentation-04.svg',
    ),
    OnboardContent(
      title: 'Get Paid for Every',
      subtitle1: 'Deal Closed',
      subtitle2: 'Secure, guaranteed commission for',
      subtitle3: 'every success you create',
      imagePath: 'assets/svg/SPLASH SCREEN_presentation-03.svg',
    ),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // fallback
      body: Container(
        // Gradient background like the screenshot
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF74EAF3),
              Colors.white,
            ],
            stops: [0.2, 0.75],
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                // Onboarding Screens with stacked dots
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      PageView.builder(
                        controller: _controller,
                        itemCount: pages.length,
                        onPageChanged: (index) {
                          setState(() => currentPage = index);
                        },
                        itemBuilder: (_, index) => OnboardScreen(content: pages[index]),),
                      Positioned(
                        bottom: height * 0.12,
                        child: SmoothPageIndicator(
                          controller: _controller,
                          count: pages.length,
                          effect: CustomizableEffect(
                            activeDotDecoration: DotDecoration(
                              width: 20,
                              height: 10,
                              color: const Color.fromRGBO(189, 189, 189, 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            dotDecoration: DotDecoration(
                              width: 10,
                              height: 10,
                              color: const Color.fromRGBO(217, 217, 217, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            spacing: 8.0,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                // Next Button
                Padding(
                  padding: EdgeInsets.only(left: width * .02),
                  child: GestureDetector(
                    onTap: () {
                      if (currentPage == pages.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    child: Container(
                      width: width * .9,
                      height: height * .07,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(
                          color: Colors.black,
                          width: width * .004,
                        ),
                        borderRadius: BorderRadius.circular(width * .03),
                      ),
                      child: Center(
                        child: Text(
                          'Next',
                          style: GoogleFonts.roboto(
                            fontSize: width * .034,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * .04),
              ],
            ),

            // Skip Button Positioned Top-Right
            Positioned(
              top: height * 0.03,
              right: width * 0.05,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage(),),);
                },
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.0), // transparent to show gradient
                    borderRadius: BorderRadius.circular(width * .01),
                  ),
                  child: Text(
                    'Skip',
                    style: GoogleFonts.roboto(
                      fontSize: width * .04,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardContent {
  final String title;
  final String subtitle1;
  final String subtitle2;
  final String subtitle3;
  final String imagePath;

  OnboardContent({
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle3,
    required this.imagePath,
  });
}

class OnboardScreen extends StatelessWidget {
  final OnboardContent content;

  const OnboardScreen({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // avoids overflow on small screens
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: height * .15), // Top spacing

            // Heading
            Text(
              content.title,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width * .08,

              ),
            ),

            // Subtitles
            Text(
              content.subtitle1,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: width * .08,
                height: 1.0, // 👈
              ),
            ),
            SizedBox(height: height * .015),
            Text(
              content.subtitle2,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: width * .045,
              ),
            ),
            Text(
              content.subtitle3,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                color: Colors.black,
                fontWeight: FontWeight.w300,
                fontSize: width * .045,
              ),
            ),

            SizedBox(height: height * .02),

            // Image
            // Replace your current SvgPicture.asset with this:
            Container(
              height: height * .45,
              width: double.infinity,
              child: SvgPicture.asset(
                content.imagePath,
                fit: BoxFit.contain,
                placeholderBuilder: (context) => Container(
                  height: height * .45,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Loading image...'),
                      ],
                    ),
                  ),
                ),
                // Add error handling
                errorBuilder: (context, error, stackTrace) => Container(
                  height: height * .45,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.red, size: 50),
                        SizedBox(height: 10),
                        Text(
                          'Image not found:\n${content.imagePath}',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}