class MerchandiseModel {
  final String id;
  final String price;
  final String? name;
  final String? category;
  final String? descr;
  final String? woodType;
  final String? productName;
  final date;
  final String size;
  //final bool hasRequest;

  final String photoUrl;

  MerchandiseModel(
      {required this.price,
      required this.id,
      this.category,
      this.date,
      this.productName,
      // required this.hasRequest,
      required this.woodType,
      required this.size,
      required this.name,
      required this.descr,
      required this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      "preço": price,
      "id": id,
      "nome": name,
      "tipoMadeira": woodType,
      "medida": size,
      "produtoNome": productName,
      "descrição": descr,
      "data": date,
      // "temSolicitação": hasRequest,
      "foto": photoUrl,
    };
  }

  factory MerchandiseModel.fromMap(map) {
    return MerchandiseModel(
      price: map['preço'] ?? "",
      id: map['id'] ?? "",
      name: map['nome'] ?? "",
      woodType: map['tipoMadeira'] ?? "",
      size: map['medida'] ?? "",
      date: map['data'] ?? "",
      productName: map['produtoNome'] ?? "",
      //  hasRequest: map['temSolicitação'] ?? "",
      descr: map['descrição'] ?? "",
      photoUrl: map['foto'] ?? "",
    );
  }
}
