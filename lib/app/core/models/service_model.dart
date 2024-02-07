import 'package:svr/app/core/services/date_service.dart';
import 'package:svr/app/core/services/firebase_service.dart';
import 'package:svr/app/core/services/shared_preferences_service.dart';

abstract class Service {
  Future<void> initialize();

  static bool isInitialized = false;

  static final List<Service> _applicationServices = [
    FirebaseService(),
    DateService(),
    SharedPreferencesService(),
  ];

  static Future<void> initAplicationServices() async {
    if (!isInitialized) {
      isInitialized = true;
      for (Service service in _applicationServices) {
        await service.initialize();
      }
    }
  }
}
