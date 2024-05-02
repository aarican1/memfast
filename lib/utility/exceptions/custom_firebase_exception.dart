

class CustomFirebaseException implements Exception {
  final String description;

  CustomFirebaseException({required this.description});

  
  @override
  String toString() {
    
    return '$this $description';
  }
}
