// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timeless_mini/app/core_impl/di/injector_impl.dart';

// /// Permission handler
// class PermissionHandler {
//   /// Request permission
//   static Future<bool> requestPermission(
//     Permission permission, {
//     bool openSetting = true,
//   }) async {
//     /// Check if permission is granted
//     final status = await permission.status;
//     log.debug('[Permission:$permission] status: $status');

//     if (status == PermissionStatus.granted ||
//         status == PermissionStatus.limited) {
//       return true;
//     }

//     if (status == PermissionStatus.permanentlyDenied && openSetting) {
//       final context = Get.context;
//       if (context == null) return false;

//       /// Show dialog to ask user open the setting
//       await showDialog<void>(
//         // ignore: use_build_context_synchronously
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Permission Required'),
//           content: Text(
//             '$permission is required for this feature. '
//             'Please open Settings and grant permission.',
//           ),
//           actions: [
//             TextButton(
//               child: const Text('Cancel'),
//               onPressed: () => Navigator.of(context).pop(),
//             ),
//             TextButton(
//               child: const Text('Open Settings'),
//               onPressed: () async {
//                 Navigator.of(context).pop();
//                 await openAppSettings();
//               },
//             ),
//           ],
//         ),
//       );
//     } else {
//       await permission.request();
//     }
//     return await permission.status == PermissionStatus.granted;
//   }
// }
