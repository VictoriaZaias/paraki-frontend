import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class CardEstacionamentoEsqueleto extends StatelessWidget {
  const CardEstacionamentoEsqueleto({Key? key}) : super(key: key);

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
                  Image.asset(
                    'assets/images/carro.png',
                    scale: 3,
                  ),
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
                            minLength: MediaQuery.of(context).size.width / 4,
                            maxLength: MediaQuery.of(context).size.width / 2,
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
