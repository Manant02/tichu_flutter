import 'package:cloud_firestore/cloud_firestore.dart';

class TichuUser {
  final String uid;
  final String username;
  final String email;
  final DateTime signupTimestamp;

  TichuUser({
    required this.uid,
    required this.username,
    required this.email,
    required this.signupTimestamp,
  });

  factory TichuUser.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return TichuUser(
      uid: doc.id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      signupTimestamp: DateTime.fromMicrosecondsSinceEpoch(
          data['signupTimestamp']?.microsecondsSinceEpoch ?? 0),
    );
  }
}
