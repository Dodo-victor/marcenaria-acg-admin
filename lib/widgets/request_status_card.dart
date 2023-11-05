import 'package:acg_admin/utilis/colors.dart';
import 'package:flutter/material.dart';

class RequestStatusCard extends StatelessWidget {
  final double? radius;
  final EdgeInsets? padding;
  final String clientName;
  final String? productName;
  final String price;
  final String date;

  const RequestStatusCard(
      {Key? key,
      this.radius = 30,
      this.padding,
      required this.clientName,
      this.productName,
      required this.price,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(20),
      child: Row(
        children: [
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  productName ?? "Noting",
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black45),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  price,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.black45),
                ),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: Text(
                date,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.black45),
              ))
        ],
      ),
    );
  }
}
