import 'package:equatable/equatable.dart';

import 'package:memfast/models/base_firebase_model.dart';
import 'package:memfast/utility/exceptions/custom_firebase_exception.dart';

class Number extends Equatable with IdModel, BaseFirebaseModel<Number> {
  Number( {
    this.number,
  });
  final String? number;

  @override
  String? get id => '';
  Number copyWith({
    String? number,
  }) {
    return Number(
      number: number ?? this.number,
    );
  }

  @override
  List<Object?> get props => [number];

  @override
  Number fromJson(Map<String, dynamic> json) {
    final value = json["number"] as String?;
    if (value != null) {
      return Number(number:value);
    } else {
      throw CustomFirebaseException(description: 'Invalid value in JSON');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
    };
  }
}
