import 'dart:io';

import 'package:flutter/cupertino.dart';

TextEditingController firmNameController=TextEditingController();
TextEditingController firmIndustryController=TextEditingController();
TextEditingController firmServiceController=TextEditingController();
TextEditingController firmAddressController=TextEditingController();
TextEditingController firmPhoneNoController=TextEditingController();
TextEditingController firmEmailController=TextEditingController();
TextEditingController firmWebsiteController=TextEditingController();
TextEditingController contactPersonNameController=TextEditingController();
TextEditingController contactPersonPhoneController=TextEditingController();
TextEditingController contactPersonemailController=TextEditingController();
TextEditingController firmLocationController=TextEditingController();
TextEditingController firmStatusController=TextEditingController();
TextEditingController firmRequirementsController=TextEditingController();


 late List<Map<String, dynamic>> contactPersons;

File? pickedImage; // Import dart:io if not already
List<Map<String, dynamic>> pdfs = [];

///login

TextEditingController loginUserIdController=TextEditingController();
TextEditingController loginPasswordController=TextEditingController();

