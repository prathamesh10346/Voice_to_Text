import 'dart:convert';

import 'package:http/http.dart' as http;

String apikey = "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";

class ApiServices {
  static String baseurl = "http://api.openai.com/v1/completions";

  static Map<String, String> header = {
    'Content-Type': 'application/json',
    'Authorzation': 'Bearer $apikey'
  };
  static sendMessage(String? message) async {
    var res = await http.post(
      Uri.parse(baseurl),
      headers: header,
      body: jsonEncode({
        "model": "text-davinci-003",
        "prompt": "$message",
        "max_tokens": 100,
        "temperature": 0,
        "top_p": 1,
        "frequency_penalty": 0.0,
        "presence_penalty": 0.0,
        "stop": [" Human:", " AI:"]
      }),
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
      // print(res.body);
    } else {
      print("Faild to fetch data");
    }
  }
}
