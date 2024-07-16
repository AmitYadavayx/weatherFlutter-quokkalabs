import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:weather_app/network_manager/api_response.dart';
import 'package:weather_app/screens/home/home_screen.dart';
import 'package:weather_app/utils/urls.dart';

import '../../custom_widgets/custom_text.dart';
import '../../models/home_model.dart';
import '../../network_manager/network_manager.dart';

class ControllerHome extends GetxController {
  ApiResponse<HomeModel> apiResponse=ApiResponse(status: Status.LOADING);
  HomeModel? homeModel;
  List list=["Delhi","Mumbai","Chennai","Bhopal","Bengal"];
  List listLatLong=["28.487147/77.524217","19.097750734681075/72.88254138989018","13.02874288621144/80.20761981806295","23.218887263017873/77.39900746759339","23.889938975766285/90.17535036985608"];
  String selectedItem = "Delhi";


  @override
  void onInit() {
    super.onInit();
    fetchData();
  }
  fetchData() async {
    try{
      if(dummy.value){
        homeModel=HomeModel(name: "Delhi ",weather:[Weather(description: "Rain",main: "Rain")],visibility: 1000,main: Main(feelsLike: 100,grndLevel: 100,humidity: 32,pressure: 34,seaLevel: 324,temp: 32,tempMax: 34,tempMin: 54),clouds: Clouds(all: 34),sys: Sys(country: "India",sunrise: 23423,sunset: 23432),wind: Wind(deg: 23,speed: 234));
      }else{
        var res=await httpGet(Urls.city+selectedItem);
        print(res);
        homeModel=HomeModel.fromJson(res);
      }
      apiResponse=ApiResponse(status: Status.COMPLETED,data: homeModel,message: "Data fetched successful");
    }catch(e){
      apiResponse=ApiResponse(status: Status.ERROR,message: "$e");
    }
    update();
  }

}