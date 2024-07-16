import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/urls.dart';

import 'custom_exception.dart';


var header={
  "x-rapidapi-key":"aa2d2b080amshefda4a4cc9da0dcp16eccejsna3bb5e58b96c",
  "accept":"application/json"
};

httpGet(String endPoint) async {
  try{

    var res=await http.get(Uri.parse(Urls.baseUrl+endPoint),headers: header);
    // print(res.body);
    return responseReturn(res);
  }
  on SocketException{
    throw FetchDataException("No internet connected");
  }
}
httpPost(String endPoint,{data}) async {
  try{
    var res=await http.post(Uri.parse(Urls.baseUrl+endPoint),body: data,headers: header);
    print(res.body);
    return responseReturn(res);
  }on SocketException{
    throw FetchDataException("No internet connected");
  }
}


responseReturn(http.Response response){
  switch(response.statusCode){
    case 200:

      return jsonDecode(response.body.toString());
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorizedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException('Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
  }
}