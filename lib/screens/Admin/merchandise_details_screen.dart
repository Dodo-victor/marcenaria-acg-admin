// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:acg_admin/Resources/firestore_methods.dart';
import 'package:acg_admin/Resources/storage_methods.dart';
import 'package:acg_admin/main.dart';
import 'package:acg_admin/models/merchandise_model.dart';
import 'package:acg_admin/utilis/colors.dart';
import 'package:acg_admin/utilis/pick_image.dart';
import 'package:acg_admin/utilis/showSnackBar.dart';
import 'package:acg_admin/utilis/show_select_image_options.dart';
import 'package:acg_admin/widgets/loader.dart';
import 'package:acg_admin/widgets/submit_button.dart';
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
bool _isEditingSize = true;

bool _isEditting = false;
bool _isDeleting = false;
bool _isUpadtingPic = false;

class MerchandiseDetailsScreenState
    extends ConsumerState<MerchandiseDetailsScreen> {
  final TextEditingController _productnameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _woodController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  //final TextEditingController _Controller = TextEditingController();

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
    _sizeController.text = merchandiseProv.merchandiseModel!.size;
    _descController.text = merchandiseProv.merchandiseModel!.descr!;
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
    Map<Object, Object?>? requestData,
  }) async {
    setState(() {
      _isEditting = true;
    });
    await FirestoreMethods().updateMerchandiseData(context,
        merchandiseDoc: widget.merchandiseDoc,
        merchandiseCollection: widget.merchandiseCollection,
        productId: widget.merchandiseModel.id,
        data: data,
        requestData: requestData);

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
      body: RefreshIndicator(
        color: ColorsApp.primaryTheme,
        onRefresh: () async {
          await merchandisePro.getProductData(
            merchandiseDoc: widget.merchandiseDoc,
            merchandiseCollection: widget.merchandiseCollection,
            productId: widget.merchandiseModel.id,
          );
        },
        child: WillPopScope(
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
              _isDeleting = false;
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
                    onTap: _image != null
                        ? null
                        : () {
                            showSelectImageOption(
                                context: context,
                                selectFromGallery: () {
                                  Navigator.pop(context);
                                  _captureImage(
                                      source: ImageSource.gallery,
                                      context: context);
                                },
                                captureFromcamera: () {
                                  Navigator.pop(context);
                                  _captureImage(
                                      context: context,
                                      source: ImageSource.camera);
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
                          image: _image != null
                              ? DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: MemoryImage(_image!),
                                )
                              : DecorationImage(
                                  fit: BoxFit.fitWidth,
                                  image: NetworkImage(
                                      widget.merchandiseModel.photoUrl),
                                ),
                        ),
                        child: _image != null
                            ? _isUpadtingPic
                                ? const Loader()
                                : InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _isUpadtingPic = true;
                                      });
                                      await StorageMethods().deleteProductImage(
                                          context,
                                          childName: "productImages",
                                          productId:
                                              widget.merchandiseModel.id);
                                      final photoUrl = await StorageMethods()
                                          .saveProductImage(
                                        file: _image!,
                                        context: context,
                                        productId: widget.merchandiseModel.id,
                                        childName: "productImages",
                                      );

                                      await FirestoreMethods()
                                          .updateMerchandiseData(context,
                                              merchandiseDoc:
                                                  widget.merchandiseDoc,
                                              merchandiseCollection:
                                                  widget.merchandiseCollection,
                                              productId:
                                                  widget.merchandiseModel.id,
                                              data: {
                                            "foto": photoUrl,
                                          });
                                      await merchandisePro.getProductData(
                                          merchandiseDoc: widget.merchandiseDoc,
                                          merchandiseCollection:
                                              widget.merchandiseCollection,
                                          productId:
                                              widget.merchandiseModel.id);
                                      showSnackBar(
                                        content:
                                            "Imagem atualizada com sucesso",
                                        context: context,
                                      );

                                      setState(() {
                                        _isUpadtingPic = false;
                                        _image = null;
                                      });
                                    },
                                    child: Container(
                                      height: 80,
                                      width: 80,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: ColorsApp.primaryTheme,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(Icons.upload),
                                    ),
                                  )
                            : Container(
                                height: 80,
                                width: 80,
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
                        requestData: {
                          "produtoNome": _productnameController.text,
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
                    "Preço*",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black45),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  EdittingField(
                    controller: _priceController,
                    isEditingName: _isEditingPrice,
                    isEditting: _isEditting,
                    color: _isEditingPrice ? null : Colors.grey.shade200,
                    loader: merchandisePro.merchandiseModel?.price == null,
                    updateData: () async {
                      await _updateMerchandiseData(
                        context,
                        data: {"preço": _priceController.text},
                      );
                      setState(() {
                        _isEditingPrice = !_isEditingPrice;
                      });
                    },
                    isEdittingFunc: () {
                      setState(() {
                        _isEditingPrice = !_isEditingPrice;
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
                  const SizedBox(height: 5),
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Medidas*",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black45),
                  ),
                  const SizedBox(height: 5),
                  EdittingField(
                    controller: _sizeController,
                    isEditingName: _isEditingSize,
                    isEditting: _isEditting,
                    color: _isEditingSize ? null : Colors.grey.shade200,
                    loader: merchandisePro.merchandiseModel?.size == null,
                    updateData: () async {
                      await _updateMerchandiseData(
                        context,
                        data: {"medida": _sizeController.text},
                      );
                      setState(() {
                        _isEditingSize = !_isEditingSize;
                      });
                    },
                    isEdittingFunc: () {
                      setState(() {
                        _isEditingSize = !_isEditingSize;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Descrição*",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black45),
                  ),
                  const SizedBox(height: 5),
                  EdittingField(
                    controller: _descController,
                    isEditingName: _isEditingDescr,
                    isExpands: true,
                    minLines: null,
                    maxLines: null,
                    constraints: const BoxConstraints.expand(height: 150),
                    isEditting: _isEditting,
                    color: _isEditingDescr ? null : Colors.grey.shade200,
                    loader: merchandisePro.merchandiseModel?.descr == null,
                    updateData: () async {
                      await _updateMerchandiseData(
                        context,
                        data: {"descrição": _sizeController.text},
                      );
                      setState(() {
                        _isEditingDescr = !_isEditingDescr;
                      });
                    },
                    isEdittingFunc: () {
                      setState(() {
                        _isEditingDescr = !_isEditingDescr;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SubmitButton(
                    title: "Excluir Producto",
                    color: Colors.red,
                    isLoading: _isDeleting,
                    function: () async {
                      setState(() {
                        _isDeleting = true;
                      });
                      try {
                        await StorageMethods().deleteProductImage(context,
                            childName: "productImages",
                            productId: widget.merchandiseModel.id);

                        await merchandisePro.deleteMerchandise(
                          merchandiseDoc: widget.merchandiseDoc,
                          merchandiseCollection: widget.merchandiseCollection,
                          productId: widget.merchandiseModel.id,
                        );
                        //  await FirestoreMethods().

                        showSnackBar(
                          content: "Produto Excluído com sucesso ",
                          context: context,
                        );
                        Navigator.pop(context);

                        setState(() {
                          _isDeleting = false;
                        });
                      } catch (e) {
                        setState(() {
                          _isDeleting = false;
                        });
                        showSnackBar(
                          content:
                              "Ocorreu um erro por favor tente novamente $e",
                          context: context,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
