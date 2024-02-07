import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/enums/imc_level.dart';
import 'package:svr/app/core/enums/turns.dart';
import 'package:svr/app/modules/user/user_controller.dart';
import 'package:svr/app/modules/user/user_model.dart';

class UserRecentsImcPage extends StatefulWidget {
  const UserRecentsImcPage({super.key});

  @override
  State<UserRecentsImcPage> createState() => _UserRecentsImcPageState();
}

class _UserRecentsImcPageState extends State<UserRecentsImcPage> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        background: const Color(0xFFeaeaee),
        body: StreamOut<List<UserModel>>(
          stream: _controller.usersStream.listen,
          child: (_, users) => Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_back, size: 24, color: Color(0xFF010101)),
                    ),
                    const W(8),
                    Text(
                      'recent'.tr(),
                      style: const TextStyle(
                          fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: users.length,
                  itemBuilder: (_, i) => Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                users[i].imcValue.toStringAsFixed(1),
                                style: const TextStyle(
                                    color: Colors.black, fontWeight: FontWeight.w900, fontSize: 24),
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                        color: users[i].imcLevel.color, shape: BoxShape.circle),
                                  ),
                                  const W(6),
                                  Text(
                                    users[i].imcLevel.label,
                                    style: const TextStyle(color: Colors.black, fontSize: 17),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              DateFormat('MMM. dd, yyyy').format(users[i].date),
                              style: const TextStyle(color: Colors.black),
                            ),
                            const H(2),
                            Text(users[i].turn.label, style: const TextStyle(color: Colors.black)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
