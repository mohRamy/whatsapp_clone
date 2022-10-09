import 'package:flutter_contacts/contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';
import '../repo/select_contacts_repo.dart';


final selectContactsControllerProvider = Provider((ref) {
  final selectContactsRepo = ref.watch(selectContactsRepoProvider);
  return SelectContactsController(selectContactsRepo: selectContactsRepo);
});

final getCotnactsProvider = FutureProvider((ref){
  final selectContactsController = ref.watch(selectContactsControllerProvider);
  return selectContactsController.getContacts();
});

final foundCotnactsProvider = FutureProvider((ref){
  final selectContactsController = ref.watch(selectContactsControllerProvider);
  return selectContactsController.foundContacts();
});



class SelectContactsController {
  final SelectContactsRepo selectContactsRepo;
  SelectContactsController({
    required this.selectContactsRepo,
  });

  Future<List<Contact>> getContacts() async {
    return selectContactsRepo.getContacts();
  }

  Future<List<UserModel>> foundContacts(){
    return selectContactsRepo.foundContacts();
  }

  
}
