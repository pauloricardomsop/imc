import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/enums/imc_level.dart';
import 'package:svr/app/core/utils/global_resource.dart';
import 'package:svr/app/modules/user/ui/components/imc_chart.dart';
import 'package:svr/app/modules/user/ui/components/imc_confirm_delete_dialog.dart';
import 'package:svr/app/modules/user/ui/components/imc_desc.dart';
import 'package:svr/app/modules/user/ui/components/imc_list_info.dart';
import 'package:svr/app/modules/user/ui/user_recents_imc_page.dart';
import 'package:svr/app/modules/user/user_controller.dart';
import 'package:svr/app/modules/user/user_model.dart';

class UserIMCPage extends StatefulWidget {
  final UserModel? user;
  const UserIMCPage({this.user, super.key});

  @override
  State<UserIMCPage> createState() => _UserIMCPageState();
}

class _UserIMCPageState extends State<UserIMCPage> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: StreamOut<UserModel>(
        stream: UserController().userStream.listen,
        child: (_, __) {
          final user = widget.user ?? __;
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ListView(
                padding: EdgeInsets.zero,
                children: [
                  if (widget.user != null)
                    InkWell(
                      onTap: () async {
                        final result = await showDialog(
                            context: context, builder: (_) => const ImcConfirmDialog());
                        if (result == null) return;
                        if (result) Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'discard'.tr(),
                          style: const TextStyle(
                            color: Color(0xFF000000),
                            fontSize: 17,
                          ),
                        ),
                      ),
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'bmi'.tr(),
                                style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                DateFormat('MMM. d, yyyy').format(user.date),
                                style: const TextStyle(
                                  color: Color(0xFF000000),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => push(context, const UserRecentsImcPage()),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 16, top: 8),
                            child: Text(
                              'recent'.tr(),
                              style: const TextStyle(color: Colors.blue, fontSize: 14),
                            ),
                          ),
                        )
                      ],
                    ),
                  IMCChart(user.imcValue),
                  Container(
                    transform: Matrix4.translationValues(0, -140, 0),
                    child: Column(
                      children: [
                        Text(
                          'your_bmi_is'.tr(),
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                        Text(
                          user.imcValue.toStringAsFixed(1),
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 58,
                              height: 1.05),
                        ),
                        const H(8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                          decoration: BoxDecoration(
                            color: user.imcLevel.color,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            user.imcLevel.label,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        const H(10),
                        Text(
                          [user.weightLabel, user.heightLabel, user.gender.name, '${user.age} anos']
                              .join(' | '),
                          style: const TextStyle(
                              color: Color(0xFF9b9b9b), fontSize: 13, letterSpacing: 0.4),
                        ),
                        const H(8),
                        ImcListInfo(user.imcLevel),
                        const H(8),
                        ImcDesc(user),
                        const H(16),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          width: double.maxFinite,
                          height: 3,
                          color: const Color(0xFFf4f4f4),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (widget.user != null) _salvarWidget(),
            ],
          );
        },
      ),
    );
  }

  Widget _salvarWidget() {
    return InkWell(
      onTap: () => _controller.onClickSalvar(context, userCopy: widget.user),
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: const Color(0xFF3559cf),
          borderRadius: BorderRadius.circular(32),
        ),
        child: Text(
          'save'.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
