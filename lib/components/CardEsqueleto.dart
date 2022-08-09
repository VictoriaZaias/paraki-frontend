import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CardEsqueleto extends StatelessWidget {
  final Widget icone;

  const CardEsqueleto({
    Key? key,
    required this.icone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFFEDE4E2),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: SkeletonItem(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 8),
                  icone,
                  SizedBox(width: 8),
                  Expanded(
                    child: SkeletonParagraph(
                      style: SkeletonParagraphStyle(
                          lines: 4,
                          spacing: 6,
                          lineStyle: SkeletonLineStyle(
                            randomLength: true,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                            minLength: 10 + MediaQuery.of(context).size.width / 4,
                            maxLength: 20 + MediaQuery.of(context).size.width / 2,
                          )),
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
