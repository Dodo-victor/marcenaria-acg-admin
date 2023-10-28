import '../models/merchandise_model.dart';

class FirestoreMethods {

  final FirebaseFirestore db = FirebaseFirestore.instance;

setAndCreateMercadory() async {

  final uid = const Uuid().v4();

  final MerchandiseModel pruduct = MerchandiseModel(
      price: "35.000,00kz",
      name: 'Mesa Orval',
      descr: "Mesa feita pelo fredh faça já á sua solicitaçã ",
      photoUrl:
      "https://www.decoracoesmoveis.com.br/media/catalog/product/cache/1/image/800x/9df78eab33525d08d6e5fb8d27136e95/p/_/p_g_28.jpg",
      id: uid,
      hasRequest: false,
      size: '5m x 2,10cm',
      woodType: 'MUSIVI');

  await db
      .collection("marçenaria")
      .doc(mercadoryDoc)
      .collection(mercadoryCollection)
      .doc(uid)
      .set(pruduct.toMap());

  


}


}