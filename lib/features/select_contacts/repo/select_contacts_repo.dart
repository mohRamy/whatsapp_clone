import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/user_model.dart';

final selectContactsRepoProvider = Provider(
  (ref) => SelectContactsRepo(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  ),
);

class SelectContactsRepo {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  SelectContactsRepo({
    required this.firestore,
    required this.auth,
  });

  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    List<Contact> contact = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
        for (var i = 0; i < contacts.length; i++) {
          var contactPhone = contacts[i].phones[0].number.replaceAll(
              ' ',
              '',
            );
            if (contactPhone != auth.currentUser!.phoneNumber) {

              contact.add(contacts[i]);
            }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contact;
  }

  Future<List<UserModel>> foundContacts() async {
    List<UserModel> foundContact = [];
    try {
      var usersCollection = await firestore.collection('users').get();
      
      List<Contact> contacts = await getContacts();

      for (var element in usersCollection.docs) {
        UserModel userData = UserModel.fromMap(element.data());
        for (var i = 0; i < contacts.length; i++) {
          var contactPhone = contacts[i].phones[0].number.replaceAll(
              ' ',
              '',
            );
            if (contactPhone == userData.phoneNumber && userData.phoneNumber != auth.currentUser!.phoneNumber) {
          foundContact.add(
            UserModel.fromMap(
              element.data(),
            ),
          );
        }
        }
        
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return foundContact;
  }
}
