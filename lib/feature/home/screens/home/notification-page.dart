import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/feature/profile/Screens/profile.dart';
import 'package:icanyon/model/affiliate-model.dart';

import '../../../../core/common/global variables.dart';

class HomeNotificationPage extends StatelessWidget {
  final AffiliateModel? affiliate;
  const HomeNotificationPage({super.key, this.affiliate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar:AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            splashColor: Colors.transparent,
            hoverColor: Colors.transparent,
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "NOTIFICATIONS",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: width * 0.05,
            ),
          ),
          actions: [
            GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => Profile(affiliate: affiliate),),);            },
              child: CircleAvatar(
                radius: width * 0.045,
                backgroundImage: affiliate?.profile != null && affiliate!.profile.isNotEmpty
                    ? NetworkImage(affiliate!.profile)
                    : const AssetImage('assets/images/defulat-profile.png') as ImageProvider,
              ),
            ),
            SizedBox(width: width * 0.04), // spacing from right edge
          ],
        ),

      body:SingleChildScrollView(
         child: Column(
           children: [
             SizedBox(height: height*.02,),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: width * .04),
               child: _moneyCard(
                 icon: Icons.account_balance_wallet,
                 iconColor: Colors.orange,
                 title: 'Money Withdrawal Request',
                 subtitle: '5 days ago',
                 description: 'Jacob Sacaria requested to withdraw AED 250',
                 amount: 'AED 250',
                 showButtons: true,
               ),
             ),

             SizedBox(height: height * .04),

             /// Status Change Request
             Padding(
               padding: EdgeInsets.symmetric(horizontal: width * .04),
               child: _statusCard(
                 icon: Icons.change_circle_rounded,
                 iconColor: Colors.blue,
                 title: 'Status Change Request',
                 subtitle: '7 days ago',
                 description:
                 'Jacob Sacaria has requested to change status from Follow up needed to Proposal sent',
                 amount: 'View',
                 showButtons: true,
               ),
             ),
             SizedBox(height: height * .04),
             Padding(
               padding: EdgeInsets.symmetric(horizontal: width * .04),
               child: _moneyCard(
                 icon: Icons.account_balance_wallet,
                 iconColor: Colors.orange,
                 title: 'Money Withdrawal Request',
                 subtitle: '5 days ago',
                 description: 'Jacob Sacaria requested to withdraw AED 250',
                 amount: 'AED 250',
                 showButtons: true,
               ),
             ),


           ],
         ),
       ) ,
    );
  }
  Widget _moneyCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required String amount,
    bool showButtons = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xE5F3F3F3),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: GoogleFonts.roboto(
                      fontSize: width * .04,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.roboto(
                      fontSize: width * .03,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: width * .04,
                  color: Colors.green,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.only(left: width * .05, top: height * .02),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: width * .02, top: height * .01),
                    child: Text(
                      description,
                      style: GoogleFonts.roboto(
                        fontSize: width * .035,
                        color: Colors.grey,
                        height: 1.4,
                      ),
                    ),
                  ),
                  if (showButtons) _actionButtons(),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String description,
    required String amount,
    bool showButtons = false,
  }) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xE5F3F3F3),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Icon(icon, color: iconColor, size: 22),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.roboto(
                            fontSize: width * .04,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: GoogleFonts.roboto(
                            fontSize: width * .03,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Padding(
                padding: EdgeInsets.only(left: width * .05, top: height * .02),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.only(left: width * .02, top: height * .01),
                        child: Text(
                          description,
                          style: GoogleFonts.roboto(
                            fontSize: width * .035,
                            color: Colors.grey,
                            height: 1.4,
                          ),
                        ),
                      ),
                      if (showButtons) _actionButtons(),
                      const SizedBox(height: 5),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: height * .03,
          right: width * .05,
          child: Center(
            child: Text(
              amount,
              style: GoogleFonts.roboto(
                // decoration: TextDecoration.underline,
                fontSize: width * .04,
                color: Color(0xFF0067B0),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget _actionButtons() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: width * .2,
            height: height * .04,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFFA1616)),
              color: const Color(0x08FA1616),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'Reject',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: width * .035,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            width: width * .2,
            height: height * .04,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF33A847)),
              color: const Color(0x0833A847),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                'Accept',
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: width * .035,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
