import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/app_page.dart';
import 'package:svr/app/modules/home/home_controller.dart';
import 'package:svr/app/modules/user/ui/user_imc_page.dart';
import 'package:svr/app/modules/user/ui/user_page.dart';
import 'package:svr/app/modules/user/ui/user_stats_page.dart';
import 'package:svr/app/modules/user/user_controller.dart';
import 'package:svr/app/modules/user/user_model.dart';
import 'package:svr/app/modules/user/user_repository.dart';

const bottomSheetShowKey = 'bottomSheetShown';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeController = HomeController();
  @override
  void initState() {
    UserRepository.init().then((value) => UserController().init());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamOut(
      stream: _homeController.pageStream.listen,
      child: (_, page) => StreamOut<UserModel>(
        stream: UserController().userStream.listen,
        child: (_, user) => AppScaffold(
          bottomNav: user.isFirst ? const SizedBox() : bottomNavigationBar(page),
          background:
              page == AppPage.calculator ? const Color(0xFFeaeaee) : const Color(0xFFffffff),
          body: PageView(
            controller: _homeController.pageController,
            onPageChanged: (i) =>_homeController.pageStream.add(AppPage.values[i]),
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              UserPage(),
              UserIMCPage(),
              UserStatsPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomNavigationBar(AppPage current) {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        decoration: const BoxDecoration(
            color: Color(0xFFF9F9F9),
            border: Border(
                top: BorderSide(
              color: Color.fromARGB(255, 239, 239, 239),
              width: 1,
            ))),
        child: Row(
          children: AppPage.values.map((e) => _itemBottomNavigationBar(current, e)).toList(),
        ),
      ),
    );
  }

  Widget _itemBottomNavigationBar(AppPage current, AppPage page) {
    bool isSelected = current == page;
    return Expanded(
      child: InkWell(
        onTap: () => _homeController.onClickItemBottomNav(page),
        child: Column(
          children: [
            const H(8),
            Icon(page.icon,
                color: page == current ? const Color(0xFF000000) : const Color(0xFF7f7f7f)),
            const H(4),
            Text(
              page.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? const Color(0xFF000000) : const Color(0xFF7f7f7f),
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            const H(8)
          ],
        ),
      ),
    );
  }
}
