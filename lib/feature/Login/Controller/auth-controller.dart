

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icanyon/core/common/global%20variables.dart';
import 'package:icanyon/feature/Login/Screens/login-page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/common/snackbar.dart';
import '../../home/screens/home/bottombar.dart';
import '../Repository/auth-repository.dart';

final loginControllerProvider = NotifierProvider<AuthController, bool>(() => AuthController());
class AuthController extends Notifier<bool>{
  @override
  bool build() {
    return false;
  }
  LoginRepository get _loginRepository => ref.read(loginRepositoryProvider);

  affiliateLogin({required String userId,required String password,
    required BuildContext context,
    required Function() clear}) async {
    state=true;
    final affiliate = await _loginRepository.affiliateLogin(userId:userId,password:password);
    Future.delayed(Duration(seconds: 3),(){
      state=false;
    });
    affiliate.fold(
            (l) => showCommonSnackbars(context: context, message: l.failure),
            (affiliateModel) async {
          ref.read(affiliateProvider.notifier).update((state) => affiliateModel);

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('uid', affiliateModel.id ?? "");

          if (context.mounted) {
            clear();
            Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (context) =>  BottomBarSection(affiliate: affiliateModel,)),
                  (route) => false,
            );
          }
        }
    );
  }
  /// reset password
  resetPassword({required String userId,
    required String password,
    required BuildContext context}) async {
    state=true;
    final affiliate = await _loginRepository.resetPassword(password: password, userId: userId);
    Future.delayed(Duration(seconds: 3),(){
      state=false;
      affiliate.fold((l) => showCommonSnackbars(context: context,message:l.failure), (affiliateModel) async {
        ref.read(affiliateProvider.notifier).update((state) => affiliateModel,);
        showCommonSnackbars(context: context, message: "Password reset Successfully");
      });
    });
  }
  /// logout
  logOut({required BuildContext context}) async {
    state=true;
    final affiliate = await _loginRepository.logOut();
    affiliate.fold((l) => showCommonSnackbars(context: context,message:l.failure), (r) async {
      showCommonSnackbars(context: context, message: "Log out Successfully");
      Future.delayed(Duration(seconds: 1),(){
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const LoginPage(),),(route) => false);
        ref.read(affiliateProvider.notifier).update((state) => null,);
        state=false;
      });
    });
  }
  Future<DocumentSnapshot> getAffiliateModel({required String id}) async {
    return await _loginRepository.getAffiliateModel(id: id);
  }
}
