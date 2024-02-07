import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppScaffold extends StatefulWidget {
  final bool resizeAvoid;
  final Widget body;
  final Widget? bottomNav;
  final Widget? fab;
  final PreferredSizeWidget? appBar;
  final Color background;

  const AppScaffold(
      {Key? key,
      required this.body,
      this.bottomNav,
      this.fab,
      this.resizeAvoid = false,
      this.appBar,
      this.background = Colors.white})
      : super(key: key);

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: widget.background,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness:
            widget.background.computeLuminance() > 0.5 ? Brightness.dark : Brightness.light,
        systemNavigationBarColor: widget.background,
        systemNavigationBarIconBrightness:
            widget.background.computeLuminance() > 0.5 ? Brightness.dark : Brightness.light,
        systemNavigationBarDividerColor: widget.background,
        systemNavigationBarContrastEnforced: true,
      ),
      child: Container(
        color: const Color(0xFFeaeaee),
        child: SafeArea(
          top: true,
          bottom: false,
          child: Scaffold(
              appBar: widget.appBar,
              bottomNavigationBar: widget.bottomNav,
              backgroundColor: widget.background,
              resizeToAvoidBottomInset: widget.resizeAvoid,
              floatingActionButton: widget.fab,
              body: widget.body),
        ),
      ),
    );
  }
}
