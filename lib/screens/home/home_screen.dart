import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather_app/app_theme/app_paddings.dart';
import 'package:weather_app/common/loading_widget.dart';
import 'package:weather_app/common/no_data_widget.dart';
import 'package:weather_app/common/something_went_wrong_widget.dart';
import 'package:weather_app/custom_widgets/app_bar_common.dart';
import 'package:weather_app/custom_widgets/custom_text.dart';
import 'package:weather_app/screens/home/controller_forcast.dart';
import 'package:weather_app/utils/app_images.dart';

import '../../network_manager/api_response.dart';
import 'controller_home.dart';

RxBool dummy=true.obs;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final RefreshController refreshController=RefreshController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder(init: ControllerHome(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBarCommon(backgroundColor: Colors.blue,title: Obx(() => Center(
              child: Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeadingText("Dummy ${dummy.value?"ON":"OFF"}  ",color: Colors.white,),
                  Switch(value: dummy.value, onChanged: (onChanged){
                    dummy.value=onChanged;
                  }),
                ],
              ),
            )),),
            body: controller.apiResponse.status==Status.LOADING? LoadingWidget(center: true,):
            controller.apiResponse.status==Status.ERROR? SomethingWentWrongWidget(center: true,msg: controller.apiResponse.message,retry: (){
              controller.apiResponse=ApiResponse(status: Status.LOADING);
              controller.update();
              controller.fetchData();
              },):
            controller.apiResponse.data==null? NoDataWidget(center: true,):
            SmartRefresher(controller: refreshController,onRefresh: refreshData,
              child: SingleChildScrollView(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                  Container(color: Colors.blue,child: Padding(
                    padding: AppPaddings.paddingAll16,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Align(alignment: Alignment.topRight,child: Image.asset(AppImages.rain,height: 150,width: 150,)),
                        ),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,children: [
                          SizedBox(height: 48,),
                          Row(
                            children: [
                              DropdownButton(dropdownColor: Colors.blue,underline: SizedBox(),iconEnabledColor: Colors.white,
                                items:controller.list.map((e) => DropdownMenuItem(value: e,child: NormalHeadingText(e,color: Colors.white,),)).toList(),

                                onChanged: (onChanged){
                                controller.selectedItem=onChanged.toString();
                                refreshData();
                                },value: controller.selectedItem,)
                            ],
                          ),
                          BigText("${controller.homeModel!.main!.temp} *C",fontSize: 48,color: Colors.white,),
                          Row(
                            children: [
                              Icon(Icons.thermostat,color: Colors.white,),
                              SmallText("Feels Like: ${controller.homeModel!.main!.feelsLike}",color: Colors.white,),
                            ],
                          ),
                          SizedBox(height: 16,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Image.asset(AppImages.minTemperature,height: 20,width: 20,),
                                SmallText("Min temp",color: Colors.white,),
                                SmallText("${controller.homeModel!.main!.tempMin}",color: Colors.white,fontWeight: FontWeight.w800,)
                              ],),

                              Column(children: [
                                Image.asset(AppImages.maxTemperature,height: 20,width: 20,),
                                SmallText("Max temp",color: Colors.white,),
                                SmallText("${controller.homeModel!.main!.tempMax}",color: Colors.white,fontWeight: FontWeight.w800,)
                              ],),

                              Column(children: [
                                Image.asset(AppImages.pressure,height: 20,width: 20,color: Colors.white,),
                                SmallText("Pressure",color: Colors.white,),
                                SmallText("${controller.homeModel!.main!.pressure}",color: Colors.white,fontWeight: FontWeight.w800,)
                              ],),


                            ],
                          ),
                          SizedBox(height: 16,),
                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(children: [
                                Image.asset(AppImages.humidity,height: 20,width: 20,),
                                SmallText("Humidity",color: Colors.white,),
                                SmallText("${controller.homeModel!.main!.humidity}",color: Colors.white,fontWeight: FontWeight.w800,)
                              ],),

                              Column(children: [
                                Image.asset(AppImages.seaLevel,height: 20,width: 20,),
                                SmallText("Sea Level",color: Colors.white,),
                                SmallText("${controller.homeModel!.main!.seaLevel}",color: Colors.white,fontWeight: FontWeight.w800)
                              ],),

                              Column(children: [
                                Image.asset(AppImages.groundLevel,height: 20,width: 20,),
                                SmallText("Ground Level",color: Colors.white,),
                                SmallText("${controller.homeModel!.main!.grndLevel}",color: Colors.white,fontWeight: FontWeight.w800)
                              ],),


                            ],
                          ),
                          SizedBox(height: 24,),

                        ],),

                      ],
                    ),
                  ),),
                  // Text(controller.apiResponse.data!.weather!.first.main!),
                  // Text(controller.apiResponse.data!.weather!.first.description!),

                  SizedBox(height: 16,),
                  GridView(physics: NeverScrollableScrollPhysics(),padding: AppPaddings.paddingAll8,shrinkWrap: true,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 16,crossAxisSpacing: 16),children: [
                    customContainer(AppImages.maxTemperature, "Wind speed", "${controller.homeModel!.wind!.speed} mph"),
                    customContainer(AppImages.windDirection, "Wind degree", "${controller.homeModel!.wind!.deg} degree"),
                    customContainer(AppImages.clouds, "Clouds", "${controller.homeModel!.clouds!.all}"),
                    customContainer(AppImages.sunrise, "Sunrise", "${controller.homeModel!.sys!.sunrise}"),
                    customContainer(AppImages.sunrise, "Sunset", "${controller.homeModel!.sys!.sunset}"),
                    customContainer(AppImages.sunrise, "Visibilty", "${controller.homeModel!.visibility}"),

                  ],),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0,bottom: 16),
                    child: BigText("Weather Forecast"),
                  ),
                  GetBuilder(init: ControllerForecast(controller.listLatLong[controller.list.indexOf(controller.selectedItem)]),builder: (controllerForecast){
                    return controllerForecast.apiResponseForcast.status==Status.LOADING?LoadingWidget(center: true,):
                    controllerForecast.apiResponseForcast.status==Status.ERROR?SomethingWentWrongWidget(center: true,):
                    controllerForecast.apiResponseForcast.data==null?NoDataWidget(center: true,):
                    SizedBox(height: 150,
                        child: ListView.builder(scrollDirection: Axis.horizontal,itemCount: controllerForecast.forecastModel!.list!.length,itemBuilder: (itemBuilder,index){
                          return
                            Container(margin: EdgeInsets.only(left: 16,right: 8),width: 150,padding: EdgeInsets.all(16),decoration: BoxDecoration(color: Colors.blue.shade100.withOpacity(.2),borderRadius: BorderRadius.circular(10)),
                                child: Column(children: [
                                  Image.asset(index==2?AppImages.rain:AppImages.heavyRain,height: 40,width: 40,),
                                  SizedBox(height: 4,),
                                  SmallText("${controllerForecast.forecastModel!.list![index].dtTxt}"),
                                  SmallText("${controllerForecast.forecastModel!.list![index].weather!.first.main}",fontWeight: FontWeight.w600,),
                                  SmallText("${controllerForecast.forecastModel!.list![index].weather!.first.description}"),

                                  SmallText("${controllerForecast.forecastModel!.list![index].main!.temp} *C",fontWeight: FontWeight.w800,),
                                ],));
                        })
                    );
                  }),

                  SizedBox(height: 100,)
                ],),
              ),
            )
          );
        }
    );
  }
  Widget customContainer(image,heading,text){
    return Container(padding: EdgeInsets.all(16),decoration: BoxDecoration(color: Colors.grey.shade100,borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Image.asset(image,height: 40,width: 40,),
        SizedBox(height: 4,),
        SmallText(heading,),
        SmallText(text,fontWeight: FontWeight.w800,)
      ],),
    );
  }
  refreshData(){
    ControllerHome controllerHome=Get.find<ControllerHome>();
    ControllerForecast controllerForecast=Get.find<ControllerForecast>();
    controllerHome.apiResponse=ApiResponse(status: Status.LOADING);
    controllerForecast.apiResponseForcast=ApiResponse(status: Status.LOADING);
    controllerHome.update();
    controllerForecast.update();

    Future.delayed(Duration(seconds: dummy.value?1:0)).then((value){
      refreshController.refreshCompleted();
      controllerHome.fetchData();
      controllerForecast.fetchForecastData(controllerHome.listLatLong[controllerHome.list.indexOf(controllerHome.selectedItem)]);
    });
  }
}
