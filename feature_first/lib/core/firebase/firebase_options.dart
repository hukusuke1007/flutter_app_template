import 'package:firebase_core/firebase_core.dart';

import '../utils/flavor.dart';
import 'dev/firebase_options.dart' as dev;
import 'prod/firebase_options.dart' as prod;

FirebaseOptions getCurrentPlatform() => switch (Flavor.environment) {
  FlavorType.dev => dev.DefaultFirebaseOptions.currentPlatform,
  FlavorType.prod => prod.DefaultFirebaseOptions.currentPlatform,
};
