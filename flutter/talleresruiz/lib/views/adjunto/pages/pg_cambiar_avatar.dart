import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talleresruiz/main.dart';

class CambiarAvatar extends StatefulWidget {
  const CambiarAvatar({super.key, required this.rol});
  final String rol;

  @override
  State<CambiarAvatar> createState() => _CambiarAvatar();
}

class _CambiarAvatar extends State<CambiarAvatar> {
  late File _imagen;
  final fichero = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "NUEVO FICHERO",
              style: TextStyle(
                color: Color.fromRGBO(237, 242, 244, 1),
              ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                  onPressed: () {
                    if (widget.rol == "CLIENTE") {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ProviderClienteHome();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const ProviderAdMecHome();
                      }));
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Color.fromRGBO(237, 242, 244, 1),
                  ));
            }),
            backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
        body: SingleChildScrollView(
            child: Center(
                child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 100, bottom: 30.0),
            child: Center(
              child: SizedBox(
                  width: 500,
                  height: 150,
                  child: Image.asset('assets/images/logo.png')),
            ),
          ),
          Card(
              margin: const EdgeInsets.only(
                  top: 20, left: 20, right: 20, bottom: 20),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(43, 45, 66, 1)),
                  child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                        "Seleccionar archivo",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color.fromRGBO(237, 242, 244, 1)),
                        textAlign: TextAlign.start,
                      )),
                  onPressed: () {
                    _showSelectionDialog(widget.rol, context);
                  })),
        ]))));
  }

  Future selectOrTakePhoto(ImageSource imageSource, String rol) async {
    final pickedFile = await fichero.pickImage(source: imageSource);
    AdjuntoService adjuntoService = GetIt.I.get<AdjuntoService>();
    setState(() {
      if (pickedFile != null) {
        _imagen = File(pickedFile.path);
        adjuntoService.cambiarAvatar(_imagen, context);
      } else {
        print('No se ha seleccionado ningún archivo');
      }
    });
  }

  Future _showSelectionDialog(String rol, BuildContext contexto) async {
    await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Seleccionar fichero'),
            children: <Widget>[
              SimpleDialogOption(
                child: const Text('Desde el almacenamiento'),
                onPressed: () {
                  selectOrTakePhoto(ImageSource.gallery, rol);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: const Text('Tomar una fotografía'),
                onPressed: () {
                  selectOrTakePhoto(ImageSource.camera, rol);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
