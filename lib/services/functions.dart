import 'package:cloud_functions/cloud_functions.dart';
import 'package:tichu_flutter/models/service_response.dart';

class CloudFunctions {
  final _functions = FirebaseFunctions.instanceFor(region: 'europe-west6');

  Future<ServiceResponse<String?>> callHelloWorld() async {
    String? errString = 'CloudFunctions.callHelloWorld:error';
    HttpsCallableResult? result;
    try {
      result = await _functions.httpsCallable('helloWorld').call();
      errString = null;
    } on FirebaseFunctionsException catch (e) {
      errString =
          'CloudFunctions.callHelloWorld:${e.code}:${e.details}:${e.message}';
    } catch (e) {
      errString = 'CloudFunctions.callHelloWorld:${e.toString()}';
    }

    return ServiceResponse(errString, result?.data["response"]);
  }
}
