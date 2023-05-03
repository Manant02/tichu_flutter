import 'package:cloud_firestore/cloud_firestore.dart';

class TichuGame {
  final String uid;
  final List<String>? inPlay;
  final String? turn;
  final bool player1Tichu;
  final bool player1GrandTichu;
  final List<String>? player1Stitches;
  final List<String>? player1Hand;
  final bool player2Tichu;
  final bool player2GrandTichu;
  final List<String>? player2Stitches;
  final List<String>? player2Hand;
  final bool player3Tichu;
  final bool player3GrandTichu;
  final List<String>? player3Stitches;
  final List<String>? player3Hand;
  final bool player4Tichu;
  final bool player4GrandTichu;
  final List<String>? player4Stitches;
  final List<String>? player4Hand;

  TichuGame({
    required this.uid,
    this.inPlay,
    this.turn,
    required this.player1Tichu,
    required this.player1GrandTichu,
    this.player1Stitches,
    this.player1Hand,
    required this.player2Tichu,
    required this.player2GrandTichu,
    this.player2Stitches,
    this.player2Hand,
    required this.player3Tichu,
    required this.player3GrandTichu,
    this.player3Stitches,
    this.player3Hand,
    required this.player4Tichu,
    required this.player4GrandTichu,
    this.player4Stitches,
    this.player4Hand,
  });

  factory TichuGame.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return TichuGame(
      uid: doc.id,
      inPlay: List<String>.from((data['inPlay'] ?? []).cast<String>()),
      turn: data['turn'],
      player1Tichu: data['player1Tichu'] ?? false,
      player1GrandTichu: data['player1GrandTichu'] ?? false,
      player1Stitches:
          List<String>.from((data['player1Stitches'] ?? []).cast<String>()),
      player1Hand:
          List<String>.from((data['player1Hand'] ?? []).cast<String>()),
      player2Tichu: data['player2Tichu'] ?? false,
      player2GrandTichu: data['player2GrandTichu'] ?? false,
      player2Stitches:
          List<String>.from((data['player2Stitches'] ?? []).cast<String>()),
      player2Hand:
          List<String>.from((data['player2Hand'] ?? []).cast<String>()),
      player3Tichu: data['player3Tichu'] ?? false,
      player3GrandTichu: data['player3GrandTichu'] ?? false,
      player3Stitches:
          List<String>.from((data['player3Stitches'] ?? []).cast<String>()),
      player3Hand:
          List<String>.from((data['player3Hand'] ?? []).cast<String>()),
      player4Tichu: data['player4Tichu'] ?? false,
      player4GrandTichu: data['player4GrandTichu'] ?? false,
      player4Stitches:
          List<String>.from((data['player4Stitches'] ?? []).cast<String>()),
      player4Hand:
          List<String>.from((data['player4Hand'] ?? []).cast<String>()),
    );
  }
}
