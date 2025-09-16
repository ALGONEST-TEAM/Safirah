class AppURL {
  static String get base => 'https://dash-jeeey.dev-station.com';

  //https://saferah.dev-station.com
  ///https://dash.jeeey.net
  //https://jeeey-dashboard.najaz.in
  //https://dash-jeeey.dev-station.com
  static String get baseURL => '$base/api/app';

  static String get checkUser => '/auth/check';

  static String get logIn => '/auth/check';

  static String get signUp => '/auth/signup';

  static String get checkOtp => '/auth/check_otp';

  static String get resendOtp => '/auth/update_otp';

  static String get logout => '/auth/logout';

  static String get addresses => '/addresses';

  static String get getCities => '/cities';

  static String get getDistricts => '/districts';

  static String get createAddress => '/addresses/store';

  static String get updateAddress => '/addresses/update';

  static String get deleteAddress => '/addresses/delete';

  static String get getAllCart => '/carts';

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

  static String get getAllCopon => '/coupons';

  static String get getProductCopon => '/coupons';

  static String get checkCoupon => '/coupons/check_coupon';

  static String get updateFCMToken => '/auth/store_fcm_token';

  static String get getCartId => '/carts/cart_id/by_fcm_token';
}
