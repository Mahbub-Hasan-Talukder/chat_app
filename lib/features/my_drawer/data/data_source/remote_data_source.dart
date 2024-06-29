// import 'dart:async';
// import 'package:http/http.dart';

// class FeatureName_RemoteDataSource {
//   static FutureOr<(FeatureName_Model?,_?)> forgotPassword({required _}) async {
//     try {
//       Response response = await post(
//         Uri.parse(API._),
//         body: {
          
//         },
//       );
//       if (response.statusCode == -) {
//         return (FeatureName_Model.fromJson(jsonDecode(response.body)), null);
//       } else {
//         return (null, jsonDecode(response.body)['message'].toString());
//       }
//     } catch (e) {
//       return (null, e.toString());
//     }
//   }
// }
