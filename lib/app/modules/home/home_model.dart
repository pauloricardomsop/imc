// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:benefits_brazil/app/modules/bf/bf_home_page.dart';
import 'package:benefits_brazil/app/modules/vale_gas/vale_gas_home_page.dart';
import 'package:flutter/material.dart';

class HomeItem {
  final String url;
  final String label;
  final Widget page;
  HomeItem({
    required this.url,
    required this.label,
    required this.page,
  });

  static List<HomeItem> values = [
    HomeItem(
      url: 'https://ldcapps.com/wp-content/uploads/2023/03/o-que-e-o-bolsa-familia.png',
      label: 'Bolsa Família',
      page: const BfHomePage(),
    ),
    HomeItem(
      url: 'https://ldcapps.com/wp-content/uploads/2023/03/logo-valegas.png',
      label: 'Vale Gás',
      page: const ValeGasHomePage(),
    ),
    // HomeItem(
    //   url:
    //       'https://www.aplicaplacaspersonalizadas.com.br/uploads/img/550/placa-sinalizacao-cuidado-area-de-teste-9e8ab87cf00f1eba23f4f4103251680a.jpg',
    //   label: 'Auxílio Brasil',
    //   page: const BfHomePage(),
    // ),
  ];
}
