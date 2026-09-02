class AppURL {
  static String get base => 'https://safirah.store';

  // Primary public host: https://safirah.store
  ///https://dash.jeeey.net
  //https://jeeey-dashboard.najaz.in
  //https://saferah.dev-station.com/api/app
  static String get baseURL => '$base/api/app';

  static String get checkUser => '/auth/check';

  static String get logIn => '/auth/check';

  static String get signUp => '/auth/signup';

  static String get checkOtp => '/auth/check_otp';

  static String get resendOtp => '/auth/update_otp';

  static String get getProfileData => '/profile';

  static String teamMatches(int teamId) => '/predictions/teams/$teamId/matches';

  static String get editProfile => '/profile/update';

  static String get deleteAccount => '/profile/delete_account';

  static String get logout => '/auth/logout';

  static String get changePhoneNumber => '/profile/update_phone_number';

  static String get getDetailsOfProduct => '/products';

  static String get getOfferProducts => '/banners/';

  static String get addresses => '/addresses';

  static String get getCities => '/cities';

  static String get getDistricts => '/districts';

  static String get createAddress => '/addresses/store';

  static String get updateAddress => '/addresses/update';

  static String get deleteAddress => '/addresses/delete';

  static String get getAllCart => '/carts';

  static String get getCartCount => '/carts/count';

  static String get addToCart => '/carts/store';

  static String get updateCart => '/carts/update';

  static String get deleteCart => '/carts/delete';

  static String get confirmOrder => '/orders/store';

  static String get getOrderDate => '/orders/get_order_data';

  static String get orders => '/orders';

  static String get orderDetails => '/orders/show';

  static String get getAllReviews => '/review/product';

  static String get addReview => '/review';

  static String get addLike => '/review/like';

  static String get dislike => '/review/dislike';

  static String get getAllWishesProducts => '/favorite/products';

  static String get addWishlist => '/favorite/store';

  static String get deleteWishlist => '/favorite/delete_favorite_products';

  static String get getAllList => '/favorite/lists_images';

  static String get createAnewListAndAddProducts => '/favorite/store_list';

  static String get renameTheList => '/favorite/update_list';

  static String get deleteList => '/favorite/delete_all_list_products';

  static String get getProductsByList => '/favorite/get_products_by_list';

  static String get deleteListProducts => '/favorite/delete_list_products';

  static String get getAllCurrencies => '/currencies';

  static String get notification => '/notifications';

  static const String unreadNotificationCount = '/notifications/count';

  static const String markNotificationAsRead = '/notifications/mark_as_read';

  static const String getAllMatches = '/predictions/fixtures/current';

  static String matchDetails(int matchId) => '/predictions/fixtures/$matchId/details';

  static String matchStatistics(int matchId, {String? period}) {
    if (period != null && period.trim().isNotEmpty) {
      return '/predictions/fixtures/$matchId/statistics?period=$period';
    }
    return '/predictions/fixtures/$matchId/statistics';
  }

  static String matchStandings(int matchId, {String? scope}) {
    if (scope != null && scope.trim().isNotEmpty) {
      return '/predictions/fixtures/$matchId/standings?scope=$scope';
    }
    return '/predictions/fixtures/$matchId/standings';
  }

  static String matchLineups(int matchId) => '/predictions/fixtures/$matchId/lineup';

  static String matchEvents(int matchId) => '/predictions/fixtures/$matchId/events';

  static String matchH2H(int matchId) => '/predictions/fixtures/$matchId/h2h';

  static const String prediction = '/predictions';
  
  static String competitorPredictions(int id) => '/predictions/competitor/$id';

  static const String standings = '/predictions/rankings';

  static const String awards = '/predictions/awards';

  static const String awardsLegacy = '/predictions/prizes';

  static const String leagueHome = '/league-application/home/main';

  static const String news = '/league-application/news';

  static String get confirmPayment => '/booking/payment';

  static String get startFloosakPayment => '/booking/payment/Flousk/send-money';

  static String get confirmFloosakPayment => '/booking/payment/Flousk/confirm';
  static String get getAllPaymentMethods => '/orders/get_payment-methods';
  static String get getDeliveryType => '/orders/get_delivery_types';

}
