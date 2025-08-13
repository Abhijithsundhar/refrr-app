// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:icanyon/core/common/global%20variables.dart';
// import 'package:icanyon/core/constants/color-constnats.dart';
// import 'package:icanyon/feature/home/screens/addfirm.dart';
// import 'package:icanyon/feature/home/screens/viewPage.dart';
// import 'package:icanyon/feature/profile/profile.dart';
//
// class Homescreen extends StatefulWidget {
//   const Homescreen({super.key});
//
//   @override
//   State<Homescreen> createState() => _HomescreenState();
// }
//
// class _HomescreenState extends State<Homescreen> {
//   final List<String> updateImages = [
//     'assets/images/creditUpdate.png',
//     'assets/images/withdrewUpdate.png',
//     'assets/images/rejectedUpdate.png',
//     'assets/images/targetUpdate.png',
//     'assets/images/creditUpdate.png',
//     'assets/images/withdrewUpdate.png',
//     'assets/images/rejectedUpdate.png',
//     'assets/images/targetUpdate.png',
//     'assets/images/creditUpdate.png',
//     'assets/images/withdrewUpdate.png',
//     'assets/images/rejectedUpdate.png',
//     'assets/images/targetUpdate.png',
//     'assets/images/creditUpdate.png',
//     'assets/images/withdrewUpdate.png',
//     'assets/images/rejectedUpdate.png',
//     'assets/images/targetUpdate.png',
//   ];
//   final List<Color> colorList = [
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//     ColorConstants.buttonColor,
//     Colors.red,
//   ];
//
//   int _currentIndex = 0;
//   final List carouselItems = [1, 2, 3, 4];
//
//   // ScrollController to track the position of the "Updates" section
//   final ScrollController _scrollController = ScrollController();
//   bool isScrolled = false; // Flag to track if updates section is scrolled
//
//   @override
//   void initState() {
//     super.initState();
//     // Listen to the scroll position of the "Updates" section
//     _scrollController.addListener(() {
//       if (_scrollController.offset > 0) {
//         setState(() {
//           isScrolled = true; // "Updates" section has been scrolled
//         });
//       } else {
//         setState(() {
//           isScrolled = false; // "Updates" section is at the top
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose(); // Don't forget to dispose the controller
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorConstants.primaryColor,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: ColorConstants.primaryColor,
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Adarsh",
//               style: GoogleFonts.roboto(
//                 fontWeight: FontWeight.w500,
//                 color: Colors.white,
//                 fontSize: width * 0.06,
//               ),
//             ),
//             Text(
//               "ID:2035",
//               style: GoogleFonts.roboto(
//                 fontWeight: FontWeight.w400,
//                 color: Colors.white,
//                 fontSize: width * 0.035,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(
//                   MaterialPageRoute(builder: (context) => Profile()),
//                 );
//               },
//               child: Container(
//                 width: width * .1,
//                 height: height * .1,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 2.0),
//                 ),
//                 child: CircleAvatar(
//                   backgroundColor: ColorConstants.primaryColor,
//                   child: Icon(Icons.person_outline_rounded, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//
//       body: Stack(
//         children: [
//           /// carosel slider
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: height * 0.33, // Set height as needed
//               child: CarouselSlider(
//                 options: CarouselOptions(
//                   height: height * 0.4, // Match this height
//                   autoPlay: true,
//                   enlargeCenterPage: true,
//                   viewportFraction: 1.0,
//                   enableInfiniteScroll: true,
//                   scrollPhysics: BouncingScrollPhysics(), // Better for manual scrolling
//                   onPageChanged: (index, reason) {
//                     if (!isScrolled) { // Only enable onTap if Update section is not scrolled
//                       setState(() {
//                         _currentIndex = index;
//                       });
//                     }
//                   },
//                 ),
//                 items: carouselItems.map((item) {
//                   return Container(
//                     margin: EdgeInsets.all(8),
//                     width: width * 0.9,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                       boxShadow: [
//                         BoxShadow(
//                           color: Colors.grey.withOpacity(0.3),
//                           spreadRadius: 2,
//                           blurRadius: 5,
//                           offset: Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     padding: EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text("I-CANYON TECHNOLOGIES", style: GoogleFonts.roboto(fontSize: width * 0.04)),
//                             GestureDetector(  // Changed to InkWell for better tap feedback
//                               onTap: () {
//                                 print('0000000000000000');
//                                 print('view pressed');
//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(builder: (context) => ViewPage()),
//                                 );
//                               },
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                                 decoration: BoxDecoration(
//                                   color: ColorConstants.buttonColor,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                                 child: Text("View", style: TextStyle(color: Colors.white, fontSize: width * 0.031)),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Text("Open", style: GoogleFonts.inder(fontSize: width * 0.03, color: Color.fromRGBO(0, 103, 176, 1))),
//                         SizedBox(height: height * .01),
//                         Row(
//                           children: [
//                             Expanded(
//                               flex: 3,
//                               child: InkWell(  // Changed to InkWell for better tap feedback
//                                 onTap: () {
//                                   Navigator.of(context).push(
//                                     MaterialPageRoute(builder: (context) => AddFirmScreen()),
//                                   );
//                                 },
//                                 child: Container(
//                                   height: height * 0.19,
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(16),
//                                     border: Border.all(color: Colors.grey, width: 2),
//                                   ),
//                                   child: Center(child: Icon(Icons.add, size: 40, color: Colors.grey)),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: width * .02),
//                             Container(
//                               width: width * .03,
//                               height: height * .15,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(16),
//                                 image: DecorationImage(
//                                   image: AssetImage('assets/images/homecardicon.png'),
//                                   fit: BoxFit.fill,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(width: width * .02),
//                             Expanded(
//                               flex: 4,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text("Technology & Branding", style: GoogleFonts.roboto(fontSize: width * 0.035)),
//                                   SizedBox(height: height * .04),
//                                   Text("43 Firms Added", style: GoogleFonts.roboto(fontSize: width * 0.035)),
//                                   SizedBox(height: height * .04),
//                                   Text("Commission Based", style: GoogleFonts.roboto(fontSize: width * 0.035)),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ),
//           /// carosel dots
//           Positioned(
//             top: height * .33, // Position for the dots section below the carousel
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: carouselItems.asMap().entries.map((entry) {
//                     return GestureDetector(
//                       onTap: () {
//                         if (!isScrolled) { // Only allow tap if Update section is not scrolled
//                           setState(() {
//                             _currentIndex = entry.key;
//                           });
//                         }
//                       },
//                       child: Container(
//                         width: 8.0,
//                         height: 8.0,
//                         margin: EdgeInsets.symmetric(horizontal: 4.0),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: _currentIndex == entry.key
//                               ? Colors.white
//                               : Colors.grey,
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ),
//
//           /// update section
//           Positioned.fill(
//             child: SingleChildScrollView(
//               controller: _scrollController, // Add the controller here
//               padding: EdgeInsets.only(top: height * 0.42),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(45),
//                     topRight: Radius.circular(45),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.2),
//                       spreadRadius: 2,
//                       blurRadius: 5,
//                       offset: Offset(0, -2),
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.only(top: height * .03, left: width * .05),
//                       child: Text(
//                         "Updates",
//                         style: GoogleFonts.roboto(
//                           fontSize: width * 0.05,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: height * .02),
//                     GridView.builder(
//                       shrinkWrap: true,
//                       physics: NeverScrollableScrollPhysics(),
//                       padding: const EdgeInsets.all(8.0),
//                       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 2,
//                         crossAxisSpacing: 8,
//                         mainAxisSpacing: 8,
//                         childAspectRatio: 2 / 2,
//                       ),
//                       itemCount: updateImages.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(16),
//                             border: Border.all(color: Colors.grey),
//                           ),
//                           child: Column(
//                             children: [
//                               Container(
//                                 height: height * 0.12,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(11),
//                                     topRight: Radius.circular(11),
//                                   ),
//                                   color: Colors.blueGrey,
//                                 ),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(16),
//                                     topRight: Radius.circular(16),
//                                   ),
//                                   child: Image(
//                                     fit: BoxFit.cover, image: AssetImage(updateImages[index]),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 6),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   Text("Withdrawal", style: GoogleFonts.roboto(fontSize: width * 0.035,color: Colors.black)),
//                                   Text(" AED 100", style: GoogleFonts.roboto(fontSize: width * 0.035,color: colorList[index])),
//                                 ],
//                               ),
//                               Text("EDUWISDOM ACADEMY", style: GoogleFonts.roboto(fontWeight: FontWeight.w500, fontSize: width * 0.04)),
//                               Text("20/20/2000", style: TextStyle(fontSize: 12, color: Colors.grey)),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/Login/Controller/login-controller.dart';
import 'package:icanyon/feature/home/controllor/leads-controller.dart';
import 'package:icanyon/feature/home/controllor/offer-controller.dart';
import 'package:icanyon/feature/home/screens/home/viewPage.dart';
import 'package:icanyon/feature/home/screens/updates/update-credit.dart';
import 'package:icanyon/feature/home/screens/updates/update-singlepage.dart';
import 'package:icanyon/feature/home/screens/updates/update-withdrew.dart';
import 'package:icanyon/feature/profile/Screens/profile.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:intl/intl.dart';
import 'package:upgrader/upgrader.dart';
import 'addfirm.dart';


class Homescreen extends ConsumerStatefulWidget {
   final AffiliateModel? affiliate;
  const Homescreen({super.key, this.affiliate});

  @override
  ConsumerState<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends ConsumerState<Homescreen> {
  int _currentIndex = 0;
  final List carouselItems = [1, 2, 3, 4];
    List<Map<String, dynamic>> updates = [];

    @override
  Widget build(BuildContext context) {
    final leads = ref.watch(leadsStreamProvider(''));
    final offer = ref.watch(offerStreamProvider(''));
    final affiliate =ref.watch(affiliateStreamProvider(''));

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorConstants.primaryColor,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.affiliate!.name,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: width * 0.05,
              ),
            ),
            Text(
              widget.affiliate!.userId,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                color: Colors.white,
                fontSize: width * 0.035,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Profile(affiliate :widget.affiliate)));
              },
              child: Container(
                width: width * .1,
                height: height * .1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.0),
                ),
                child: CircleAvatar(
                  backgroundColor: ColorConstants.primaryColor,
                  child: Icon(Icons.person_outline_rounded, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: UpgradeAlert(
          child: Column(
            children: [
              /// Carousel Section
              leads.when(
                data: (leads) {
                  if (leads.isEmpty) {
                    return Center(child: Text("No leads available",
                        style: TextStyle(color: Colors.white)));
                  }
                  return Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: height * 0.327,
                          autoPlay: false,
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        items: leads.map((lead) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            width: width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16),
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Top Row
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(lead.name, style: GoogleFonts.roboto(fontSize: width * 0.04)),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                                              ViewPage(lead: lead,affiliate:widget.affiliate)));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                          decoration: BoxDecoration(
                                            color: ColorConstants.buttonColor,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Text("View", style: TextStyle(color: Colors.white, fontSize: width * 0.031)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text("Open", style: GoogleFonts.inder(fontSize: width * 0.03, color: Color.fromRGBO(0, 103, 176, 1))),
                                  SizedBox(height: height * .01),
                                  /// Card Content
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: InkWell(
                                          onTap: () async {
                                            await Navigator.of(context).push(MaterialPageRoute(builder:
                                                (context) => AddFirmScreen(affiliate: widget.affiliate, leads: lead,),));
                                          },
                                          child: Container(
                                            height: height * 0.19,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              border: Border.all(color: Colors.grey, width: 2),
                                            ),
                                            child: Stack(
                                              children: [
                                                // Background halves
                                                Column(
                                                  children: [
                                                    // Yellow half
                                                    Expanded(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Color.fromRGBO(237, 237, 237, 1),
                                                          borderRadius: BorderRadius.only(
                                                            topLeft: Radius.circular(6),   // Adjust the radius as needed
                                                            topRight: Radius.circular(6),
                                                          ),
                                                        ),
                                                      )
                                                    ),
                                                    // White half with "Add Firm" text
                                                    Expanded(
                                                      child: Container(
                                                        color: Colors.white,
                                                        child: Padding(
                                                          padding:  EdgeInsets.only(top: height*.045),
                                                          child: Text(
                                                            'Add Lead',
                                                            style: GoogleFonts.roboto(
                                                              color: Colors.black,
                                                              fontWeight: FontWeight.w400,
                                                              fontSize: width * 0.04,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                // Circular + button in center
                                                Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    width: width * 0.10,
                                                    decoration: BoxDecoration(
                                                      color: Colors.black,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(color: Colors.white, width: 3),
                                                    ),
                                                    child: Center(
                                                      child: Text('+',
                                                        style: GoogleFonts.roboto(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w200,
                                                          fontSize: width * 0.08,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: width * .03),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Dot 1
                                    Container(
                                      width: width * 0.02,
                                      height: width * 0.02,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black, width: 1),
                                      ),
                                    ),
                                    // Divider 1
                                    Container(
                                      width: 1,
                                      height: height * 0.063,
                                      color: Colors.black,
                                    ),
                                    // Dot 2
                                    Container(
                                      width: width * 0.02,
                                      height: width * 0.02,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black, width: 1),
                                      ),
                                    ),
                                    // Divider 2
                                    Container(
                                      width: 1,
                                      height: height * 0.063,
                                      color: Colors.black,
                                    ),
                                    // Dot 3
                                    Container(
                                      width: width * 0.02,
                                      height: width * 0.02,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black, width: 1),
                                      ),
                                    ),
                                  ],
                                ),

                                      SizedBox(width: width * .03),
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(lead.industry, style: GoogleFonts.roboto(fontSize: width * 0.035)),
                                            SizedBox(height: height * .045),
                                            Text("${ lead.firms.length} Firms Added", style: GoogleFonts.roboto(fontSize: width * 0.035)),
                                            SizedBox(height: height * .045),
                                            Text('Commission', style: GoogleFonts.roboto(fontSize: width * 0.035)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      /// Dots Indicator
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: leads.asMap().entries.map((entry) {
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == entry.key ? Colors.black : Colors.grey,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  );
                },
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text("Error loading leads", style: TextStyle(color: Colors.red))),
              ),

              SizedBox(height: height*.03,),
              /// Bottom White Container
        Container(
          width: double.infinity,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.4, // 👈 FIXES EMPTY HEIGHT ISSUE
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: height * .03, left: width * .05),
                child: Text(
                  "Updates",
                  style: GoogleFonts.roboto(
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              offer.when(
                data: (offerList) {
                  return affiliate.when(
                    data: (affiliateData) {
                      List<Map<String, dynamic>> updateList = [];

                      if (affiliateData.isNotEmpty && widget.affiliate!.id != null) {
                        final currentAffiliate = affiliateData.firstWhere(
                              (aff) => aff.id == widget.affiliate!.id,
                        );

                        // Add withdrawals
                        for (var withdrawal in currentAffiliate.totalWithdrawals) {
                          updateList.add({
                            'type': 'withdrawal',
                            'amount': withdrawal.amount.toStringAsFixed(0),
                            'date': withdrawal.addedTime,
                            'image': withdrawal.image?.isNotEmpty == true
                                ? withdrawal.image : 'assets/images/withdrewImageHome.jpeg',
                            'description': withdrawal.description,
                            'currency': withdrawal.currency,
                            'addedTime': withdrawal.addedTime,
                          });
                        }

                        // Add credits
                        for (var credit in currentAffiliate.totalCredits) {
                          updateList.add({
                            'type': 'credit',
                            'amount': credit.amount.toStringAsFixed(0),
                            'date': credit.addedTime,
                            'image': credit.image?.isNotEmpty == true
                                ? credit.image
                                : 'assets/images/creditImageHome.jpeg',
                            'description': credit.description,
                            'currency': credit.currency,
                            'addedTime': credit.addedTime,
                          });
                        }

                        // Add offers with endDate (for affiliate context)
                        for (var off in offerList) {
                          updateList.add({
                            'type': 'offer',
                            'title': off.name,
                            'amount': off.amount,
                            'date': off.endDate,
                            'image': off.image?.isNotEmpty == true
                                ? off.image : 'assets/images/offerImage1.png',
                            'description': off.description,
                            'currency': off.currency,
                            'addedTime': off.endDate,
                          });
                        }
                      } else {
                        // Add offers with current time when NO affiliate exists
                        for (var off in offerList) {
                          updateList.add({
                            'type': 'offer',
                            'title': off.name,
                            'amount': off.amount,
                            'date': off.endDate,
                            'image': off.image?.isNotEmpty == true
                                ? off.image : 'assets/images/offerImage1.png',
                            'description': off.description,
                            'currency': off.currency,
                            'addedTime': DateTime.now(),
                          });
                        }
                      }

                         // Single final sort (fixed typo: b['addedTime'] vs a['addedTime'])
                      updateList.sort((a, b) => (b['addedTime'] as DateTime).compareTo(a['addedTime'] as DateTime));

                      return updateList.isEmpty
                          ? Padding(
                        padding: EdgeInsets.only(top: height * 0.1),
                        child: Column(
                          children: [
                            Center(
                              child: Text(
                                'Welcome!\nAdd Firms, Grow Your Wealth.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: width * 0.04,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            SizedBox(height: height * .2),
                          ],
                        ),
                      )
                          : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 2 / 2,
                        ),
                        itemCount: updateList.length,
                        itemBuilder: (context, index) {
                          final item = updateList[index];
                          String title = '';
                          String subtitle = '';
                          DateTime date = DateTime.now();
                          String image = '';
                          String description = '';
                          String currency = '';

                          switch (item['type']) {
                            case 'withdrawal':
                              title = 'Amount Withdrawn';
                              subtitle = 'AED ${item['amount']}';
                              date = item['date'];
                              image = item['image'];
                              description = item['description'];
                              break;
                            case 'credit':
                              title = 'Amount Credited';
                              subtitle = 'AED ${item['amount']}';
                              date = item['date'];
                              image = item['image'];
                              description = item['description'];
                              break;
                            case 'rejected':
                              title = 'Rejected';
                              subtitle = 'AED ${item['amount']}';
                              date = item['date'];
                              image = item['image'];
                              description = item['description'];
                              break;
                            case 'offer':
                              title = item['title'];
                              subtitle = item['amount'].toString();
                              date = item['date'];
                              image = item['image'];
                              description = item['description'];
                              currency = item['currency'];
                              break;
                          }
                      return GestureDetector(
                          onTap: () {
                            if (item['type'] == 'offer') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateOfferPage(
                                    title: title,
                                    amount: subtitle,
                                    date: date,
                                    image: image,
                                    description: description,
                                    currency: currency,
                                  ),
                                ),
                              );
                            } else if (item['type'] == 'credit') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateCreditPage(
                                    title: title,
                                    amount: subtitle,
                                    date: date,
                                    image: image,
                                    description: description,
                                    currency: currency,
                                    affiliate: widget.affiliate,

                                  ),
                                ),
                              );
                            } else if (item['type'] == 'withdrawal') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UpdateWithdrewPage(
                                    title: title,
                                    amount: subtitle,
                                    date: date,
                                    image: image,
                                    description: description,
                                    currency: currency,
                                    affiliate: widget.affiliate,

                                  ),
                                ),
                              );
                            }
                            // else if (item['type'] == 'rejected') {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => UpdateWithdrewPage(
                            //         title: title,
                            //         amount: subtitle,
                            //         date: date,
                            //         image: image,
                            //         description: description,
                            //         currency: currency,
                            //         totalCredit : widget.affiliate!.totalCredit??0,
                            //         totalWithdrew : widget.affiliate!.totalWithrew??0,
                            //         affiliate: widget.affiliate,
                            //
                            //       ),
                            //     ),
                            //   );
                            // }
                          },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: height * 0.12,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  color: Colors.blueGrey,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: (item['type'] == 'withdrawal')
                                      ? Image.asset(image, fit: BoxFit.cover)
                                      : (item['type'] == 'credit')
                                      ? Image.asset(image, fit: BoxFit.cover)
                                      : (image.isNotEmpty
                                      ? CachedNetworkImage(
                                    imageUrl: image,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/offerImage2.png', fit: BoxFit.cover),
                                  )
                                      : Image.asset('assets/images/offerImage2.png', fit: BoxFit.cover)),

                                ),
                              ),
                              SizedBox(height: 6),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(title, style: GoogleFonts.roboto(fontSize: width * 0.035, color: Colors.black)),
                                  Text(
                                    '$currency ${subtitle.length > 17 ? subtitle.substring(0, 17) + '...' : subtitle}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: width *.04,
                                      color: item['type'] == 'credit'
                                          ? Colors.green
                                          : item['type'] == 'withdrawal'
                                          ? Colors.red
                                          : Colors.deepPurple,
                                    ),
                                  ),

                                Text(
                                  item['type'] == 'offer'
                                      ? 'Expired at: ${DateFormat('dd-MM-yyyy').format(date)}'
                                      :item['type'] == 'credit'?
                                  'Credited on: ${DateFormat('dd-MM-yyyy').format(date)}'
                                  :'Withdrew at: ${DateFormat('dd-MM-yyyy').format(date)}' ,
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    },

                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text("Error loading affiliate", style: TextStyle(color: Colors.red))),
            );
          },
          loading: () => Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text("Error loading offers", style: TextStyle(color: Colors.red))),
                ),
                    SizedBox(height: height*.02,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


