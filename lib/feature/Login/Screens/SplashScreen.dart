
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:icanyon/core/constants/color-constnats.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/common/global variables.dart';
import '../../../model/affiliate-model.dart';
import '../../home/screens/home/bottombar.dart';
import '../Controller/auth-controller.dart';
import 'onboardScreen-1.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {

  keepLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.containsKey('uid')){
      String id= pref.getString('uid') ??"";
      print("5555555555555555$id");
      if(id!=""){
        DocumentSnapshot snapshot=await ref.read(loginControllerProvider.notifier).getAffiliateModel(id: id);
        if(snapshot.exists){
          AffiliateModel affiliateModel=AffiliateModel.fromMap(snapshot.data() as Map<String,dynamic>);
          ref.read(affiliateProvider.notifier).update((state) => affiliateModel,
          );
          Navigator.pushAndRemoveUntil(context,
            CupertinoPageRoute(builder: (context) =>  BottomBarSection(affiliate: affiliateModel,),), (route) => false,
          );
        }
        else{
          print("not snaappppp");
          Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => OnboardingPage(),),(route) => false,);
        }
      }
      else{
        print("not iddddddd");
        Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => OnboardingPage(),),(route) => false,);
      }
    }
    else{
      print("keeeeeeeeeeeeeeeeeeeeeepno");
      Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (context) => OnboardingPage(),),(route) => false,);
    }
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      keepLogin();
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.appBlue,
      body: Consumer(
          builder: (context,ref,child) {
            print("splashsssssssss");
            // final connectivityStatus = ref.watch(connectivityProvider);
            return Center(
              child: SizedBox(
                height: height * 0.3,
                width: width * 0.7,
                child:
                // connectivityStatus==ConnectivityStatus.connected?
                // Image.asset('assets/images/refrrWhiteLogo.png')
                  SvgPicture.asset('assets/svg/refrrRoundLogo.svg')
                    // :const InternetError(),
              ), // Splash image
            );
          }
      ),
    );
  }
}
