import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/models/tichu_card.dart';

class TichuGame {
  final String uid;
  final List<TichuCard>? inPlay;
  final PlayerNr? turn;
  final bool trading;
  final bool player1Tichu;
  final bool player1GrandTichu;
  final List<TichuCard>? player1Stitches;
  final List<TichuCard>? player1Hand;
  final bool player2Tichu;
  final bool player2GrandTichu;
  final List<TichuCard>? player2Stitches;
  final List<TichuCard>? player2Hand;
  final bool player3Tichu;
  final bool player3GrandTichu;
  final List<TichuCard>? player3Stitches;
  final List<TichuCard>? player3Hand;
  final bool player4Tichu;
  final bool player4GrandTichu;
  final List<TichuCard>? player4Stitches;
  final List<TichuCard>? player4Hand;

  TichuGame({
    required this.uid,
    this.inPlay,
    this.turn,
    required this.trading,
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
      inPlay: (data['inPlay'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      turn: data['turn'] != null ? PlayerNr.fromString(data['turn']) : null,
      trading: data['trading'],
      player1Tichu: data['player1Tichu'] ?? false,
      player1GrandTichu: data['player1GrandTichu'] ?? false,
      player1Stitches: (data['player1Stitches'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player1Hand: (data['player1Hand'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player2Tichu: data['player2Tichu'] ?? false,
      player2GrandTichu: data['player2GrandTichu'] ?? false,
      player2Stitches: (data['player2Stitches'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player2Hand: (data['player2Hand'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player3Tichu: data['player3Tichu'] ?? false,
      player3GrandTichu: data['player3GrandTichu'] ?? false,
      player3Stitches: (data['player3Stitches'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player3Hand: (data['player3Hand'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player4Tichu: data['player4Tichu'] ?? false,
      player4GrandTichu: data['player4GrandTichu'] ?? false,
      player4Stitches: (data['player4Stitches'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
      player4Hand: (data['player4Hand'] ?? [])
          .map<TichuCard>((str) => TichuCard.fromString(str))
          .toList(),
    );
  }
}
