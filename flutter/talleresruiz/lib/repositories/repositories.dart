import 'package:talleresruiz/services/localstorage/localstorage_service.dart';
export './crear_cliente/crear_cliente_repo.dart';
export './exceptions/response_exceptions.dart';
export './log/log_repo.dart';

final headers = {"Content-Type": "application/json;charset=UTF-8"};
//final url = Uri.parse('http://localhost:8080');
final url = Uri.parse('http://10.0.2.2:8080');
late LocalStorageService localStorageService;