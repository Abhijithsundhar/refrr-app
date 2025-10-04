import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/model/leads-model.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileTab extends StatelessWidget {
  final LeadsModel lead;
  const ProfileTab({super.key, required this.lead, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///logo
              Padding(
                padding: EdgeInsets.only(left: width*.03,top: height*.01),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  width: width*.3,
                  height: height*.06,
                  child: Image.network(lead.logo,fit: BoxFit.fill,),
                ),
              ),
              SizedBox(height: height*.01,),

              /// about heading
              Padding(
                padding: EdgeInsets.only(left: width*.05),
                child: Text(
                  'About ${lead.name}',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width*.046
                  ),
                ),
              ),
              SizedBox(height: height*.01,),

              /// about description
              Padding(
                padding: EdgeInsets.only(left: width*.05),
                child: Text(
                  lead.aboutFirm,
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                      fontSize: width*.03
                  ),
                ),
              ),
              SizedBox(height: height*.03,),

              ///web button
        Center(
          child: GestureDetector(
            onTap: () async {
              final url = lead.website.startsWith('http') ? lead.website : 'https://${lead.website}';
              if (await canLaunchUrl(Uri.parse(url))) {
                await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              } else {
                // optional: show error if URL can't be launched
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Could not open the website'))
                );
              }
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13, horizontal: width*.25),
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.appBlue, width: 1.5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "View Website",
                    style: GoogleFonts.roboto(
                        fontSize: width*.04,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: width*.01,),
                  Icon(Icons.screen_share_outlined, color: Colors.blue),
                ],
              ),
            ),
          ),
        ),

              SizedBox(height: height*.03,),

              ///information
              Padding(
                padding: EdgeInsets.only(left: width*.05),
                child: Text(
                  'For more information contact',
                  style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: width*.046
                  ),
                ),
              ),

              Column(
                children: [
                  SizedBox(height: height*.02,),

                  ///contact
                  Row(
                    children: [
                      SizedBox(width: width*.08,),
                      Icon(Icons.phone_outlined,size: width*.04,),
                      SizedBox(width: width*.03,),
                      Text('Phone',style: GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                      SizedBox(width: width*.2,),
                      Text(lead.contactNo,style: GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                    ],
                  ),
                  SizedBox(height: height*.02,),

                  ///email
                  Row(
                    children: [
                      SizedBox(width: width*.08,),
                      Icon(Icons.alternate_email,size: width*.04,),
                      SizedBox(width: width*.03,),
                      Text('E-mail',style: GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                      SizedBox(width: width*.2,),
                      Text(lead.mail,style: GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                    ],
                  ),

                  ///address
                  SizedBox(height: height*.02,),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: width*.08,),
                      Icon(Icons.location_on_outlined,size: width*.04,),
                      SizedBox(width: width*.03,),
                      Text('Address',style: GoogleFonts.roboto(fontWeight: FontWeight.w400),),
                      SizedBox(width: width*.2,),
                      Expanded(
                        child: Text(
                          lead.address.length > 20
                              ? '${lead.address.substring(0, 20)}\n${lead.address.substring(20)}'
                              : lead.address,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
