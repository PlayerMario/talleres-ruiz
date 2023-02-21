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