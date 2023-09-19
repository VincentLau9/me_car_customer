import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:me_car_customer/app/api/booking_api.dart';
import 'package:me_car_customer/app/base/base_controller.dart';
import 'package:me_car_customer/app/model/booking-detail.dart';
import 'package:me_car_customer/app/resources/color_manager.dart';

class BookingDetailController extends BaseController {
  //TODO: Implement BookingDetailController
  BookingDetailController({required this.idBooking});
  int idBooking;
  Rx<BookingDetail> bookingDetail = BookingDetail().obs;
  Rx<bool> isLoading = true.obs;
  TextEditingController textEditingController = TextEditingController(text: "");
  final ratting = 4.obs;
  final commentChoice = ''.obs;
  final isTypeComment = false.obs;
  List<String> listStatusString = [
    "Có vấn đề gì sao",
    "Có vấn đề gì sao",
    "Tạm được",
    "Tốt",
    "Tuyệt vời"
  ];
  Map<int, List<String>> listTemplate = {
    1: ["Dịch vụ kém", "Chờ đợi lâu"],
    2: ["Dịch vụ kém", "Chờ đợi lâu"],
    3: ["Dịch vụ ổn", "Cần cải tiến thêm", "Sẽ quay lại"],
    4: ["Garage sạch sẽ", "Làm việc chuyên nghiệp", "Không gian rộng"],
    5: [
      "Tuyệt vời",
      "Dịch vụ chu đáo",
      "Thợ nhiệt tình",
      "Đặt lịch nhanh chóng"
    ]
  };
  @override
  Future<void> onInit() async {
    super.onInit();

    await loadBookingDetail(idBooking);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  createRatting() async {
    var response = await BookingApi.createRatting(
        ratting.value,
        bookingDetail.value.garageId!,
        commentChoice.trim().isNotEmpty
            ? commentChoice + '. ' + textEditingController.text
            : textEditingController.text);
    if (response.statusCode == 200) {
      textEditingController.text = '';
      Get.back();
      Get.snackbar('Thông báo', 'Gửi đánh giá thành công',
          backgroundColor: Colors.green.withOpacity(0.7),
          colorText: Colors.white);
    } else {
      Get.back();
      Get.snackbar('Thông báo', 'Có gì đó không đúng',
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    }
  }

  loadBookingDetail(int id) async {
    try {
      log(idBooking.toString());
      isLoading(true);
      var response = await BookingApi.loadBookingDetail(id);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        bookingDetail.value = BookingDetail.fromJson(data);
      } else {
        throw Error();
      }
      isLoading(false);
    } catch (e) {
      Get.back();
      Get.snackbar("Thông báo", 'Có gì đó không đúng');
    }
  }

  setRatting(double star) {
    ratting(star.floor());
    commentChoice.value = '';
  }
acceptNewBooking (bool isAccept)async{
   
   var response = await BookingApi.acceptNewBooking(idBooking, isAccept);
    if(response.statusCode == 200){
        await loadBookingDetail(idBooking);
    }
}
  Widget statusBooking(
      String status, bool waittingForAccept, BuildContext context) {
    Color color = Colors.amber;
    String text = "";
    if (waittingForAccept) {
      color = Colors.brown;
      text = "Có sự thay đổi";
    } else {
      switch (status) {
        case "Pending":
          color = Colors.amber;
          text = "Sắp tới";
          break;
        case "Canceled":
          color = ColorsManager.colorCancel;
          text = "Đã huỷ";
          break;
        case "CheckIn":
          color = ColorsManager.colorCheckIn;
          text = "Đang xử lý";
          break;
        case "Completed":
          color = ColorsManager.colorDone;
          text = "Hoàn thành";
          break;
        default:
      }
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
          child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      )),
    );
  }

  changeStatus() async {
    Get.back();
    Get.dialog(
        Container(
          height: double.infinity,
          width: double.infinity,
          child: Center(
              child: SizedBox(
            height: 100,
            width: 100,
            child: CircularProgressIndicator(
              color: ColorsManager.primary,
            ),
          )),
        ),
        barrierDismissible: true);
    var response;
    response = await BookingApi.changeStatus(idBooking, 1);
    Get.back();
    if (response.statusCode == 200) {
      await loadBookingDetail(idBooking);
    } else if (response.statusCode == 404) {
      Get.snackbar("Thông báo", jsonDecode(response.body)["title"].toString(),
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    } else {
      Get.snackbar("Thông báo", "Có gì đó không đúng",
          backgroundColor: Colors.red.withOpacity(0.7),
          colorText: Colors.white);
    }
  }
}
