import 'package:flutter/material.dart';

import '../utilis/colors.dart';

class MerchandiseCard extends StatelessWidget {
  final String price;
  final String date;
  final String productName;
  final String photoUrl;
  final EdgeInsets? padding;
  const MerchandiseCard(
      {Key? key,
      required this.price,
      required this.date,
      required this.productName, this.padding, required this.photoUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: ColorsApp.primaryTheme,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsApp.googleSignInColor,
                  borderRadius: BorderRadius.circular(10),
                  image:  DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(photoUrl),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      productName,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black54),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Text(
                      price,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.black54),
                    )
                  ],
                ),
              ),
            ),
            Text(
              date,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
