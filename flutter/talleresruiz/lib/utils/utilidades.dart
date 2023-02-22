import 'dart:core';
import 'package:intl/intl.dart';
import '../../main.dart';
import 'package:flutter/material.dart';

Citas? obtenerUltimaCitas(List<Citas> listadoCitas) {
  DateTime hoy = DateTime.now();
  DateTime? cercaAntes;
  DateTime? cercaDespues;
  DateTime? ultimaCitaFecha;
  Citas? ultimaCita;

  List<DateTime> listadoFechas = [];
  DateFormat formato = DateFormat("dd-MM-yyyy HH:mm");

  if (listadoCitas.isNotEmpty) {
    for (Citas cita in listadoCitas) {
      listadoFechas.add(formato.parse(cita.fechaHora!));
    }

    for (DateTime fecha in listadoFechas) {
      if (fecha.isBefore(hoy)) {
        if (cercaAntes == null || cercaAntes.isBefore(fecha)) {
          cercaAntes = fecha;
        }
      } else {
        if (cercaDespues == null || cercaDespues.isAfter(fecha)) {
          cercaDespues = fecha;
        }
      }
    }

    if (cercaAntes == null) {
      ultimaCitaFecha = cercaDespues;
    } else if (cercaDespues == null) {
      ultimaCitaFecha = cercaAntes;
    } else {
      if (hoy.difference(cercaAntes).inDays <=
          cercaDespues.difference(hoy).inDays) {
        ultimaCitaFecha = cercaAntes;
      } else {
        ultimaCitaFecha = cercaDespues;
      }
    }

    for (Citas cita in listadoCitas) {
      if (formato.parse(cita.fechaHora!) == ultimaCitaFecha) {
        ultimaCita = cita;
      }
    }

    return ultimaCita!;
  } else {
    return null;
  }
}

void showSnackbar(String msg, BuildContext context) {
  final snack = SnackBar(content: Text(msg));
  ScaffoldMessenger.of(context).showSnackBar(snack);
}

DateTime convertirFecha(String fechaCita) {
  List<String> fechaSplit = fechaCita.split('-');
  List<String> fechaSplit2 = fechaSplit[2].split(' ');
  fechaSplit[2] = fechaSplit2[0];
  fechaSplit.add(fechaSplit2[1]);
  List<String> horaSplit = fechaSplit[3].split(':');
  fechaSplit[3] = horaSplit[0];
  fechaSplit.add(horaSplit[1]);
  DateTime fecha = DateTime(
      int.parse(fechaSplit[2]),
      int.parse(fechaSplit[1]),
      int.parse(fechaSplit[0]),
      int.parse(fechaSplit[3]),
      int.parse(fechaSplit[4]));
  return fecha;
}
