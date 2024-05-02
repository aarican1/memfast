// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:memfast/models/base_firebase_model.dart';

class UserModel extends Equatable with IdModel, BaseFirebaseModel<UserModel> {
  const UserModel({
    this.username,
    this.id,
    this.openLockLevel,
    this.score,
  });
  final String? username;
  @override
  final String? id;
  final int? openLockLevel;
  final int? score;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['score'] = score;
    data['openLockLevel'] = openLockLevel;
    return data;
  }

  @override
  List<Object?> get props => [username, id, score, openLockLevel];

  @override
  UserModel fromJson(Map<String, dynamic> json) {
    return UserModel(
      openLockLevel: json['openLockLevel'],
      id: json['id'],
      username: json['username'],
      score: json['score'],
    );
  }

  UserModel copyWith({
    String? username,
    String? id,
    int? openLockLevel,
    int? score,
  }) {
    return UserModel(
      username: username ?? this.username,
      id: id ?? this.id,
      openLockLevel: openLockLevel ?? this.openLockLevel,
      score: score ?? this.score,
    );
  }
}
