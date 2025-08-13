//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/common/snackbar.dart';
// import '../../../model/firm-model.dart';
// import '../repository/home-repository.dart';
//
//
//
// final firmRepositoryProvider = Provider((ref) => HomeRepository());
//
// /// HomeController Provider
// final homeControllerProvider = StateNotifierProvider<HomeController, bool>((ref) {
//   return HomeController(repository: ref.read(homeRepositoryProvider));
//
// });
//
// class HomeController extends StateNotifier<bool> {final HomeRepository _repository;
//
// HomeController({required HomeRepository repository}): _repository = repository, super(false);
//
// /// Add firm
// Future<void> addFirm({
//   required AddFirmModel addFirmModel,
//   required BuildContext context,
// }) async {
//   state = true;
//   var snap=await _repository.addFirm(addFirmModel);
//   state = false;
//   snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
//     showCommonSnackbar(context,"Firm added successfully");
//     Navigator.pop(context);
//   });
// }
//
// ///update student
// Future<void> updateFirm({
//   required AddFirmModel addFirmModel,
//   required BuildContext context,
// }) async {
//   state = true;
//   var snap=await _repository.updateFirm(addFirmModel);
//   state = false;
//   snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
//     showCommonSnackbar(context,"Firm updated successfully");
//     Navigator.pop(context);
//   });
// }
//
// /// student stream
// Stream <List<AddFirmModel>>getFirm(){
//   return _repository.getFirm();
// }
//
// }
