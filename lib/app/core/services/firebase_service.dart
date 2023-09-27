import 'package:svr/app/core/models/service_model.dart';
import 'package:svr/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseService implements Service {
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
