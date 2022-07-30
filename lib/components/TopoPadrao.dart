import 'package:flutter/material.dart';

import 'ActionButton.dart';

class TopoPadrao extends StatelessWidget implements PreferredSizeWidget {
  final String? titulo;

  const TopoPadrao({
    Key? key,
    this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: preferredSize,
      child: AppBar(
        centerTitle: true,
        toolbarHeight: 90.0,
        leadingWidth: 90.0,
        leading: ActionButton(
          simbolo: Icons.arrow_back,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: titulo != null
            ? Text(
                titulo!,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              )
            : null,
      ),
    );
  }
  
  @override
  Size get preferredSize {
    return new Size.fromHeight(95.0);
  }
}
