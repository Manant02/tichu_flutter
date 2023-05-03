import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/tichu_table.dart';
import 'package:tichu_flutter/services/auth.dart';
import 'package:tichu_flutter/services/firestore.dart';

import '../models/tichu_game.dart';
import '../models/tichu_user.dart';

final authUserStreamProvider = StreamProvider<User?>((ref) async* {
  final userChangesStream = Auth().getUserChangesStream();
  await for (final userChange in userChangesStream) {
    yield userChange;
  }
});

final tichuUserStreamProvider = StreamProvider<TichuUser?>((ref) async* {
  final authUserStream = ref.watch(authUserStreamProvider);
  final tichuUserStream = authUserStream.when(
    loading: () => null,
    error: (error, stackTrace) => null,
    data: (authUser) {
      if (authUser == null) return null;
      return Firestore().getTichuUserStream(authUser.uid);
    },
  );
  if (tichuUserStream != null) {
    await for (final tichuUser in tichuUserStream) {
      yield TichuUser.fromDocumentSnapshot(tichuUser);
    }
  }
  yield null;
});

final tichuTableStreamProvider =
    StreamProvider.family<TichuTable?, String>((ref, String uid) async* {
  final tichuTableStream = Firestore().getTichuTableStream(uid);
  await for (final tichuTableDoc in tichuTableStream) {
    yield TichuTable.fromDocumentSnapshot(tichuTableDoc);
  }
});

final tichuGameStreamProvider =
    StreamProvider.family<TichuGame, String>((ref, String uid) async* {
  final tichuGameStream = Firestore().getTichuGameStream(uid);
  await for (final tichuGameDoc in tichuGameStream) {
    yield TichuGame.fromDocumentSnapshot(tichuGameDoc);
  }
});
