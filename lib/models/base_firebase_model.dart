import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:memfast/utility/exceptions/custom_firebase_exception.dart';

mixin IdModel {
  String? get id;
}

mixin BaseFirebaseModel<T extends IdModel> {
  T fromJson(Map<String, dynamic> json);

  T? fromFirebase(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    if (snapshot.data() == null) {
      throw CustomFirebaseException(
          description: 'Null Error: $snapshot is null');
    }
    // bu kodu düzeltmen gerekebilir.
    snapshot.data()!.addEntries([MapEntry('id', snapshot.id)]);
    
    return fromJson(snapshot.data()!);
  }
}
