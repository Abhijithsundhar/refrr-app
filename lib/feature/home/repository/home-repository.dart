//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fpdart/fpdart.dart';
// import '../../../core/constants/failure.dart';
// import '../../../core/constants/firebaseConstants.dart';
// import '../../../core/constants/typedef.dart';
// import '../../../model/firm-model.dart';
//
// final homeRepositoryProvider = Provider<HomeRepository>((ref) {return HomeRepository();});
//
// class HomeRepository {
//
//   ///add firm
//
//   FutureEither<AddFirmModel> addFirm(AddFirmModel firm) async {
//     try {
//       DocumentReference ref = FirebaseFirestore.instance
//           .collection(FirebaseCollections.leadsCollection).doc();
//       print('11111111111111111111111111111111111111111111111111');
//       print(ref);
//       print('1111111111111111111111111111111111111111111111111');
//
//       AddFirmModel addFirmModel=firm.copyWith(
//           reference: ref,
//           // marketerId: ref.id
//       );
//       await ref.set(addFirmModel.toMap());
//       return right(addFirmModel);
//     }
//     on FirebaseException catch(e){
//       throw e.message!;
//     }
//     catch (e) {
//       return left(Failure(failure: e.toString()));
//     }
//   }
//
//   ///update student
//   FutureVoid updateFirm(AddFirmModel firm) async {
//     try {
//       return right(await firm.reference!.update(firm.toMap()));
//     }
//     on FirebaseException catch(e){
//       throw e.message!;
//     }
//     catch (e) {
//       return left(Failure(failure: e.toString()));
//     }
//   }
//
//   ///student stream
//   Stream<List<AddFirmModel>> getFirm() {
//     return FirebaseFirestore.instance
//         .collection(FirebaseCollections.addFirmCollection)
//         .orderBy('createTime',descending:true )
//         .where('delete',isEqualTo: false)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//         .map((doc) => AddFirmModel.fromMap(doc.data()),)
//         .toList());
//   }
//
// }