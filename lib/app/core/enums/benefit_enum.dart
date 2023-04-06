enum Benefit {
  app('Benfícios do Brasil', 'Guia Rápido 2023', 'https://ldcapps.com/wp-content/uploads/2023/03/Icone.png'),
  bf('Bolsa Família', '2023', 'https://ldcapps.com/wp-content/uploads/2023/03/o-que-e-o-bolsa-familia.png'),
  valeGas('Vale Gás', '2023', 'https://ldcapps.com/wp-content/uploads/2023/03/logo-valegas.png'),
  aid('Auxílio Brasil', '2023', '');

  final String name;
  final String desc;
  final String url;

  const Benefit(this.name, this.desc, this.url);
}
