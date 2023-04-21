import 'package:cloud_firestore/cloud_firestore.dart';

class TichuTable {
  final String uid;
  final String name;
  final String? password;
  final bool shortGame;

  TichuTable({
    required this.uid,
    required this.name,
    required this.shortGame,
    this.password,
  });

  @override
  String toString() {
    return 'TichuTable(uid: $uid, name: $name, shortGame: $shortGame)';
  }

  factory TichuTable.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return TichuTable(
      uid: doc.id,
      shortGame: data['shortGame'],
      name: data['name'],
      password: data['password'],
    );
  }
}
