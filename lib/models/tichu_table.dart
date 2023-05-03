import 'package:cloud_firestore/cloud_firestore.dart';

import 'enums.dart';

class TichuTable {
  final String uid;
  final String name;
  final bool shortGame;
  final bool player1Ready;
  final bool player2Ready;
  final bool player3Ready;
  final bool player4Ready;
  final String? password;
  final String? player1Uid;
  final String? player2Uid;
  final String? player3Uid;
  final String? player4Uid;
  final String? gameUid;

  TichuTable({
    required this.uid,
    required this.name,
    required this.shortGame,
    required this.player1Ready,
    required this.player2Ready,
    required this.player3Ready,
    required this.player4Ready,
    this.password,
    this.player1Uid,
    this.player2Uid,
    this.player3Uid,
    this.player4Uid,
    this.gameUid,
  });

  @override
  String toString() {
    return 'TichuTable(uid: $uid, name: $name, shortGame: $shortGame)';
  }

  factory TichuTable.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return TichuTable(
      uid: doc.id,
      shortGame: data['shortGame'] ?? false,
      name: data['name'] ?? '',
      player1Ready: data['player1Ready'] ?? false,
      player2Ready: data['player2Ready'] ?? false,
      player3Ready: data['player3Ready'] ?? false,
      player4Ready: data['player4Ready'] ?? false,
      password: data['password'],
      player1Uid: data['player1Uid'],
      player2Uid: data['player2Uid'],
      player3Uid: data['player3Uid'],
      player4Uid: data['player4Uid'],
      gameUid: data['gameUid'],
    );
  }

  String? playerUid(PlayerNr playerNr) {
    return playerNr == PlayerNr.one
        ? player1Uid
        : playerNr == PlayerNr.two
            ? player2Uid
            : playerNr == PlayerNr.three
                ? player3Uid
                : playerNr == PlayerNr.four
                    ? player4Uid
                    : null;
  }

  bool playerReady(PlayerNr playerNr) {
    return playerNr == PlayerNr.one
        ? player1Ready
        : playerNr == PlayerNr.two
            ? player2Ready
            : playerNr == PlayerNr.three
                ? player3Ready
                : playerNr == PlayerNr.four
                    ? player4Ready
                    : false;
  }
}
