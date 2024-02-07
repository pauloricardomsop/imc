import 'package:flutter/material.dart';
import 'package:svr/app/core/enums/app_page.dart';
import 'package:svr/app/core/models/app_stream.dart';

void changePage(AppPage page) {
  HomeController().pageStream.add(page);
  HomeController()
      .pageController
      .animateToPage(page.index, duration: const Duration(milliseconds: 300), curve: Curves.ease);
}

class HomeController {
  static final HomeController _instance = HomeController._();

  HomeController._();

  factory HomeController() => _instance;

  AppStream<AppPage> pageStream = AppStream<AppPage>.seed(AppPage.calculator);
  AppPage get page => pageStream.value;

  final PageController pageController = PageController();

  Future<void> onClickItemBottomNav(AppPage page) async {
    pageStream.add(page);
    changePage(page);
  }
}
