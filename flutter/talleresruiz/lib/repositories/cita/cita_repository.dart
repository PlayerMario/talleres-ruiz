import 'package:injectable/injectable.dart';
import 'package:talleresruiz/config/inyeccion_dependencias.dart';
import 'package:talleresruiz/services/interceptor/interceptor.dart';
import '../../main.dart';

@Order(-1)
@singleton
class CitaRepository {
  late RestAuthenticatedClient _http;

  CitaRepository() {
    _http = getIt<RestAuthenticatedClient>();
  }

  Future<dynamic> getDetallesCita(int id) async {
    String url = "/auth/cita/$id";
    var respone = await _http.get(url);
    return respone;
  }
}
