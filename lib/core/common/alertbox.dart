import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/color-constnats.dart';
import 'global variables.dart';

void showCustomAlertBox(BuildContext context, String message, VoidCallback onYesPressed,) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        content: Text(message,style: TextStyle(fontSize: width*.04)),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            } ,
            child: Container(
              width: width * .1,
              height: height * .05,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstants.buttonColor,
                  width: width * .004,
                ),
                borderRadius: BorderRadius.circular(width * .01),
              ),
              child: Center(child: Text('Cancel')),
            ),
          ),
          SizedBox(width: width*.02,),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              onYesPressed();
            },
            child: Container(
              width: width * .09,
              height: height * .035,
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstants.buttonColor,
                  width: width * .004,
                ),
                borderRadius: BorderRadius.circular(width * .01),),
              child: Center(child: Text('yes')),
            ),
          ),
        ],
      );
    },
  );
}

///common alert box good ui
void showCommonAlertBox(BuildContext context, String message, VoidCallback onYesPressed, String buttonText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        title: Text(
          message,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Cancel Button (White with black border)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              // Action Button (Black background)
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  onYesPressed();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    buttonText,
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
        ],
      );
    },
  );
}
