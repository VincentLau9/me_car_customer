import 'package:get/get.dart';

import '../modules/booking-inprogress/bindings/booking_inprogress_binding.dart';
import '../modules/booking-inprogress/views/booking_inprogress_view.dart';
import '../modules/booking-step/bindings/booking_step_binding.dart';
import '../modules/booking-step/views/booking_step_view.dart';
import '../modules/create-new-car/bindings/create_new_car_binding.dart';
import '../modules/create-new-car/views/create_new_car_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/tab-booking-view/tab_booking_list_view.dart';
import '../modules/home/views/tab-profile-view/tab_profile_view.dart';
import '../modules/list-mycar/bindings/list_mycar_binding.dart';
import '../modules/list-mycar/views/list_mycar_view.dart';
import '../modules/map-explore/bindings/map_explore_binding.dart';
import '../modules/map-explore/views/map_explore_view.dart';
import '../modules/search-garage/bindings/search_garage_binding.dart';
import '../modules/search-garage/views/search_garage_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/start_app/bindings/startt_app_binding.dart';
import '../modules/start_app/views/start_app_view.dart';
import '../modules/tab-booking-list/bindings/tab_booking_list_binding.dart';
import '../modules/update-first-time/bindings/update_firsttime_binding.dart';
import '../modules/update-first-time/views/update_firsttime_view.dart';
import '../modules/welcome_board/bindings/welcome_board_binding.dart';
import '../modules/welcome_board/views/welcome_board_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.START_APP;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.START_APP,
      page: () => const StartAppView(),
      binding: StartAppBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME_BOARD,
      page: () => const WelcomeBoardView(),
      binding: WelcomeBoardBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_FIRSTTIME,
      page: () => const UpdateFirsttimeView(),
      binding: UpdateFirsttimeBinding(),
    ),
    GetPage(
      name: _Paths.CREATE_NEW_CAR,
      page: () => const CreateNewCarView(),
      binding: CreateNewCarBinding(),
    ),
    GetPage(
      name: _Paths.MAP_EXPLORE,
      page: () => const MapExploreView(),
      binding: MapExploreBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_STEP,
      page: () => const BookingStepView(),
      binding: BookingStepBinding(),
    ),
    GetPage(
      name: _Paths.LIST_MYCAR,
      page: () => const ListMycarView(),
      binding: ListMycarBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH_GARAGE,
      page: () => const SearchGarageView(),
      binding: SearchGarageBinding(),
    ),
    GetPage(
      name: _Paths.TAB_BOOKING_LIST,
      page: () => const TabBookingListView(),
      binding: TabBookingListBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_INPROGRESS,
      page: () => const BookingInprogressView(),
      binding: BookingInprogressBinding(),
    ),
  ];
}
