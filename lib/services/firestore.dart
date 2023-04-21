import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tichu_flutter/models/service_response.dart';

import '../models/tichu_table.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance;

  Future<ServiceResponse<String?>> createTichuTable(
    String name,
    bool shortGame,
    String? password,
  ) async {
    String? errString = 'Firestore.createTichuTable:error';
    late DocumentReference? doc;
    try {
      doc = await _firestore.collection('tables').add({
        'name': name,
        'shortGame': shortGame,
        'password': password,
      });
      errString = null;
    } catch (e) {
      errString = 'Database.createUser:${e.toString()}';
    }

    return ServiceResponse(errString, doc?.id);
  }
}
