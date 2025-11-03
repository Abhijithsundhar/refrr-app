
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icanyon/model/agent_model.dart';
import '../../../core/common/snackbar.dart';
import '../../../model/leads-model.dart';
import '../repository/leads-repository.dart';




final leadsRepositoryProvider = Provider((ref) => LeadsRepository());

/// Admin Stream Provider with search support
final leadsStreamProvider = StreamProvider.family<List<LeadsModel>, String>((ref, searchQuery) {
  final repository = ref.watch(leadsRepositoryProvider);

  return repository.getLeads(searchQuery);
});
/// agent Stream Provider with search support
final agentsStreamProvider = StreamProvider.family<List<AgentModel>, String>((ref,String data) {
  final repository = ref.watch(leadsRepositoryProvider);
final Map<String,dynamic> map=jsonDecode(data);
  return repository.getAgents(map['searchQuery'],map['affiliateId']);
});
final agentProvider = FutureProvider.family<AgentModel?, String>((ref, String phone) async {
  final repository = ref.watch(leadsRepositoryProvider);
    return repository.getAgent(phone);
});


/// AdminController Provider
final leadsControllerProvider = StateNotifierProvider<LeadsController, bool>((ref) {
  return LeadsController(repository: ref.read(leadsRepositoryProvider));

});


class LeadsController extends StateNotifier<bool> {final LeadsRepository _repository;

LeadsController({required LeadsRepository repository}): _repository = repository, super(false);

/// Add leads
Future<void> addLeads({
  required LeadsModel leadsModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.addLeads(leadsModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Lead added successfully");
    Navigator.pop(context);
  });
}

///update lead
Future<void> updateLeads({
  required LeadsModel leadsModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.updateLeads(leadsModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Lead updated successfully");
    Navigator.pop(context);
  });
}

/// lead stream
Stream <List<LeadsModel>>getLeads(String searchQuery ){
  return _repository.getLeads(searchQuery);
}
/// agent stream
Stream <List<AgentModel>>getAgents(String searchQuery ,String affiliateId){
  return _repository.getAgents(searchQuery,affiliateId);
}

Future<AgentModel>getAgent(String searchQuery){
  return _repository.getAgent(searchQuery);
}

///update agent
Future<void> updateAgents({
  required AgentModel agentModel,
  required BuildContext context,
}) async {
  state = true;
  var snap=await _repository.updateAgents(agentModel);
  state = false;
  snap.fold((l) =>showCommonSnackbar(context,l.failure) , (r) {
    showCommonSnackbar(context,"Sub agent added successfully");
    Navigator.pop(context);
  });
}
}
