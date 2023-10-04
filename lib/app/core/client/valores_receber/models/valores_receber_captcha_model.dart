class ValoresReceberCaptcha {
  String? imagemBase64;
  String? hash;

  ValoresReceberCaptcha({this.imagemBase64, this.hash});

  ValoresReceberCaptcha.fromJson(Map<String, dynamic> json) {
    imagemBase64 = json['imagemBase64'];
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imagemBase64'] = imagemBase64;
    data['hash'] = hash;
    return data;
  }
}
