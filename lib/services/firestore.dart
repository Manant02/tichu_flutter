import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tichu_flutter/models/enums.dart';
import 'package:tichu_flutter/models/service_response.dart';
import 'package:tichu_flutter/models/tichu_user.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/tichu_card.dart';
import '../models/tichu_game.dart';
import '../models/tichu_table.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance;

  Future<ServiceResponse<void>> createUserDoc(
    String uid,
    String email,
    String username,
  ) async {
    String? errString = 'Firestore.createUserDoc:error';
    try {
      _firestore.collection('users').doc(uid).set({
        'username': username,
        'email': email,
        'signupTimestamp': FieldValue.serverTimestamp(),
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.createUserDoc:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<String?>> createTichuTable(
    String name,
    bool shortGame,
    String? password,
    String creatorUid,
  ) async {
    String? errString = 'Firestore.createTichuTable:error';
    late DocumentReference? doc;
    try {
      doc = await _firestore.collection('tables').add({
        'name': name,
        'shortGame': shortGame,
        'password': password,
        'player1Uid': creatorUid,
        'player2Uid': null,
        'player3Uid': null,
        'player4Uid': null,
        'gameUid': null,
        'player1Ready': false,
        'player2Ready': false,
        'player3Ready': false,
        'player4Ready': false,
      });
      errString = null;
    } catch (e) {
      errString = 'Database.createUser:${e.toString()}';
    }

    return ServiceResponse(errString, doc?.id);
  }

  Stream<DocumentSnapshot> getTichuUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }

  Stream<QuerySnapshot> getTichuTablesStream() {
    return _firestore.collection('tables').snapshots();
  }

  Stream<DocumentSnapshot> getTichuTableStream(String uid) {
    return _firestore.collection('tables').doc(uid).snapshots();
  }

  Stream<DocumentSnapshot> getTichuGameStream(String uid) {
    return _firestore.collection('games').doc(uid).snapshots();
  }

  Future<ServiceResponse<void>> removePlayerFromTable(
    String playerUid,
    TichuTable table,
  ) async {
    String? errString = 'Firestore.removePlayerFromTable:error';
    try {
      PlayerNr? playerNr;
      if (table.player1Uid == playerUid) {
        playerNr = PlayerNr.one;
      } else if (table.player2Uid == playerUid) {
        playerNr = PlayerNr.two;
      } else if (table.player3Uid == playerUid) {
        playerNr = PlayerNr.three;
      } else if (table.player4Uid == playerUid) {
        playerNr = PlayerNr.four;
      }
      if (playerNr == null) {
        throw 'UserNotFoundOnTable';
      }
      await _firestore.collection('tables').doc(table.uid).update({
        'gameUid': null,
        '${playerNr.str}Uid': null,
        '${playerNr.str}Ready': false,
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.createUserDoc:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<void>> addPlayerToTable(
    String playerUid,
    TichuTable table,
  ) async {
    String? errString = 'Firestore.addPlayerToTable:error';
    try {
      if (table.player1Uid == playerUid ||
          table.player2Uid == playerUid ||
          table.player3Uid == playerUid ||
          table.player4Uid == playerUid) {
        throw 'PlayerAlreadyAtTable';
      }
      PlayerNr? playerNr;
      if (table.player1Uid.isEmptyOrNull) {
        playerNr = PlayerNr.one;
      } else if (table.player2Uid.isEmptyOrNull) {
        playerNr = PlayerNr.two;
      } else if (table.player3Uid.isEmptyOrNull) {
        playerNr = PlayerNr.three;
      } else if (table.player4Uid.isEmptyOrNull) {
        playerNr = PlayerNr.four;
      } else {
        throw 'TableFull';
      }
      await _firestore.collection('tables').doc(table.uid).update({
        '${playerNr.str}Uid': playerUid,
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.createUserDoc:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<TichuUser?>> getTichuUserByUid(String uid) async {
    String? errString = 'Firestore.getTichuUserByUid:error';
    TichuUser? tichuUser;
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        tichuUser = TichuUser.fromDocumentSnapshot(doc);
      } else {
        throw 'DocumentDoesntExist:$uid';
      }
      assert(tichuUser.uid == uid);
      errString = null;
    } catch (e) {
      errString = 'Firestore.getTichuUserByUid:${e.toString()}';
    }
    return ServiceResponse(errString, tichuUser);
  }

  Future<ServiceResponse<void>> swapTableSpots(
    TichuTable table,
    PlayerNr playerANr,
    PlayerNr playerBNr,
  ) async {
    String? errString = 'Firestore.changeTableSpot:error';
    try {
      await _firestore.collection('tables').doc(table.uid).update({
        '${playerANr.str}Uid': table.playerUid(playerBNr),
        '${playerBNr.str}Uid': table.playerUid(playerANr),
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.changeTableSpot:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<void>> setPlayerReady(
    TichuTable table,
    PlayerNr playerNr,
  ) async {
    String? errString = 'Firestore.setPlayerReady:error';
    try {
      await _firestore.collection('tables').doc(table.uid).update({
        '${playerNr.str}Ready': true,
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.setPlayerReady:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<void>> setPlayerNotReady(
    TichuTable table,
    PlayerNr playerNr,
  ) async {
    String? errString = 'Firestore.setPlayerReady:error';
    try {
      await _firestore.collection('tables').doc(table.uid).update({
        '${playerNr.str}Ready': false,
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.setPlayerReady:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<void>> makeTrade(
    TichuGame game,
    PlayerNr playerNr,
    List<TichuCard> cards,
  ) async {
    String? errString = 'Firestore.setPlayerReady:error';
    try {
      await _firestore.collection('trades').doc(game.uid).update({
        playerNr.str: cards.map((card) => card.str).toList(),
      });
      errString = null;
    } catch (e) {
      errString = 'Firestore.setPlayerReady:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }
}
