import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';


Future<dynamic> PostAPI(data, url) async{
  final response = await http.post('$url',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json'
      },
      body: json.encode(data)
  );
  print("this is response of Api call $response");
  return json.decode(response.body);
}

