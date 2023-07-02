class BaseLink {
  static const domain = 'https://project20230606170014.azurewebsites.net/';
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
  static const searchGarage = domain +'api/garage/get-nearby-garages-location';
  static const searchGarageByString = domain +'api/garage/search-garage';
  static const checkTimeAvailble = domain +'api/booking/check-booking';

  
}
