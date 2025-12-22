import 'package:cloud_firestore/cloud_firestore.dart';

enum MyFirebaseCollectionEnum {
  users,
  version,
  urls
}

extension MyFirebaseCollectionExtension on MyFirebaseCollectionEnum {
  CollectionReference get references =>
      FirebaseFirestore.instance.collection(name);
      
}
