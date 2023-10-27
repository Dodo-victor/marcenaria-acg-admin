import 'package:acg_admin/utilis/show_select_image_options.dart';
import 'package:acg_admin/widgets/custom_input.dart';
import 'package:flutter/material.dart';

class AddMerchandiseScreen extends StatefulWidget {
  const AddMerchandiseScreen({Key? key}) : super(key: key);

  @override
  State<AddMerchandiseScreen> createState() => _AddMerchandiseScreenState();
}

class _AddMerchandiseScreenState extends State<AddMerchandiseScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Publicar um produto") ,),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5,),
            const Text(
              "Adicionar mercadoria",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              "Preencha os campos abaixo para colocar uma mercadoria a venda",
              style: TextStyle(color: Colors.black45,

              ),
              textAlign: TextAlign.center,
            ),
            Card(
              color: Colors.grey.shade200,
              child:  Padding(
                padding: EdgeInsets.all(15.0),
                child: Column(
                 // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10,),
                    Container(

                      height: 100,
                      width: 100,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: InkWell(
                        onTap: (){
                          showSelectImageOption(context: context);

                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade400,

                          ),
                          child:  Icon(Icons.camera_alt_rounded, color: Colors.grey.shade100,),
                        ),
                      ),
                    ),
                   const SizedBox(height: 10,),

                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,



                        children: [
                          Text("Nome do produto*", style: TextStyle(color: Colors.black45),),
                          SizedBox(height: 5,),
                          CustomInput(title: "Nome do Produto"),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
