import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/common/textEditingControllors.dart';
import 'package:icanyon/feature/Login/Controller/login-controller.dart';
import 'package:icanyon/feature/home/screens/home/bottombar.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/common/alertbox.dart';
import '../../../core/common/global variables.dart';
import '../../../core/common/imagePicker.dart';
import '../../../core/common/lodings.dart';
import '../../../core/common/search-qurey.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/constants/color-constnats.dart';
import '../../../model/affiliate-model.dart';

class EditProfileScreen extends StatefulWidget {
  final AffiliateModel? affiliate;

  const EditProfileScreen({super.key, this.affiliate});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  PickedImage? pickedProfile;

  String? country;
  List<String> allCountries = [];


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    affiliateNameController.text = widget.affiliate!.name;
    affiliatePhoneNoController.text = widget.affiliate!.phone;
    affiliateEmailController.text = widget.affiliate!.mailId;
    affiliateUserIdController.text = widget.affiliate!.userId;
    affiliateCountryController.text = widget.affiliate!.country;
    affiliateZoneController.text = widget.affiliate!.zone;
    affiliateLevelController.text = widget.affiliate!.level;

    final countryList = CountryService().getAll();
    final countryNames = countryList.map((c) => c.name).toList();
    allCountries = countryNames;

    if (countryNames.contains(widget.affiliate!.country)) {
      country = widget.affiliate!.zone;
    } else {
      country = null;
    }
  }

  void _loadAllCountries() {
    final countryList = CountryService().getAll();
    final countryNames = countryList.map((c) => c.name).toList();

    setState(() {
      allCountries = countryNames;

      // ✅ Only set location if valid
      if (countryNames.contains(widget.affiliate!.zone)) {
        country = widget.affiliate!.zone;
      } else {
        country = null; // fallback to null if invalid zone
      }
    });
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
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
                'Edit Profile',
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
              padding: EdgeInsets.only(top: 60, left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: height*.03),
                            Text('Name'),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: affiliateNameController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
                                ),
                                suffixIcon: Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Phone No'),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: affiliatePhoneNoController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
                                ),
                                suffixIcon: Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Email ID'),
                            SizedBox(height: 5),
                            TextFormField(
                              controller: affiliateEmailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
                                ),
                                suffixIcon: Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Country'),
                            SizedBox(height: 5),
                            TextFormField(
                              readOnly: true,
                              initialValue: affiliateCountryController.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
                                ),
                                // suffixIcon: Icon(Icons.calendar_month_sharp, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Zone'),
                            SizedBox(height: 5),
                            TextFormField(
                              readOnly: true,
                              initialValue: affiliateZoneController.text,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
                                ),
                                // suffixIcon: Icon(Icons.edit, color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text('Level'),
                            SizedBox(height: 5),
                            TextFormField(
                              initialValue: affiliateLevelController.text,
                              readOnly: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.grey, width: 2),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Consumer(
                              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                                return GestureDetector(
                                    onTap: () async {
                                      if (affiliateNameController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Your Name');
                                        return;
                                      }
                                      if (affiliatePhoneNoController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Phone No');
                                        return;
                                      }
                                      if (affiliateEmailController.text.isEmpty) {
                                        showCommonSnackbar(context, 'Please Enter Email ID');
                                        return;
                                      }
                                      showCustomAlertBox(
                                        context,
                                        'Do you want edit your profile?',
                                            () async {
                                          print('thottuuuuuuuuuuuuuuuuuu');
                                          showLoadings(context);
                                          String profileUrl = widget.affiliate!.profile ?? '';
                                          print('000000000000000000000000000000000');

                                          // print('pickedProfile: $pickedProfile');
                                          // print('final profileUrl: $profileUrl');
                                          // print('000000000000000000000000000000000');

                                          try {

                                            if (pickedProfile != null) {
                                              final uploadedUrl = await ImagePickerHelper.uploadImageToFirebase(pickedProfile!);
                                              if (uploadedUrl != null) {
                                                profileUrl = uploadedUrl;
                                              } else {
                                                showCommonSnackbar(context, 'Image upload failed');
                                                hideLoading(context); // ✅ Ensure this is called
                                                return;
                                              }
                                            }

                                            print('Creating AdminModel...');
                                            final AffiliateModel updateAffiliate = widget.affiliate!.copyWith(
                                              name: affiliateNameController.text,
                                                mailId: affiliateEmailController.text,
                                                phone: affiliatePhoneNoController.text,
                                                profile: profileUrl,
                                                search: setSearchParam(
                                                  affiliateNameController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      affiliateEmailController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      affiliatePhoneNoController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      affiliateCountryController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      affiliateZoneController.text.trim().toUpperCase() +
                                                      ' ' +
                                                      affiliateUserIdController.text.trim().toUpperCase(),
                                                ),);

                                            print('Calling leads...');
                                            await ref.read(affiliateControllerProvider.notifier)
                                                .updateAffiliate(context: context, affiliateModel: updateAffiliate);
                                            print('leads completed');

                                            hideLoading(context);
                                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) =>
                                                BottomBarSection(affiliate: updateAffiliate,),),  (route) => false,);

                                          } catch (e) {
                                            hideLoading(context);
                                            print('Error during save: $e');
                                            showCommonSnackbar(context, 'Something went wrong!');
                                          }
                                        },
                                      );
                                    },
                                  child: Container(
                                    width: double.infinity,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: ColorConstants.buttonColor,
                                      borderRadius: BorderRadius.circular(8), // Optional: rounded corners
                                    ),
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                );
                              },

                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            /// Profile Picture (positioned on top)
            Stack(
              children:[
              Align(
              alignment: Alignment.topCenter,
              child: pickedProfile != null
                  ? CircleAvatar(
                radius: width * 0.14,
                backgroundImage: MemoryImage(pickedProfile!.bytes),
              )
                  : widget.affiliate!.profile.isEmpty
                  ? CircleAvatar(
                radius: width * 0.14,
                backgroundImage: AssetImage('assets/images/defulat-profile.png'),
              )
                  : CircleAvatar(
                radius: width * 0.14,
                backgroundImage: NetworkImage(widget.affiliate!.profile),
              ),
            ),
                Padding(
                  padding:  EdgeInsets.only(left: width*.55,top: height*.09),
                  child: GestureDetector(
                    onTap: () async {
                      final picked = await ImagePickerHelper.pickImage();
                      if (picked != null) {
                        setState(() {
                          pickedProfile = picked;
                        });
                      } else {
                        print("No image selected.");
                      }
                    },
                    child: CircleAvatar(
                      backgroundColor: ColorConstants.buttonColor,
                      radius: width*.045,
                      child: Icon(Icons.camera_alt_outlined,color: Colors.white,size: width*.045,),
                    ),
                  ),
                )
              ] ,
            ),
          ],
        ),
      ),
    );
  }
}
