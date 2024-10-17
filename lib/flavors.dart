// /// Enum representing the different flavors of the application.
// enum Flavor {
//   /// The development flavor.
//   dev,

//   /// The production flavor.
//   prod,
// }

// /// Class containing static methods and properties related to the app's flavor.
// class F {
//   /// The current flavor of the application.
//   static Flavor? appFlavor;

//   /// The name of the current flavor.
//   static String get name => appFlavor?.name ?? '';

//   /// The title of the application based on the current flavor.
//   /// Returns 'Bento AI Dev' for the 'dev' flavor,
//   /// 'Bento AI' for the 'prod' flavor,
//   /// and 'Bento AI Undefined' if the flavor is null.
//   static String get title {
//     switch (appFlavor) {
//       case Flavor.dev:
//         return 'JejuYa (Dev)';
//       case Flavor.prod:
//         return 'Jejuya';
//       case null:
//         return throw Exception('Flavor is null');
//     }
//   }
// }
