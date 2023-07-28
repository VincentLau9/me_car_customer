import 'dart:convert';

import 'package:flutter/Material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:me_car_customer/app/model/data_search_model.dart';
import 'package:me_car_customer/app/modules/map-explore/controllers/map_explore_controller.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';

class SearchAddressPage extends StatefulWidget {
  SearchAddressPage({
    super.key,
  });

  @override
  State<SearchAddressPage> createState() => _SearchAddressPageState();
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  final MapExploreController mapGetxController =
      Get.find<MapExploreController>();
  bool isWaitting = false;
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
    if (mapGetxController.textSearch.value.isNotEmpty) {
      controller.text = mapGetxController.textSearch.value;
    }
  }

  Future<void> fetchData() async {
    isWaitting = true;
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
        mapGetxController.lat.value = lat;
        lng = dataRespone["result"]["geometry"]["location"]["lng"].toDouble();
        mapGetxController.lng.value = lng;
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
                                mapGetxController.modelSearch.value =
                                    listLocation[index];
                                // mapGetxController.district = listLocation[index].compound.district;
                                mapGetxController.modelSearch.value.lat = lat;
                                mapGetxController.modelSearch.value.lng = lng;
                                mapGetxController.textSearch.value =
                                    listLocation[index].description!;
                                    mapGetxController.updateMapCamera(lat, lng);
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
