import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/core/common/snackbar.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/Login/Screens/login-page.dart';
import 'package:icanyon/feature/profile/Screens/language-section.dart';
import 'package:icanyon/feature/profile/Screens/notification.dart';
import 'package:icanyon/feature/profile/Screens/privacy-policy.dart';
import 'package:icanyon/model/affiliate-model.dart';
import '../../../core/common/alertbox.dart';
import '../../../core/common/profile-item-cards.dart';
import '../../Login/Controller/auth-controller.dart';
import '../../Login/Controller/login-controller.dart';
import 'contact-us.dart';
import 'edit-profile.dart';
import 'invite-friends.dart';

class Profile extends StatefulWidget {
  final AffiliateModel? affiliate;
  const Profile({super.key, this.affiliate});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding:  EdgeInsets.only(top: height*.02),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only( left: width*.08,bottom: height*.1),
              child: Text(
                'Profile',
                style: GoogleFonts.roboto(
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 60),
              width: double.infinity,
              padding: EdgeInsets.only(top: height*.06, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      widget.affiliate!.name,
                      style: GoogleFonts.roboto(fontSize: width*.06, fontWeight: FontWeight.w400,color: Colors.black),
                    ),
                    Text(
                      widget.affiliate!.mailId,
                      style: GoogleFonts.roboto(fontSize: width*.035, fontWeight: FontWeight.w300,color: Colors.black),                  ),
                    SizedBox(height: height*.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: width * .06,
                              backgroundColor: Color.fromRGBO(0, 103, 176, 0.05),
                              backgroundImage: AssetImage('assets/images/Cashwithdrwal.png'),
                            ),
                            SizedBox(height: height*.01,),
                            Text(
                              'Total money credited',
                              style: GoogleFonts.roboto(
                                fontSize: width * 0.029,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${widget.affiliate!.totalCredit} AED',
                              style: GoogleFonts.roboto(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: width * .06,
                              backgroundColor: Color.fromRGBO(0, 103, 176, 0.05),
                              backgroundImage: AssetImage('assets/images/creditImage.png'),
                            ),
                            SizedBox(height: height*.01,),
                            Text(
                              'Total money withdrawn',
                              style: GoogleFonts.roboto(
                                fontSize: width * 0.029,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              '${widget.affiliate!.totalWithrew} AED',
                              style: GoogleFonts.roboto(
                                fontSize: width * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    buildListTile(context, 'Edit profile', Icons.person,(){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen( affiliate: widget.affiliate),));
                    }),
                    buildListTile(context, 'Language', Icons.language,(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageSection( affiliate: widget.affiliate),));

                    }),
                    buildListTile(context, 'Invite friends', Icons.person_add_alt_1,(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => InviteFriends(affiliate: widget.affiliate),));

                    }),
                    buildListTile(context, 'Notification', Icons.notifications_active,(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage(),));

                    }),
                    buildListTile(context, 'Contact Us', Icons.help,(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ContactUs(),));

                    }),
                    buildListTile(context, 'Privacy policy', Icons.privacy_tip,(){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicy(),));

                    }),
                    ///log out
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        return buildListTile(context, 'Log out', Icons.logout_rounded,(){
                          showCommonAlertBox(context,'Are you sure, you want to log out?',
                                  (){
                            ref.watch(loginControllerProvider.notifier).logOut(context: context);
                          },
                              'Log out');
                        });
                      },
                    ),
                    ///delete
                    Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) {
                        return buildListTile(context, 'Delete Account', Icons.delete_forever,(){

                          showCommonAlertBox(context,'Are you sure, you want to delete your account?',
                                  () async {
                            final AffiliateModel updateAffiliate = widget.affiliate!.copyWith(delete: true);
                            await ref.read(affiliateControllerProvider.notifier)
                                .updateAffiliate(context: context, affiliateModel: updateAffiliate);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                                LoginPage(),),  (route) => false,);
                            showCommonSnackbar(context, 'Account deleted successfully');
                            },
                              'Delete');

                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: widget.affiliate!.profile.isEmpty?
              CircleAvatar(
                radius: width*.14,
                backgroundImage: AssetImage('assets/images/defulat-profile.png'), // Replace with your image asset
              ):CircleAvatar(
                radius: width*.14,
                backgroundImage: NetworkImage(widget.affiliate!.profile), // Replace with your image asset
              ),
            ),
          ],
        ),
      ),
    );
  }
}


