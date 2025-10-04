import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/model/leads-model.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../model/firm-model.dart';
import '../../../../model/services-model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ConnectViewPage extends StatefulWidget {
  final LeadsModel lead;
  const ConnectViewPage({super.key, required this.lead});

  @override
  State<ConnectViewPage> createState() => _ConnectViewPageState();
}

class _ConnectViewPageState extends State<ConnectViewPage> {
  late List<AddFirmModel> filteredFirms;
  late List<ServiceModel> allServices;

  final List<String> locations = [
    "Dubai",
    "Abu Dhabi",
    "Ras Al Khaimah",
    "Sharjah",
    "Umm Al Quwain",
    "Fujairah",
    "Ajman",
    "Al Ain",
    "Doha",
    "Qatar",
  ];

  @override
  void initState() {
    super.initState();
    // ✅ Prepare firm list
    filteredFirms = List.from(widget.lead.firms)
      ..sort((a, b) => b.createTime.compareTo(a.createTime));

    // ✅ Prepare valid services list
    allServices = widget.lead.firms
        .expand((firm) => firm.services ?? [])
        .where((service) => service.delete != true) // null safe filter
        .cast<ServiceModel>()
        .toList();

    debugPrint("Firms: ${filteredFirms.length}, Services: ${allServices.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.lead.name,
          style: GoogleFonts.roboto(
            fontSize: width * 0.05,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: EdgeInsets.only(
                left: width * .03, right: width * .04, top: height * .01),
            child: Container(
              width: width * .15,
              height: height * .04,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Image.network(widget.lead.logo, fit: BoxFit.fill),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // -----------------------------
              // About Section
              // -----------------------------
              Padding(
                padding: EdgeInsets.only(left: width * .05),
                child: Text(
                  'About',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: width * .05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * .01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .05),
                child: Text(
                  widget.lead.aboutFirm,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: width * .03,
                  ),
                ),
              ),
              SizedBox(height: height * .01),

              /// Services Section

              Padding(
                padding: EdgeInsets.only(left: width * .05, top: height * .03),
                child: Text(
                  'Product or Services',
                  style: GoogleFonts.roboto(
                    fontSize: width * .05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              SizedBox(
                height: 180,
                child: Padding(
                  padding:  EdgeInsets.only(left: width*.03),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allServices.length,
                    itemBuilder: (context, index) {
                      final s = allServices[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: width * 0.02),
                        child: Stack(
                          children: [
                            Container(
                              height: 165,
                              width: width * 0.55,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF3F3F3),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 120,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: s.image.isNotEmpty
                                        ? ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        topRight: Radius.circular(8),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: s.image,
                                        fit: BoxFit.fill,
                                      ),
                                    )
                                        : const Center(
                                      child: Icon(Icons.image, size: 50, color: Colors.grey),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.03),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(s.name.toUpperCase(),
                                            style: GoogleFonts.roboto(
                                                fontSize: width * .04,
                                                fontWeight: FontWeight.w600,
                                                color: const Color(0xFF00538E))),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),

              SizedBox(height: height * .03),
              Padding(
                padding: EdgeInsets.only(left: width * .05),
                child: Text(
                  'Looking For',
                  style: GoogleFonts.roboto(
                    fontSize: width * .05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * .01),
              Row(
                children: [
                  /// Left Column
                  Expanded(
                    child: Column(
                      children: [
                        buildOption("Full time", 'assets/svg/briefcase.svg'),
                        buildOption("Part time", 'assets/svg/clock-square.svg'),
                      ],
                    ),
                  ),

                  /// Right Column
                  Expanded(
                    child: Column(
                      children: [
                        buildOption("Distributor", 'assets/svg/sq-box.svg'),
                        buildOption("Field staff", 'assets/svg/gunpoint.svg'),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * .03),
              /// Locations
              Padding(
                padding: EdgeInsets.only(left: width * .05),
                child: Text(
                  'Looking at',
                  style: GoogleFonts.roboto(
                    fontSize: width * .05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: height * .03),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .05),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ...List.generate(
                  locations.length > 8 ? 9 : locations.length,
                      (i) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, // 🔹 increased horizontal padding
                      vertical: 10,   // 🔹 increased vertical padding
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 🔹 remove fill color
                      borderRadius: BorderRadius.circular(24), // 🔹 slightly bigger radius
                      border: Border.all(color: Colors.black26, width: 1.2), // thicker border
                    ),
                    child: Text(
                      locations[i],
                      style: GoogleFonts.roboto(
                        fontSize: width * .035, // 🔹 slightly larger font
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
                if (locations.length > 8)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent, // 🔹 remove fill color
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black26, width: 1.2),
                    ),
                    child: Text(
                      "+${locations.length - 8} Cities",
                      style: GoogleFonts.roboto(
                        fontSize: width * .035,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: height * .03),

              /// Contact Info
              Padding(
                padding: EdgeInsets.only(left: width * .05),
                child: Text(
                  'For more information contact',
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: width * .046,
                  ),
                ),
              ),
              SizedBox(height: height * .02),
              Column(
                children: [
                  _buildDetailRow(
                    icon: Icons.phone_outlined,
                    label: 'Phone',
                    value: widget.lead.contactNo,
                    width: width,
                  ),
                  _buildDetailRow(
                    icon: Icons.alternate_email,
                    label: 'E-mail',
                    value: widget.lead.mail,
                    width: width,
                  ),
                  _buildDetailRow(
                    icon: Icons.location_on_outlined,
                    label: 'Address',
                    value: widget.lead.address,
                    width: width,
                  ),
                ],
              ),

              SizedBox(height: height * .04),
              Padding(
                padding: EdgeInsets.only(left: width * .05,right: width * .05),
                child: WebsiteLinkRow(
                  title: "View Website",
                  url: "www.crowninoxsteels.com",
                ),
              ),
              SizedBox(height: height * .05),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    required double width,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width * 0.08, // fixed space for icon
            child: Icon(
              icon,
              size: width * 0.05,
              color: Colors.black54,
            ),
          ),
          SizedBox(width: width *.002), // space between icon and label
          SizedBox(
            width: width * 0.25, // fixed width for labels
            child: Text(
              label,
              style: GoogleFonts.roboto(
                fontSize: width * 0.036,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(
                fontSize: width * 0.038,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF2E2E2E),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget buildOption(String title, String svgPath) {
    return Padding(
      padding: EdgeInsets.only(left: width * .04, right: width * .03,top: height*.02),
      child: Container(
        height: height*.06,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: GoogleFonts.roboto(color: Color(0xFF606060),fontSize: width*.04
                  ,fontWeight: FontWeight.w400)),
              SvgPicture.asset(
                svgPath,
                height: 22,
                width: 22,
                color: Colors.grey.shade600, // apply color tint
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class WebsiteLinkRow extends StatelessWidget {
  final String title;
  final String url;

  const WebsiteLinkRow({
    super.key,
    required this.title,
    required this.url,
  });
  Future<void> launchWebsite(String url) async {
    final uri = Uri.parse('https://$url');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchWebsite(url),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F5F5), // 🔹 outer container light grey
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // Left icon section
            Container(
              width: 75,
              height: 72,
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0), // 🔹 darker grey for icon box
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
              child:  Center(
                child: SvgPicture.asset('assets/svg/shareWebsite.svg',width: 332,
                  height: 32,
                  fit: BoxFit.contain,),
              )
            ),

            // Text section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: width*.042,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      url,
                      style: GoogleFonts.roboto(
                        fontSize: width*.03,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF606060)
                        ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}