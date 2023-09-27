import 'package:svr/app/core/models/service_model.dart';
import 'package:intl/date_symbol_data_local.dart';

class DateService implements Service {
  @override
  Future<void> initialize() async {
    await initializeDateFormatting('pt_BR');
  }
}
