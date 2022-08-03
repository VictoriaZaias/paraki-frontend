import 'package:estacionamento/components/CheckboxCaracteristica.dart';
import 'package:estacionamento/http/CaracteristicaService.dart';
import 'package:estacionamento/models/Caracteristica.dart';
import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'CenteredMessage.dart';

class ListaCaracteristicas extends StatefulWidget {
  var buscar;
  bool isCheckbox;
  final List<Caracteristica>? isChecked;

  ListaCaracteristicas(
    this.buscar, {
    Key? key,
    this.isCheckbox = false,
    this.isChecked,
  }) : super(key: key);

  @override
  State<ListaCaracteristicas> createState() => _ListaCaracteristicasState();
}

class _ListaCaracteristicasState extends State<ListaCaracteristicas> {
  Future<List<Caracteristica>> caracteristicasFuture =
      CaracteristicaService().listarTodasCaracteristicas();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<Caracteristica>>(
          future: widget.buscar,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                if (widget.isCheckbox)
                  return listaEsqueleto(context);
                else
                  return paragrafoEsqueleto(context);
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final caracteristicas = snapshot.data!;
                  return buildCaracteristicas(
                      caracteristicas, widget.isCheckbox);
                }
                return CenteredMessage(
                  'Nenhuma caracteristica encontrada',
                  icon: Icons.block,
                );
            }
            return CenteredMessage('Unknown error');
          }),
    );
  }

  Widget buildCaracteristicas(
      List<Caracteristica> caracteristicas, bool isCheckbox) {
    return ListView.builder(
      //physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: 10),
      itemCount: caracteristicas.length,
      itemBuilder: (context, index) {
        final caracteristica = caracteristicas[index];
        if (isCheckbox) {
          return CheckboxCaracteristica(
            caracteristica: caracteristica,
            isChecked: widget.isChecked!,
          );
        } else {
          return Row(
            children: [
              Text(caracteristica.caracteristica),
            ],
          );
        }
      },
    );
  }

/*
  Widget checkboxCaracteristica(Caracteristica caracteristica, int index) {
    bool checkbox_valor = false;

    return Container(
      width: 325.0,
      height: 45.0,
      child: CheckboxListTile(
        title: Text(caracteristica.caracteristica),
        controlAffinity: ListTileControlAffinity.leading,
        value: checkbox_valor,
        //value: widget.isChecked!.contains(caracteristica.caracteristica),
        onChanged: ((bool? value) {
          setState(() {
            checkbox_valor = value!;
          });
/*
          if (value != null && value) {
            setState(() {
              widget.isChecked!.remove(caracteristica.caracteristica);
            });
          } else {
            setState(() {
              widget.isChecked!.add(caracteristica.caracteristica);
            });
          }*/
        }),
      ),
    );
  }
*/
  Widget paragrafoEsqueleto(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 4,
                    padding: EdgeInsets.symmetric(vertical: 4),
                    spacing: 6,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 14,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 3,
                      maxLength: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget listaEsqueleto(BuildContext context) {
    return SkeletonItem(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: SkeletonParagraph(
                  style: SkeletonParagraphStyle(
                    lines: 4,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    spacing: 15,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 24,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 3,
                      maxLength: MediaQuery.of(context).size.width / 2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
