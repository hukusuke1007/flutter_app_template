// TODO(shohei): Functionsの実装
// import 'package:cloud_functions/cloud_functions.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// final cloudFunctionsRepositoryProvider =
//     Provider<CloudFunctionsRepository>((ref) {
//   return CloudFunctionsRepository(
//       FirebaseFunctions.instanceFor(region: 'asia-northeast1'));
// });
//
// class CloudFunctionsRepository {
//   CloudFunctionsRepository(this._functions);
//
//   final FirebaseFunctions _functions;
//
//   Future<void> deleteAccount() async {
//     try {
//       final callable = _functions
//           .httpsCallable('v1-callable-adventure-adventurer-deleteAccount');
//       await callable<void>();
//     } on FirebaseFunctionsException catch (e) {
//       logger.shout(e.toString());
//       throw AppException(title: e.code, detail: e.message ?? '');
//     }
//   }
// }
