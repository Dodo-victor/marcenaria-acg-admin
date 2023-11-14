import 'package:acg_admin/widgets/loader.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AllClientScreen extends ConsumerWidget {
  AllClientScreen({Key? key}) : super(key: key);

  final userProvider = FutureProvider((ref) async {
    final userData = await FirebaseFirestore.instance
        .collection("usuários")
        .orderBy("nome", descending: true)
        .get();

    return userData;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userData = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clientes"),
      ),
      body: userData.when(data: (data) {
        final length = data.docs.length;

        return ListView.separated(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(20),
          itemBuilder: (context, index) {
            final arrData = data.docs[index];
            return InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    //backgroundColor: Colors.grey.shade200,
                    //  enableDrag: true,
                    elevation: 20,
                    builder: (context) {
                      return Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        height: 250,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Detalhes",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const Divider(),
                          const  SizedBox(height:20 ,),
                            FittedBox(
                              child: Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.shade300,
                                        borderRadius: BorderRadius.circular(20)),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                    RichText(
                                      text:  TextSpan(
                                        text: "Nome: ",
                                        style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text: arrData["nome"],  style: const TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.w600),),
                                          
                                        ]
                                      ),
                                      
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                       RichText(
                                      text:  TextSpan(
                                        text: "Telefone: ",
                                        style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text:arrData["telefone"] == null ||
                                  arrData["telefone"] == ""
                              ? 'Sem número de telefone'
                              : arrData["telefone"], style: const TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.w600),),
                                          
                                        ]
                                      ),
                                      
                                    ),
                                      const SizedBox(
                                      height: 8,
                                    ),
                                       RichText(
                                      text:  TextSpan(
                                        text: "Email: ",
                                        style: const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text: arrData["email"],  style: const TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.w600),),
                                          
                                        ]
                                      ),
                                  
                                      
                                    ),
                                      const SizedBox(
                                      height: 8,
                                    ),
                                       RichText(
                                      text: const  TextSpan(
                                        text: "Cliente desde: ",
                                        style:  TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
                                        children: [
                                          TextSpan(text: "20/05/14",  style:  TextStyle(fontSize: 15, color: Colors.black45, fontWeight: FontWeight.w600),),
                                          
                                        ]
                                      ),
                                      
                                    )
                                    
                                  ]),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(""),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          arrData["nome"],
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(),
                        Text(
                          arrData["telefone"] == null ||
                                  arrData["telefone"] == ""
                              ? 'Sem número de telefone'
                              : arrData["telefone"],
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(color: Colors.black45),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: length,
        );
      }, error: (error, satckTrace) {
        return const Center(
          child: Text(
            "Ups! Ocorreu um erro desconhecido",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black45,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }, loading: () {
        return const Center(
          child: Loader(),
        );
      }),
    );
  }
}
