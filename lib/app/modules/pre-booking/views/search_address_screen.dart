import 'dart:convert';
import 'dart:developer';

import 'package:flutter/Material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:me_car_customer/app/model/data_search_model.dart';
import 'package:me_car_customer/app/modules/map-explore/controllers/map_explore_controller.dart';
import 'package:me_car_customer/app/modules/pre-booking/controllers/pre_booking_controller.dart';
import 'package:me_car_customer/app/resources/assets_manager.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';
import 'package:me_car_customer/app/resources/text_style.dart';

class SearchAddressPreBooking extends StatefulWidget {
  SearchAddressPreBooking({
    super.key,
  });

  @override
  State<SearchAddressPreBooking> createState() =>
      _SearchAddressPreBookingState();
}

class _SearchAddressPreBookingState extends State<SearchAddressPreBooking> {
  final PreBookingController preBooking = Get.find<PreBookingController>();
  bool isWaitting = false;
  bool isChoose = false;
  List<DataSearchModel> listLocation = [];
  String apiKey = "PWunup1r6WKIVOuEJcS1j9uGxhg5MfPAYF9oySV8";
  String input = "";
  TextEditingController controller = TextEditingController();
  double lat = 0;
  double lng = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (preBooking.textSearch.value.isNotEmpty) {
      controller.text = preBooking.textSearch.value;
    }
  }

  Future<void> fetchData() async {
    setState(() {
      isWaitting = true;
    });
    try {
      var url = Uri.parse(
          "https://rsapi.goong.io/Place/AutoComplete?api_key=${apiKey}&input=${input}");
      final response = await http.get(
        url,
      );
      print("ahaa ${response.statusCode}");
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        Iterable listData = dataRespone["predictions"];

        final mapData = listData.cast<Map<String, dynamic>>();
        listLocation = mapData.map<DataSearchModel>((json) {
          return DataSearchModel.fromJson(json);
        }).toList();
      } else {
        listLocation = [];
        print("haha");
      }
    } catch (e) {
      print(e);
      listLocation = [];
    } finally {
      setState(() {
        isWaitting = false;
      });
    }
  }

  Future<void> fetchAddress() async {
//
    try {
      Get.dialog(
          barrierDismissible: true,
          Scaffold(
            backgroundColor: Colors.black.withOpacity(0.3),
            body: Center(
                child: SizedBox(
                    height: 30,
                    width: 30,
                    child: CircularProgressIndicator(
                      color: ColorsManager.primary,
                    ))),
          ));
      Position curentPosition = await Geolocator.getCurrentPosition();
      var url = Uri.parse(
          "https://rsapi.goong.io/Geocode?latlng=${curentPosition.latitude},%20${curentPosition.longitude}&api_key=${apiKey}");
      final response = await http.get(
        url,
      );

      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        DataSearchModel data = DataSearchModel(
            description: dataRespone["results"][0]["formatted_address"]);
            data.lat =curentPosition.latitude;
            data.lng =curentPosition.longitude;
        preBooking.getResultSearching(data);
        Get.back();
        Get.back();
        // final mapData = listData.cast<Map<String, dynamic>>();
        // listLocation = mapData.map<DataSearchModel>((json) {
        //   return DataSearchModel.fromJson(json);
        // }).toList();
      } else {
        listLocation = [];
        print("haha");
      }
    } catch (e) {
      print(e);
      Get.back();
      listLocation = [];
    } finally {}
    ;
  }

  Future<void> getLatLong(String id) async {
    try {
      var url = Uri.parse(
          "https://rsapi.goong.io/Place/Detail?place_id=${id}&api_key=${apiKey}");
      final response = await http.get(
        url,
      );
      print(response.body);
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        lat = dataRespone["result"]["geometry"]["location"]["lat"].toDouble();
        lng = dataRespone["result"]["geometry"]["location"]["lng"].toDouble();
      } else {}
    } catch (e) {
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: TextFormField(
            autofocus: true,
            controller: controller,
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Nhập vị trí",
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800]),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.grey[800],
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    input = "";
                    controller.text = "";
                  });
                },
              ),
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) async {
              setState(() {
                isWaitting = true;
                input = value;
                print(input);
              });
              await fetchData();
            },
            onFieldSubmitted: (value) async {
              setState(() {
                isWaitting = true;
                input = value;
                print(input);
              });
              await fetchData();
            },
          ),
        ),
        backgroundColor: ColorsManager.primary,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(border: Border(bottom: BorderSide())),
            child: GestureDetector(
              onTap: () async {
                await fetchAddress();
              },
              child: Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 20),
                      child: Icon(
                        Icons.location_on_outlined,
                        color: ColorsManager.primary,
                      )),
                  Text(
                    'Chọn vị trí hiện tại của tôi',
                    style: TextStyleConstant.black16RobotoBold,
                  ),
                ],
              ),
            ),
          ),
          // suggestion text
          isWaitting
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: ColorsManager.primary,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: listLocation.isEmpty
                      ? SizedBox.shrink()
                      : ListView.separated(
                          padding: EdgeInsets.all(10),
                          itemCount: listLocation.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async {
                                await getLatLong(listLocation[index].placeId!);
                                listLocation[index].lat = lat;
                                listLocation[index].lng = lng;
                                preBooking
                                    .getResultSearching(listLocation[index]);
                                Get.back();
                              },
                              leading: Icon(
                                Icons.location_on_outlined,
                                color: ColorsManager.primary,
                              ),
                              title: Text(listLocation[index]
                                  .structuredFormatting!
                                  .mainText),
                              subtitle: Text(listLocation[index]
                                  .structuredFormatting!
                                  .secondaryText),
                            );
                          },
                        ))
        ],
      ),
    );
  }
}
