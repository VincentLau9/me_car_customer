class BaseLink {
  static const domain = 'https://carserviceappservice.azurewebsites.net/';
  static const login = domain + 'api/authentication/login';
  static const register = domain + 'api/authentication/register';
  static String getOTP(String recipientEmail) {
    return domain + 'api/authentication/send-otp/${recipientEmail}';
  }

  static String verifyOTP(String recipientEmail, String otp) {
    return domain + 'api/authentication/validate-otp/${otp}&${recipientEmail}';
  }
  static const create_car = domain+'api/car/create-car';
  static const load_car =domain+ 'api/car/get-user-car';
  static const updateInfo =domain+ 'api/user/update-user';
  static const searchGarage = domain +'api/garage/search-garage-by-location';
  static const searchGarageByString = domain +'api/garage/search-garage';
  static const checkTimeAvailble = domain +'api/booking/check-booking';
  static const REFESH_TOKEN = domain + 'api/authentication/refresh-token-mobile';
  static const GET_SERVICES_GARAGE = domain + 'api/service/filter-service-by-garage/';  
  static const GET_SERVICES_FILTER = domain + 'api/service/get-all-service-list/';
  //
  static const SEARCH_GARAGE_BY_FILTER = domain + 'api/garage/filter-garage-by-date-location-service';
  static const GET_STAFF_GARAGE = domain + 'api/mechanic/get-mechanic-by-garage/';

  static const CHECK_OUT = domain + 'api/booking/get_check_out';
  static const CREATE_BOOKING = domain + 'api/booking/create-booking';
  static const LOADING_BOOKING = domain + 'api/booking/filter-booking-by-overall-status/';
  static const LOADING_BOOKING_DETAIL = domain + 'api/booking/detail-booking-for-customer/';
  static const GET_COUPONS = domain + 'api/coupon/get-garage-coupon-for-customer/';
  static const GET_BOOKING_SERVICE_STATUS = domain + 'api/booking/get-booking-detail-status-by-booking-customer/';

  static const RATTING = domain + '/api/review/create-review';
  static const GET_MACHANIC = domain + 'api/mechanic/get-mechanic-by-booking/';
  static const UPDATE_STATUS = domain + 'api/booking/update-status-booking/';
  static const DETAIL_GARAGE = domain + 'api/garage/detail-garage/';
  static const ACCEPT_BOOKING = domain + 'api/booking/confirm-change-in-booking-detail/';



  //



  //api/coupon/get-garage-coupon-for-customer/1
///api/mechanic/get-mechanic-by-booking/{bookingId}
//api/booking/get-booking-detail-status-by-booking-customer/
  //api/booking/detail-booking-for-customer/


}
