import 'package:http/http.dart' as http;

class Service {
  static Future<dynamic> consulta(
      String url, String type, Map<String, String>? body) async {
    //print('urlapi: ${Enviroment.apiURL}');
    String urlEndPoint = "https://apuestas-turf.com/api/$url";
    print('url: $urlEndPoint');
    switch (type) {
      case 'get':
        return await http.get(Uri.parse(urlEndPoint));
      //break;

      case 'post':
        return await http.post(Uri.parse(urlEndPoint), body: body);
      //break;

      case 'put':
        return await http.put(Uri.parse(urlEndPoint), body: body);
      //break;

      case 'delete':
        return await http.delete(Uri.parse(urlEndPoint));
      //break;

      default:
        return await http.get(Uri.parse(urlEndPoint));
    }
  }
}
