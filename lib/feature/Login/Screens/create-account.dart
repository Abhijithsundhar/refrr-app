import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:icanyon/feature/Login/Screens/waiting-page.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/common/global variables.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  int _step = 1;
  bool showJobHistory = false;
  List<String> previousIndustries = [""];
  File? _profileImage;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: width * 0.06),
          hoverColor: Colors.transparent,splashColor: Colors.transparent,
          onPressed: () {
            if (_step > 1) {
              setState(() => _step--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("CREATE AN ACCOUNT",
                style: GoogleFonts.roboto(
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w700,
                    color: Colors.black)),
            SizedBox(height: 6),
            Text(
              _step == 1
                  ? "Step 1 of 3 : Personal Information"
                  : _step == 2
                  ? "Step 2 of 3 : Professional Details"
                  : "Step 3 of 3 : Career Preferences",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500,
                fontSize: width * 0.035,
                color: Colors.grey[400],
              ),
            ),

            SizedBox(height: 15),
            // Progress Bar
            Row(
              children: List.generate(3, (index) {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    height: 5,
                    decoration: BoxDecoration(
                      color: index < _step ? ColorConstants.appBlue : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: index != _step - 1
                          ? Border.all(color: Colors.cyan, width: 1)
                          : null,
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 25),

            // Step 1: Personal Info
            if (_step == 1) ...[
              _buildTextField("Full Name"),
              _buildTextField("Gender", hasArrow: true),
              _buildTextField("Country", hasArrow: true),
              _buildTextField("Phone Number", keyboardType: TextInputType.phone),
              _buildTextField("Email Address", keyboardType: TextInputType.emailAddress),
              _buildTextField("Age", keyboardType: TextInputType.number),
              // 👇 Replace this part
              GestureDetector(
                onTap: () async {
                  final picker = ImagePicker();
                  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _profileImage = File(pickedFile.path);
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3F3F3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Profile Photo",
                        style: GoogleFonts.roboto(
                          fontSize: 15,
                          color:Color(0xFF848484),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 👇 Show selected image below
              if (_profileImage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          _profileImage!,
                          height: 120,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          width: width*.17,
                          height: height*.03,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Padding(
                            padding:  EdgeInsets.only(left: width*.02),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white, fontSize: width*.03),
                                ),
                                Icon(Icons.delete, color: Colors.white, size: width*.04),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],

            // Step 2: Professional Details
            if (_step == 2) ...[
              _buildTextField("Highest Qualification", hasArrow: true),
              _buildTextField("Current Job Title"),
              _buildTextField("Current Job Type", hasArrow: true),
              _buildTextField("Years of Experience", hasArrow: true),
              _buildTextField("Job History", hasPlus: true,
                onTap: () {
                  setState(() => showJobHistory = !showJobHistory);
                },
              ),

              // if (showJobHistory)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Previous Industry',style: GoogleFonts.roboto(
                      color: Colors.grey,fontSize: width*.037
                    ),),
                    ...List.generate(previousIndustries.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: _buildTextFieldBorder("", hasArrow: true),
                      );
                    }),

                    SizedBox(height: 10),

                    GestureDetector(
                      onTap: () {
                        setState(() {
                          previousIndustries.add("");
                        });
                      },
                      child:Row(
                        children: [
                          Container(
                            width: width * .08,
                            height: width * .08,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 1), // 👈 border
                            ),
                            child: Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                                size: width * .05, // 👈 smaller plus inside
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            'Add Another Industry',
                            style: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: width * .04,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ],

            // Step 3: Account Preferences
            if (_step == 3) ...[
              _buildTextField("I am an...", hasArrow: true),
              _buildTextField("Preferred Industries", hasArrow: true),
              _buildTextField("Preferred Work Location", hasArrow: true),
              // _buildTextField("Expected Salary", hasArrow: true),
              _buildTextField("Desired Job Type", hasArrow: true),
            ],
            SizedBox(height: _step == 3 ? height * .4 : height * .15,),
            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: height * 0.018),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    if (_step < 3) {
                      _step++;
                    } else {
                      Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) =>  LandingPage()),);
                    }
                  });
                },
                child: Text(
                  _step < 3 ? "Submit" : "Create Account",
                  style: GoogleFonts.roboto(
                      fontSize: width * .042,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }

  // Reusable text field
  Widget _buildTextField(String hintText,
      {TextInputType keyboardType = TextInputType.text,
        bool hasArrow = false,
        bool hasPlus = false,
        VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: GoogleFonts.roboto(
                  fontSize: 15, color: Color(0xFF848484)),
            ),
            if (hasArrow)
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            if (hasPlus) const Icon(Icons.add, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldBorder(String hintText,
      {TextInputType keyboardType = TextInputType.text,
        bool hasArrow = false,
        bool hasPlus = false,
        VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          // color: const Color(0xFFF3F3F3),
          borderRadius: BorderRadius.circular(8),
          border:Border.all(color: Color(0xFFF3F3F3),width: width*.005)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              hintText,
              style: GoogleFonts.roboto(
                  fontSize: 15, color: Color(0xFF848484)),
            ),
            if (hasArrow)
              const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            if (hasPlus) const Icon(Icons.add, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}