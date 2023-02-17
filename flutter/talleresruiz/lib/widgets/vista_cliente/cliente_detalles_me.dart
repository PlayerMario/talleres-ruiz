import 'package:flutter/material.dart';
import '../../main.dart';

class ClienteDetallesMe extends StatelessWidget {
  const ClienteDetallesMe({super.key, required this.clienteMe});
  final ClienteMeResponse clienteMe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(clienteMe.nombre!),
        Text(clienteMe.username!),
        Text(clienteMe.dni!)
      ],
    );
  }
}
