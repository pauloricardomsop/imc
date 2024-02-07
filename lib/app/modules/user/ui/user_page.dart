import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svr/app/core/components/app_scaffold.dart';
import 'package:svr/app/core/components/h.dart';
import 'package:svr/app/core/components/stream_out.dart';
import 'package:svr/app/core/components/w.dart';
import 'package:svr/app/core/enums/gender_type.dart';
import 'package:svr/app/core/enums/height_type.dart';
import 'package:svr/app/core/enums/turns.dart';
import 'package:svr/app/core/enums/weight_type.dart';
import 'package:svr/app/core/formatters/centimeter_formatter.dart';
import 'package:svr/app/core/formatters/feet_input_formatter.dart';
import 'package:svr/app/core/formatters/inc_input_formatter.dart';
import 'package:svr/app/core/formatters/weight_formatter.dart';
import 'package:svr/app/modules/user/ui/components/imc_date_selection_bottom.dart';
import 'package:svr/app/modules/user/ui/components/imc_turn_selection_bottom.dart';
import 'package:svr/app/modules/user/user_controller.dart';
import 'package:svr/app/modules/user/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        background: const Color(0xFFeaeaee),
        body: StreamOut<UserModel>(
          stream: _controller.userStream.listen,
          child: (_, user) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      _headerWidget(),
                      const H(24),
                      Row(
                        children: [
                          _weightSelectorWidget(user),
                          const W(16),
                          _heightSelectorWidget(user)
                        ],
                      ),
                      const H(42),
                      _hourSelectorWidget(user),
                      const H(42),
                      _ageSelectorWidget(user),
                      const H(24),
                      _genderSelectorWidget(user)
                    ],
                  ),
                ),
                _calculateWidget()
              ],
            ),
          ),
        ));
  }

  Widget _calculateWidget() {
    return InkWell(
      onTap: () => _controller.onClickCalculate(),
      child: Container(
        width: double.maxFinite,
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

  Row _headerWidget() {
    return Row(
      children: [
        Expanded(
            child: Text(
          'calculator'.tr(),
          style: const TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w900),
        )),
        // Icon(Icons.person, color: Colors.black)
      ],
    );
  }

  Row _genderSelectorWidget(UserModel user) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              user.gender = GenderType.male;
              _controller.userStream.update();
            },
            child: Opacity(
              opacity: user.gender == GenderType.male ? 1 : 0.5,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.male, size: 60),
                        Text('male'.tr()),
                      ],
                    ),
                  ),
                  if (user.gender == GenderType.male)
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.check_circle,
                          color: Color(0xFF3559cf),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
        const W(16),
        Expanded(
          child: GestureDetector(
            onTap: () {
              user.gender = GenderType.female;
              _controller.userStream.update();
            },
            child: Opacity(
              opacity: user.gender == GenderType.female ? 1 : 0.5,
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFffffff),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(Icons.female, size: 60),
                        Text('female'.tr()),
                      ],
                    ),
                  ),
                  if (user.gender == GenderType.female)
                    const Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.check_circle,
                          color: Color(0xFF3559cf),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _ageSelectorWidget(UserModel user) {
    return Column(
      children: [
        Text('age'.tr()),
        const H(16),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFffffff),
            borderRadius: BorderRadius.circular(16),
          ),
          width: double.maxFinite,
          height: 75,
          child: Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: 75,
                child: CarouselSlider.builder(
                  options: CarouselOptions(
                      autoPlay: false,
                      initialPage: 23,
                      animateToClosest: false,
                      enableInfiniteScroll: false,
                      height: 75,
                      viewportFraction: 0.17,
                      onPageChanged: (i, _) {
                        user.age = i;
                        _controller.userStream.update();
                      }),
                  itemCount: 99,
                  itemBuilder: (_, __, i) => Center(
                    child: Text(
                      __.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: i == user.age ? Colors.black : const Color(0xFFe5e5e5),
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      transform: Matrix4.translationValues(0, 17, 0),
                      child: const Icon(
                        Icons.arrow_drop_up_sharp,
                        color: Color(0xFF3559cf),
                        size: 42,
                      )))
            ],
          ),
        ),
      ],
    );
  }

  Widget _hourSelectorWidget(UserModel user) {
    final now = DateTime.now();
    return Column(
      children: [
        Text('time'.tr()),
        const H(16),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final date = await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => const IMCDateSelectionBottom());
                  if (date == null) return;
                  setState(() {
                    user.date = date;
                    _controller.usersStream.update();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
                  child: Text(
                    user.date.day == now.day &&
                            user.date.month == now.month &&
                            user.date.year == now.year
                        ? 'today'.tr()
                        : DateFormat('MMM. dd, yyyy').format(user.date),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
            const W(16),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final turn = await showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      builder: (_) => const IMCTurnSelectionBottom());
                  if (turn == null) return;
                  setState(() {
                    user.turn = turn;
                    _controller.usersStream.update();
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFffffff),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 17),
                  child: Text(
                    user.turn.label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Expanded _weightSelectorWidget(UserModel user) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'weight'.tr(),
            style: const TextStyle(fontSize: 14),
          ),
          const H(12),
          _textFieldWidget(user.weightEC, WeightFormatter()),
          const H(16),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFf6f6f8), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: WeightType.values.map(
                (e) {
                  final isSelected = user.weightType == e;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        user.weightType = e;
                        _controller.userStream.update();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFFf6f6f8),
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                            child: Text(
                          e.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: isSelected ? Colors.black : const Color(0xFF505050)),
                        )),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  Expanded _heightSelectorWidget(UserModel user) {
    return Expanded(
      child: Column(
        children: [
          Text(
            'height'.tr(),
            style: const TextStyle(fontSize: 14),
          ),
          const H(12),
          if (user.heightType == HeightType.cm)
            _textFieldWidget(user.centimetersEC, CentimeterFormatter())
          else
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Stack(
                      children: [
                        _textFieldWidget(user.feetEC, FeetInputFormatter()),
                        const Positioned(
                          right: 20,
                          child: Text(
                            "'",
                            style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                          ),
                        )
                      ],
                    )),
                const W(8),
                Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      _textFieldWidget(user.incEC, IncInputFormatter()),
                      Positioned(
                        right: user.incEC.text.length == 2 ? 20 : 10,
                        child: const Text(
                          "''",
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          const H(16),
          Container(
            decoration: BoxDecoration(
                color: const Color(0xFFf6f6f8), borderRadius: BorderRadius.circular(16)),
            child: Row(
              children: HeightType.values.map(
                (e) {
                  final isSelected = user.heightType == e;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        user.heightType = e;
                        _controller.userStream.update();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFFf6f6f8),
                            borderRadius: BorderRadius.circular(16)),
                        child: Center(
                            child: Text(
                          e.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              color: isSelected ? Colors.black : const Color(0xFF505050)),
                        )),
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  Container _textFieldWidget(TextEditingController controller, TextInputFormatter formatter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        inputFormatters: [formatter],
        textAlign: TextAlign.center,
        keyboardType: const TextInputType.numberWithOptions(decimal: false, signed: false),
        textAlignVertical: TextAlignVertical.center,
        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
        decoration: const InputDecoration.collapsed(hintText: ''),
      ),
    );
  }
}
