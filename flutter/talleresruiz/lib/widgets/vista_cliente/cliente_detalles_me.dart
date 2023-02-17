import 'dart:convert';

import 'package:flutter/material.dart';
import '../../main.dart';

class ClienteDetallesMe extends StatelessWidget {
  const ClienteDetallesMe({super.key, required this.clienteMe});
  final ClienteMeResponse clienteMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(utf8.decode(clienteMe.nombre!.codeUnits)),
        Text(utf8.decode(clienteMe.username!.codeUnits)),
        Text(utf8.decode(clienteMe.dni!.codeUnits)),
      ],
    );
  }
}
