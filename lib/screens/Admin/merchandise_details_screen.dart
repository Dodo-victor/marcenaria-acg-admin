import 'dart:typed_data';

import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/main.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/utilis/pick_image.dart';
import 'package:acg_admin/utilis/show_select_image_options.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/editting_field.dart';

class MerchandiseDetailsScreen extends ConsumerStatefulWidget {
  final MerchandiseModel merchandiseModel;
  final String merchandiseDoc;
  final String merchandiseCollection;
  const MerchandiseDetailsScreen(
      {Key? key,
      required this.merchandiseModel,
      required this.merchandiseDoc,
      required this.merchandiseCollection})
      : super(key: key);

  @override
  MerchandiseDetailsScreenState createState() =>
      MerchandiseDetailsScreenState();
}

Uint8List? _image;
bool _isEditingName = true;
bool _isEditingPrice = true;
bool _isEditingDescr = true;
bool _isEditingWoodType = true;
bool _size = true;

bool _isEditting = false;

class MerchandiseDetailsScreenState
    extends ConsumerState<MerchandiseDetailsScreen> {
  final TextEditingController _productnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _woodController = TextEditingController();

  _getProductData() async {
    /*  final productData = await FirebaseFirestore.instance
        .collection('marçenaria')
        .doc(widget.merchandiseDoc)
        .collection(widget.merchandiseCollection)
        .doc(widget.merchandiseModel.id)
        .get();

    final MerchandiseModel? merchandiseData =
        MerchandiseModel.fromMap(productData);

    if (merchandiseData != null) {
      setState(() {
        _productnameController.text = merchandiseData.name ?? "";
      });
    } */

    final merchandiseProv = ref.read(merchandiseProvider);

    await merchandiseProv.getProductData(
        merchandiseDoc: widget.merchandiseDoc,
        merchandiseCollection: widget.merchandiseCollection,
        productId: widget.merchandiseModel.id);

    _productnameController.text = merchandiseProv.merchandiseModel!.name!;
    _priceController.text = merchandiseProv.merchandiseModel!.price;
    _woodController.text = merchandiseProv.merchandiseModel!.woodType!;
  }

  _captureImage(
      {required ImageSource source, required BuildContext context}) async {
    final image = await captureImage(source: source, context: context);

    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    _getProductData();
    super.initState();
  }

  @override
  void dispose() {
    _productnameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  _updateMerchandiseData(
    context, {
    required Map<Object, Object?> data,
  }) async {
    setState(() {
      _isEditting = true;
    });
    await FirestoreMethods().updateMerchandiseData(context,
        merchandiseDoc: widget.merchandiseDoc,
        merchandiseCollection: widget.merchandiseCollection,
        productId: widget.merchandiseModel.id,
        data: data);

    await ref.read(merchandiseProvider).getProductData(
        merchandiseDoc: widget.merchandiseDoc,
        merchandiseCollection: widget.merchandiseCollection,
        productId: widget.merchandiseModel.id);

    setState(() {
      _isEditting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final merchandisePro = ref.watch(merchandiseProvider);
    return Scaffold(
      appBar: AppBar(
        title: merchandisePro.merchandiseModel?.name == null
            ? Container(
                height: 15,
                width: 40,
                decoration: BoxDecoration(color: Colors.grey.shade300),
              )
            : Text(merchandisePro.merchandiseModel!.name!),
      ),
      body: WillPopScope(
        onWillPop: () async {
          /*  await ref.read(merchandiseProvider).getProductData(
              merchandiseDoc: widget.merchandiseDoc,
              merchandiseCollection: widget.merchandiseCollection,
              productId: widget.merchandiseModel.id); */
          setState(() {
            _image = null;
            _isEditingName = true;
            _isEditingPrice = true;
            _isEditingWoodType = true;
            _isEditingDescr = true;
            _isEditting = false;
          });
          return true;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    showSelectImageOption(
                        context: context,
                        selectFromGallery: () {
                          captureImage(
                              source: ImageSource.gallery, context: context);
                        },
                        captureFromcamera: () {
                          _captureImage(
                              context: context, source: ImageSource.camera);
                        });
                  },
                  child: AspectRatio(
                    aspectRatio: 10 / 7,
                    child: Container(
                      height: 200,
                      width: 400,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ColorsApp.googleSignInColor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(widget.merchandiseModel.photoUrl),
                        ),
                      ),
                      child: _image == null
                          ? null
                          : Container(
                              height: 50,
                              width: 50,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: ColorsApp.primaryTheme,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.camera_alt),
                            ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Nome do Producto*",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black45),
                ),
                const SizedBox(
                  height: 5,
                ),
                EdittingField(
                  controller: _productnameController,
                  isEditingName: _isEditingName,
                  isEditting: _isEditting,
                  color: _isEditingName ? null : Colors.grey.shade200,
                  loader: merchandisePro.merchandiseModel?.name == null,
                  updateData: () async {
                    await _updateMerchandiseData(
                      context,
                      data: {
                        "nome": _productnameController.text,
                      },
                    );
                    setState(() {
                      _isEditingName = !_isEditingName;
                    });
                  },
                  isEdittingFunc: () {
                    setState(() {
                      _isEditingName = !_isEditingName;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Tipo de Madeira*",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black45),
                ),
                const SizedBox(
                  height: 5,
                ),
                EdittingField(
                  controller: _woodController,
                  isEditingName: _isEditingWoodType,
                  isEditting: _isEditting,
                  color: _isEditingWoodType ? null : Colors.grey.shade200,
                  loader: merchandisePro.merchandiseModel?.woodType == null,
                  updateData: () async {
                    await _updateMerchandiseData(
                      context,
                      data: {"tipoMadeira": _woodController.text},
                    );
                    setState(() {
                      _isEditingWoodType = !_isEditingWoodType;
                    });
                  },
                  isEdittingFunc: () {
                    setState(() {
                      _isEditingWoodType = !_isEditingWoodType;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
