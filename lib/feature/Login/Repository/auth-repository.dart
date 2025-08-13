

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:icanyon/model/affiliate-model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/failure.dart';
import '../../../core/constants/firebaseConstants.dart';
import '../../../core/constants/typedef.dart';

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final loginRepositoryProvider = Provider<LoginRepository>((ref) {
  return LoginRepository(ref.watch(firestoreProvider));
});

class LoginRepository {
  final FirebaseFirestore firestore;
  LoginRepository(this.firestore);

  CollectionReference get _affiliate => firestore.collection(FirebaseCollections.affiliatesCollection);

  FutureEither<AffiliateModel> affiliateLogin({required String userId,
    required String password}) async {
    try{
      final QuerySnapshot query = await _affiliate
          .where('userId', isEqualTo: userId).
           where("delete",isEqualTo: false)
          .where('password', isEqualTo: password)
          .get();
      if(query.docs.isNotEmpty)
      {
        DocumentSnapshot  affiliate= query.docs.first;
        AffiliateModel affiliateModel = AffiliateModel.fromMap(affiliate.data() as Map<String,dynamic>);
        return right(affiliateModel);
      }
      else{
        throw "Invalid userId or Password";
      }
    }
    on FirebaseException catch( em ){
      throw em.message!;
    }
    catch (e){
      return left(Failure(failure: e.toString()));
    }
  }

  FutureEither<AffiliateModel> resetPassword({required String userId,
    required String password}) async {
    try{
      final QuerySnapshot query = await _affiliate
          .where('userId', isEqualTo: userId)
          .get();
      if(query.docs.isNotEmpty)
      {
        DocumentSnapshot  snapshot= query.docs.first;
        AffiliateModel affiliateModel = AffiliateModel.fromMap(snapshot.data() as Map<String,dynamic>);
        AffiliateModel affiliate=affiliateModel.copyWith(password: password);
        await affiliateModel.reference?.update(affiliate.toMap());
        return right(affiliate);
      }
      else{
        throw "Invalid userId";
      }
    }
    on FirebaseException catch( em ){
      throw em.message!;
    }
    catch (e){
      return left(Failure(failure: e.toString()));
    }
  }

  FutureVoid logOut()  async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove("uid");
      return right(null);
    }
    on FirebaseException catch( em ){
      throw em.message!;
    }
    catch (e){
      return left(Failure(failure: e.toString()));
    }
  }
  Future<DocumentSnapshot> getAffiliateModel({required String id}) async {
    return await _affiliate.doc(id).get();

  }
}
