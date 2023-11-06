import 'package:acg_admin/models/merchandise_model.dart';

class MarkSellProduct {
  final MerchandiseModel merchandiseModel;

  const MarkSellProduct({required this.merchandiseModel});

  Map<String, dynamic> toMap() {
    return {
      "preço": merchandiseModel.price,
      "id": merchandiseModel.id,
      "nome": merchandiseModel.name,
      "tipoMadeira": merchandiseModel.woodType,
      "medida": merchandiseModel.size,
      "produtoNome": merchandiseModel.productName,
      "descrição": merchandiseModel.descr,
      "data": merchandiseModel.date,
      "foto": merchandiseModel.photoUrl,
    };
  }

  factory MarkSellProduct.fromMap(map) {
    return MarkSellProduct(merchandiseModel: MerchandiseModel.fromMap(map));
  }
}
