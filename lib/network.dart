import 'package:http/http.dart' as http;
import 'dart:convert';

class networkhelper{
  final Uri uri;
  networkhelper(this.uri);
  Future getData() async {
    http.Response res = await http.get(uri);
    if(res.statusCode == 200){
      String data = res.body;
      return jsonDecode(data);
    }else{
      print(res.statusCode);
    }

  }
}