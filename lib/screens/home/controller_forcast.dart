import 'package:get/get.dart';

import '../../models/forecast_model.dart';
import '../../network_manager/api_response.dart';
import '../../network_manager/network_manager.dart';
import '../../utils/urls.dart';
import 'home_screen.dart';

class ControllerForecast extends GetxController{
  ApiResponse<ForcastModel> apiResponseForcast=ApiResponse(status: Status.LOADING);
  ForcastModel? forecastModel;

  final String latLong;
  ControllerForecast(this.latLong);
  @override
  void onInit() {
    super.onInit();
    fetchForecastData(latLong);
  }
  fetchForecastData(latLong) async {
    try{

      if(dummy.value){
        forecastModel=ForcastModel(list: [
          ListItem(dtTxt: "3pm",main: Main(temp: 42),weather: [Weather(main: "Rain",description: "Light rain")],),
          ListItem(dtTxt: "6pm",main: Main(temp: 34),weather: [Weather(main: "Rain",description: "Light rain")],),
          ListItem(dtTxt: "9pm",main: Main(temp: 30),weather: [Weather(main: "Rain",description: "Heavy rain")],),
        ]);
      }else{
        var res=await httpGet(Urls.fiveDaysForecast+latLong);
        print(res);
        forecastModel=ForcastModel.fromJson(res);
      }

      apiResponseForcast=ApiResponse(status: Status.COMPLETED,data: forecastModel,message: "Data fetched successful");
    }catch(e){
      print(e);
      apiResponseForcast=ApiResponse(status: Status.ERROR,message: "$e");
    }
    update();
  }
}