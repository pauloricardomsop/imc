import 'package:svr/app/core/enums/app_page.dart';
import 'package:svr/app/core/enums/imc_level.dart';
import 'package:svr/app/core/enums/stats_date_type.dart';
import 'package:svr/app/core/models/app_stream.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/home/home_controller.dart';
import 'package:svr/app/modules/user/ui/user_imc_page.dart';
import 'package:svr/app/modules/user/user_model.dart';
import 'package:svr/app/modules/user/user_repository.dart';

class UserController {
  static final UserController _instance = UserController._();

  UserController._();

  factory UserController() => _instance;

  final AppStream<UserModel> userStream = AppStream<UserModel>();
  UserModel get user => userStream.value;

  final AppStream<List<UserModel>> usersStream = AppStream<List<UserModel>>();
  List<UserModel> get users => usersStream.value;

  final AppStream<StatsDateType> statsTypeStream = AppStream<StatsDateType>.seed(StatsDateType.day);
  StatsDateType get statsType => statsTypeStream.value;

  void init() {
    getUser();
  }

  void getUser() {
    final users = UserRepository.getUsers();
    userStream.add(users.isNotEmpty ? users.last : UserModel.create());
    usersStream.add(users);
  }

  Future<void> onClickCalculate() async {
    final userCopy = user.copyWith();
    userCopy.imcValue = userCopy.calculateIMC();
    switch (userCopy.imcValue) {
      case < 16:
        userCopy.imcLevel = IMCLevel.severamenteAbaixo;
      case >= 16 && < 16.99:
        userCopy.imcLevel = IMCLevel.muitoAbaixo;
      case >= 17 && < 18.49:
        userCopy.imcLevel = IMCLevel.abaixo;
      case >= 18.5 && < 24.99:
        userCopy.imcLevel = IMCLevel.normal;
      case >= 25 && < 29.99:
        userCopy.imcLevel = IMCLevel.sobrepeso;
      case >= 30 && <= 34.99:
        userCopy.imcLevel = IMCLevel.obesidadeGrau1;
      case >= 35 && <= 39.99:
        userCopy.imcLevel = IMCLevel.obesidadeGrau2;
      case >= 40:
        userCopy.imcLevel = IMCLevel.obesidadeGrau3;
      default:
        userCopy.imcLevel = IMCLevel.abaixo;
    }
    push(contextGlobal, UserIMCPage(user: userCopy));
  }

  Future<void> onClickSalvar(context, {UserModel? userCopy}) async {
    final user = userCopy ?? userStream.value;
    user.isFirst = false;
    await UserRepository.addUser(user);
    getUser();
    pop(context);
    changePage(AppPage.statistics);
  }
}
