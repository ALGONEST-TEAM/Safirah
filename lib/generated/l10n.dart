// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  // skipped getter for the '--------generalVariables-----------' key

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Clear`
  String get clear {
    return Intl.message('Clear', name: 'clear', desc: '', args: []);
  }

  /// `View more`
  String get viewMore {
    return Intl.message('View more', name: 'viewMore', desc: '', args: []);
  }

  /// `View All`
  String get viewAll {
    return Intl.message('View All', name: 'viewAll', desc: '', args: []);
  }

  /// `All`
  String get all {
    return Intl.message('All', name: 'all', desc: '', args: []);
  }

  /// `Confirm`
  String get confirm {
    return Intl.message('Confirm', name: 'confirm', desc: '', args: []);
  }

  /// `Following`
  String get following {
    return Intl.message('Following', name: 'following', desc: '', args: []);
  }

  /// `Daily new`
  String get dailyNew {
    return Intl.message('Daily new', name: 'dailyNew', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Yes`
  String get yes {
    return Intl.message('Yes', name: 'yes', desc: '', args: []);
  }

  /// `No`
  String get no {
    return Intl.message('No', name: 'no', desc: '', args: []);
  }

  /// `Refresh`
  String get refresh {
    return Intl.message('Refresh', name: 'refresh', desc: '', args: []);
  }

  /// `Copy`
  String get copy {
    return Intl.message('Copy', name: 'copy', desc: '', args: []);
  }

  /// `Sharing`
  String get sharing {
    return Intl.message('Sharing', name: 'sharing', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Rename`
  String get rename {
    return Intl.message('Rename', name: 'rename', desc: '', args: []);
  }

  /// `Skip`
  String get skip {
    return Intl.message('Skip', name: 'skip', desc: '', args: []);
  }

  /// `Click again to exit!`
  String get clickAgainToExit {
    return Intl.message(
      'Click again to exit!',
      name: 'clickAgainToExit',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get readMore {
    return Intl.message('Read more', name: 'readMore', desc: '', args: []);
  }

  /// `Show less`
  String get showLess {
    return Intl.message('Show less', name: 'showLess', desc: '', args: []);
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `(Optional)`
  String get optional {
    return Intl.message('(Optional)', name: 'optional', desc: '', args: []);
  }

  /// `Enter`
  String get enter {
    return Intl.message('Enter', name: 'enter', desc: '', args: []);
  }

  /// `Recent Search`
  String get recent_search {
    return Intl.message(
      'Recent Search',
      name: 'recent_search',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `I understand`
  String get understood {
    return Intl.message('I understand', name: 'understood', desc: '', args: []);
  }

  /// `Welcome`
  String get welcome {
    return Intl.message('Welcome', name: 'welcome', desc: '', args: []);
  }

  /// `Empty`
  String get empty {
    return Intl.message('Empty', name: 'empty', desc: '', args: []);
  }

  /// `Notifications`
  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------bottombar-----------' key

  /// `Home`
  String get home {
    return Intl.message('Home', name: 'home', desc: '', args: []);
  }

  /// `Expectations`
  String get expectations {
    return Intl.message(
      'Expectations',
      name: 'expectations',
      desc: '',
      args: [],
    );
  }

  /// `My orders`
  String get myOrders {
    return Intl.message('My orders', name: 'myOrders', desc: '', args: []);
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Profile`
  String get profile {
    return Intl.message('Profile', name: 'profile', desc: '', args: []);
  }

  // skipped getter for the '--------mainFilter-----------' key

  /// `Sort by`
  String get title {
    return Intl.message('Sort by', name: 'title', desc: '', args: []);
  }

  /// `For you`
  String get forYou {
    return Intl.message('For you', name: 'forYou', desc: '', args: []);
  }

  /// `Best sellers`
  String get mostSold {
    return Intl.message('Best sellers', name: 'mostSold', desc: '', args: []);
  }

  /// `Top rated'`
  String get topRated {
    return Intl.message('Top rated\'', name: 'topRated', desc: '', args: []);
  }

  /// `Highest price`
  String get priceHigh {
    return Intl.message('Highest price', name: 'priceHigh', desc: '', args: []);
  }

  /// `Lowest price`
  String get priceLow {
    return Intl.message('Lowest price', name: 'priceLow', desc: '', args: []);
  }

  /// `Price`
  String get price {
    return Intl.message('Price', name: 'price', desc: '', args: []);
  }

  /// `Filter`
  String get filter {
    return Intl.message('Filter', name: 'filter', desc: '', args: []);
  }

  // skipped getter for the '--------details-----------' key

  /// `Size details`
  String get size_details {
    return Intl.message(
      'Size details',
      name: 'size_details',
      desc: '',
      args: [],
    );
  }

  /// `Shipping details`
  String get shipping_details {
    return Intl.message(
      'Shipping details',
      name: 'shipping_details',
      desc: '',
      args: [],
    );
  }

  /// `Return policy`
  String get return_policy {
    return Intl.message(
      'Return policy',
      name: 'return_policy',
      desc: '',
      args: [],
    );
  }

  /// `Sections`
  String get sections {
    return Intl.message('Sections', name: 'sections', desc: '', args: []);
  }

  /// `Numbers`
  String get numbers {
    return Intl.message('Numbers', name: 'numbers', desc: '', args: []);
  }

  /// `Number`
  String get number {
    return Intl.message('Number', name: 'number', desc: '', args: []);
  }

  /// `Printing on the product`
  String get printingOnTheProduct {
    return Intl.message(
      'Printing on the product',
      name: 'printingOnTheProduct',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '-----------------Trends-----------------' key

  /// `Top Trends`
  String get topTrends {
    return Intl.message('Top Trends', name: 'topTrends', desc: '', args: []);
  }

  /// `Recommended trends for you`
  String get recommendedTrendsForYou {
    return Intl.message(
      'Recommended trends for you',
      name: 'recommendedTrendsForYou',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '-----------------BigOffers-----------------' key

  /// `Big Offers`
  String get bigOffers {
    return Intl.message('Big Offers', name: 'bigOffers', desc: '', args: []);
  }

  // skipped getter for the '-----------------Wishlist--------------------' key

  /// `Wishlist`
  String get wishlist {
    return Intl.message('Wishlist', name: 'wishlist', desc: '', args: []);
  }

  /// `Products`
  String get products {
    return Intl.message('Products', name: 'products', desc: '', args: []);
  }

  /// `List`
  String get list {
    return Intl.message('List', name: 'list', desc: '', args: []);
  }

  /// `You don't have any product in my wishlist`
  String get youDontHaveAnyProductInMyWishlist {
    return Intl.message(
      'You don\'t have any product in my wishlist',
      name: 'youDontHaveAnyProductInMyWishlist',
      desc: '',
      args: [],
    );
  }

  /// `Add to list`
  String get addToList {
    return Intl.message('Add to list', name: 'addToList', desc: '', args: []);
  }

  /// `Shop now`
  String get shopNow {
    return Intl.message('Shop now', name: 'shopNow', desc: '', args: []);
  }

  /// `Are you sure you want to delete these products?`
  String get areYouSureYouWantToDeleteTheseProducts {
    return Intl.message(
      'Are you sure you want to delete these products?',
      name: 'areYouSureYouWantToDeleteTheseProducts',
      desc: '',
      args: [],
    );
  }

  /// `They will also be removed from the lists.`
  String get theyWillAlsoBeRemovedFromTheLists {
    return Intl.message(
      'They will also be removed from the lists.',
      name: 'theyWillAlsoBeRemovedFromTheLists',
      desc: '',
      args: [],
    );
  }

  /// `Create a new list`
  String get createANewList {
    return Intl.message(
      'Create a new list',
      name: 'createANewList',
      desc: '',
      args: [],
    );
  }

  /// `Create a list`
  String get createAList {
    return Intl.message(
      'Create a list',
      name: 'createAList',
      desc: '',
      args: [],
    );
  }

  /// `Goods`
  String get goods {
    return Intl.message('Goods', name: 'goods', desc: '', args: []);
  }

  /// `There are no lists`
  String get thereAreNoLists {
    return Intl.message(
      'There are no lists',
      name: 'thereAreNoLists',
      desc: '',
      args: [],
    );
  }

  /// `A new way to manage your favorite products! You can classify in your own way`
  String get aNewWayToManageYourFavoriteProductsYouCanClassifyInYourOwnWay {
    return Intl.message(
      'A new way to manage your favorite products! You can classify in your own way',
      name: 'aNewWayToManageYourFavoriteProductsYouCanClassifyInYourOwnWay',
      desc: '',
      args: [],
    );
  }

  /// `List name`
  String get listName {
    return Intl.message('List name', name: 'listName', desc: '', args: []);
  }

  /// `Please enter a list name`
  String get pleaseEnterAListName {
    return Intl.message(
      'Please enter a list name',
      name: 'pleaseEnterAListName',
      desc: '',
      args: [],
    );
  }

  /// `Delete list`
  String get deleteList {
    return Intl.message('Delete list', name: 'deleteList', desc: '', args: []);
  }

  /// `Are you sure you want to delete the list?`
  String get areYouSureYouWantToDeleteTheList {
    return Intl.message(
      'Are you sure you want to delete the list?',
      name: 'areYouSureYouWantToDeleteTheList',
      desc: '',
      args: [],
    );
  }

  /// `Copy to list`
  String get copyToList {
    return Intl.message('Copy to list', name: 'copyToList', desc: '', args: []);
  }

  /// `Selection of products`
  String get selectionOfProducts {
    return Intl.message(
      'Selection of products',
      name: 'selectionOfProducts',
      desc: '',
      args: [],
    );
  }

  /// `Add goods`
  String get addGoods {
    return Intl.message('Add goods', name: 'addGoods', desc: '', args: []);
  }

  /// `Products list is empty`
  String get productsListIsEmpty {
    return Intl.message(
      'Products list is empty',
      name: 'productsListIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Add your favorite products to the list by making a selection on the Wish List page or clicking the heart button on the Details page`
  String get addYourFavoriteProducts {
    return Intl.message(
      'Add your favorite products to the list by making a selection on the Wish List page or clicking the heart button on the Details page',
      name: 'addYourFavoriteProducts',
      desc: '',
      args: [],
    );
  }

  /// `Add products`
  String get addProducts {
    return Intl.message(
      'Add products',
      name: 'addProducts',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------cart-----------' key

  /// `Login Required`
  String get loginRequired {
    return Intl.message(
      'Login Required',
      name: 'loginRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please login to continue`
  String get pleaseLoginToContinue {
    return Intl.message(
      'Please login to continue',
      name: 'pleaseLoginToContinue',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCart {
    return Intl.message('Add to cart', name: 'addToCart', desc: '', args: []);
  }

  /// `Payment`
  String get payment {
    return Intl.message('Payment', name: 'payment', desc: '', args: []);
  }

  /// `Please select the products you wish to pay for`
  String get pleaseSelectTheProductsYouWishToPayFor {
    return Intl.message(
      'Please select the products you wish to pay for',
      name: 'pleaseSelectTheProductsYouWishToPayFor',
      desc: '',
      args: [],
    );
  }

  /// `Share My Cart`
  String get shareMyCart {
    return Intl.message(
      'Share My Cart',
      name: 'shareMyCart',
      desc: '',
      args: [],
    );
  }

  /// `More details`
  String get moreDetails {
    return Intl.message(
      'More details',
      name: 'moreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Please select a size`
  String get pleaseSelectASize {
    return Intl.message(
      'Please select a size',
      name: 'pleaseSelectASize',
      desc: '',
      args: [],
    );
  }

  /// `Please select a number`
  String get pleaseSelectANumber {
    return Intl.message(
      'Please select a number',
      name: 'pleaseSelectANumber',
      desc: '',
      args: [],
    );
  }

  /// `Cancel printing`
  String get cancelPrinting {
    return Intl.message(
      'Cancel printing',
      name: 'cancelPrinting',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------confirmOrder-----------' key

  /// `Confirm order`
  String get confirmOrder {
    return Intl.message(
      'Confirm order',
      name: 'confirmOrder',
      desc: '',
      args: [],
    );
  }

  /// `Shipping method`
  String get shippingMethod {
    return Intl.message(
      'Shipping method',
      name: 'shippingMethod',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethod {
    return Intl.message(
      'Payment method',
      name: 'paymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Have a coupon or discount voucher?`
  String get haveACouponOrDiscountVoucher {
    return Intl.message(
      'Have a coupon or discount voucher?',
      name: 'haveACouponOrDiscountVoucher',
      desc: '',
      args: [],
    );
  }

  /// `The total`
  String get theTotal {
    return Intl.message('The total', name: 'theTotal', desc: '', args: []);
  }

  /// `Delivery cost`
  String get deliveryCost {
    return Intl.message(
      'Delivery cost',
      name: 'deliveryCost',
      desc: '',
      args: [],
    );
  }

  /// `Discount`
  String get discountOnBill {
    return Intl.message('Discount', name: 'discountOnBill', desc: '', args: []);
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Please chose a payment method`
  String get pleaseChoseAPaymentMethod {
    return Intl.message(
      'Please chose a payment method',
      name: 'pleaseChoseAPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Please chose a shipping method`
  String get pleaseChoseAShippingMethod {
    return Intl.message(
      'Please chose a shipping method',
      name: 'pleaseChoseAShippingMethod',
      desc: '',
      args: [],
    );
  }

  /// `Recipient's phone number`
  String get recipientsPhoneNumber {
    return Intl.message(
      'Recipient\'s phone number',
      name: 'recipientsPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Address is required`
  String get addressIsRequired {
    return Intl.message(
      'Address is required',
      name: 'addressIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Verify`
  String get verify {
    return Intl.message('Verify', name: 'verify', desc: '', args: []);
  }

  /// `Coupon discount`
  String get couponDiscount {
    return Intl.message(
      'Coupon discount',
      name: 'couponDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Printing price`
  String get printingPrice {
    return Intl.message(
      'Printing price',
      name: 'printingPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter the print description for this product`
  String get enterProductPrintDescription {
    return Intl.message(
      'Enter the print description for this product',
      name: 'enterProductPrintDescription',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the print description for the product`
  String get pleaseEnterProductPrintDescription {
    return Intl.message(
      'Please enter the print description for the product',
      name: 'pleaseEnterProductPrintDescription',
      desc: '',
      args: [],
    );
  }

  /// `Back to home`
  String get backToHome {
    return Intl.message('Back to home', name: 'backToHome', desc: '', args: []);
  }

  /// `Transaction Successful`
  String get transactionSuccessful {
    return Intl.message(
      'Transaction Successful',
      name: 'transactionSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `Your order has been successful placed. Thank you for shopping with us.`
  String get yourOrderHasBeenSuccessfulPlacedThankYouForShoppingWithUs {
    return Intl.message(
      'Your order has been successful placed. Thank you for shopping with us.',
      name: 'yourOrderHasBeenSuccessfulPlacedThankYouForShoppingWithUs',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------address-----------' key

  /// `Address`
  String get address {
    return Intl.message('Address', name: 'address', desc: '', args: []);
  }

  /// `Your address`
  String get yourAddress {
    return Intl.message(
      'Your address',
      name: 'yourAddress',
      desc: '',
      args: [],
    );
  }

  /// `My Addresses`
  String get myAddresses {
    return Intl.message(
      'My Addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Delivery address`
  String get deliveryAddress {
    return Intl.message(
      'Delivery address',
      name: 'deliveryAddress',
      desc: '',
      args: [],
    );
  }

  /// `Add a new address`
  String get addANewAddress {
    return Intl.message(
      'Add a new address',
      name: 'addANewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Edit address`
  String get editAddress {
    return Intl.message(
      'Edit address',
      name: 'editAddress',
      desc: '',
      args: [],
    );
  }

  /// `Confirm address`
  String get confirmAddress {
    return Intl.message(
      'Confirm address',
      name: 'confirmAddress',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this address?`
  String get doYouWantToDeleteThisAddress {
    return Intl.message(
      'Do you want to delete this address?',
      name: 'doYouWantToDeleteThisAddress',
      desc: '',
      args: [],
    );
  }

  /// `The address will be permanently deleted`
  String get theAddressWillBePermanentlyDeleted {
    return Intl.message(
      'The address will be permanently deleted',
      name: 'theAddressWillBePermanentlyDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Your addresses are empty.`
  String get addressesEmpty {
    return Intl.message(
      'Your addresses are empty.',
      name: 'addressesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Please add address.`
  String get pleaseAddAddress {
    return Intl.message(
      'Please add address.',
      name: 'pleaseAddAddress',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get invalidPhoneNumber {
    return Intl.message(
      'Invalid phone number',
      name: 'invalidPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message('City', name: 'city', desc: '', args: []);
  }

  /// `Province`
  String get province {
    return Intl.message('Province', name: 'province', desc: '', args: []);
  }

  /// `Province is required`
  String get provinceIsRequired {
    return Intl.message(
      'Province is required',
      name: 'provinceIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please chose a city`
  String get pleaseChoseACity {
    return Intl.message(
      'Please chose a city',
      name: 'pleaseChoseACity',
      desc: '',
      args: [],
    );
  }

  /// `To specify the area`
  String get toSpecifyTheArea {
    return Intl.message(
      'To specify the area',
      name: 'toSpecifyTheArea',
      desc: '',
      args: [],
    );
  }

  /// `Nearest landmark`
  String get nearestLandmark {
    return Intl.message(
      'Nearest landmark',
      name: 'nearestLandmark',
      desc: '',
      args: [],
    );
  }

  /// `Nearest landmark is required`
  String get nearestLandmarkIsRequired {
    return Intl.message(
      'Nearest landmark is required',
      name: 'nearestLandmarkIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please locate on the map*`
  String get pleaseLocateOnTheMap {
    return Intl.message(
      'Please locate on the map*',
      name: 'pleaseLocateOnTheMap',
      desc: '',
      args: [],
    );
  }

  /// `*Please add a new accurate address to enjoy a unique delivery experience.`
  String get pleaseAddANewAccurateAddressToEnjoyAUniqueDeliveryExperience {
    return Intl.message(
      '*Please add a new accurate address to enjoy a unique delivery experience.',
      name: 'pleaseAddANewAccurateAddressToEnjoyAUniqueDeliveryExperience',
      desc: '',
      args: [],
    );
  }

  /// `The address you entered is not within the delivery range. Please double-check and select the correct address`
  String get theAddressYouEnteredIsNotWithinTheDeliveryRange {
    return Intl.message(
      'The address you entered is not within the delivery range. Please double-check and select the correct address',
      name: 'theAddressYouEnteredIsNotWithinTheDeliveryRange',
      desc: '',
      args: [],
    );
  }

  /// `Confirm leaving the page`
  String get confirmLeavePageTitle {
    return Intl.message(
      'Confirm leaving the page',
      name: 'confirmLeavePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `If you leave this page now, any data you have entered will be lost. Do you want to continue?`
  String get confirmLeavePageDescription {
    return Intl.message(
      'If you leave this page now, any data you have entered will be lost. Do you want to continue?',
      name: 'confirmLeavePageDescription',
      desc: '',
      args: [],
    );
  }

  /// `Continue adding`
  String get confirmLeavePageContinue {
    return Intl.message(
      'Continue adding',
      name: 'confirmLeavePageContinue',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get confirmLeavePageBack {
    return Intl.message(
      'Back',
      name: 'confirmLeavePageBack',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------myOrder-----------' key

  /// `Order`
  String get order {
    return Intl.message('Order', name: 'order', desc: '', args: []);
  }

  /// `All orders`
  String get allOrders {
    return Intl.message('All orders', name: 'allOrders', desc: '', args: []);
  }

  /// `Unpaid`
  String get unpaid {
    return Intl.message('Unpaid', name: 'unpaid', desc: '', args: []);
  }

  /// `Processing`
  String get processing {
    return Intl.message('Processing', name: 'processing', desc: '', args: []);
  }

  /// `On the way`
  String get onTheWay {
    return Intl.message('On the way', name: 'onTheWay', desc: '', args: []);
  }

  /// `Delivered`
  String get delivered {
    return Intl.message('Delivered', name: 'delivered', desc: '', args: []);
  }

  /// `Review`
  String get review {
    return Intl.message('Review', name: 'review', desc: '', args: []);
  }

  /// `Order Details`
  String get orderDetails {
    return Intl.message(
      'Order Details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Request`
  String get request {
    return Intl.message('Request', name: 'request', desc: '', args: []);
  }

  /// `Payment details:`
  String get paymentDetails {
    return Intl.message(
      'Payment details:',
      name: 'paymentDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order number`
  String get orderNumber {
    return Intl.message(
      'Order number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatus {
    return Intl.message(
      'Order Status',
      name: 'orderStatus',
      desc: '',
      args: [],
    );
  }

  /// `Number of Products`
  String get numberOfProducts {
    return Intl.message(
      'Number of Products',
      name: 'numberOfProducts',
      desc: '',
      args: [],
    );
  }

  /// `Opinions`
  String get opinions {
    return Intl.message('Opinions', name: 'opinions', desc: '', args: []);
  }

  /// `Shipping time`
  String get shippingTime {
    return Intl.message(
      'Shipping time',
      name: 'shippingTime',
      desc: '',
      args: [],
    );
  }

  /// `Color`
  String get color {
    return Intl.message('Color', name: 'color', desc: '', args: []);
  }

  /// `Colors`
  String get colors {
    return Intl.message('Colors', name: 'colors', desc: '', args: []);
  }

  /// `Size`
  String get size {
    return Intl.message('Size', name: 'size', desc: '', args: []);
  }

  /// `Size`
  String get size2 {
    return Intl.message('Size', name: 'size2', desc: '', args: []);
  }

  /// `Quantity`
  String get quantity {
    return Intl.message('Quantity', name: 'quantity', desc: '', args: []);
  }

  /// `For unit price`
  String get forUnitPrice {
    return Intl.message(
      'For unit price',
      name: 'forUnitPrice',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------reviews-----------' key

  /// `Evaluations`
  String get evaluations {
    return Intl.message('Evaluations', name: 'evaluations', desc: '', args: []);
  }

  /// `Add Rating`
  String get addRating {
    return Intl.message('Add Rating', name: 'addRating', desc: '', args: []);
  }

  /// `Can you leave your review?`
  String get canYouLeaveYourReview {
    return Intl.message(
      'Can you leave your review?',
      name: 'canYouLeaveYourReview',
      desc: '',
      args: [],
    );
  }

  /// `Does the product size fit well?`
  String get doesTheProductSizeFitWell {
    return Intl.message(
      'Does the product size fit well?',
      name: 'doesTheProductSizeFitWell',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment`
  String get AddAComment {
    return Intl.message(
      'Add a comment',
      name: 'AddAComment',
      desc: '',
      args: [],
    );
  }

  /// `Please add a comment`
  String get pleaseAddAComment {
    return Intl.message(
      'Please add a comment',
      name: 'pleaseAddAComment',
      desc: '',
      args: [],
    );
  }

  /// `Small`
  String get small {
    return Intl.message('Small', name: 'small', desc: '', args: []);
  }

  /// `Appropriate`
  String get appropriate {
    return Intl.message('Appropriate', name: 'appropriate', desc: '', args: []);
  }

  /// `Big`
  String get big {
    return Intl.message('Big', name: 'big', desc: '', args: []);
  }

  /// `Add photos`
  String get addPhotos {
    return Intl.message('Add photos', name: 'addPhotos', desc: '', args: []);
  }

  /// `Take Photo`
  String get takePhoto {
    return Intl.message('Take Photo', name: 'takePhoto', desc: '', args: []);
  }

  /// `Gallery`
  String get gallery {
    return Intl.message('Gallery', name: 'gallery', desc: '', args: []);
  }

  /// `Choose Image Source`
  String get chooseImageSource {
    return Intl.message(
      'Choose Image Source',
      name: 'chooseImageSource',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message('Comments', name: 'comments', desc: '', args: []);
  }

  /// `No reviews for this product.`
  String get noReviewsForThisProduct {
    return Intl.message(
      'No reviews for this product.',
      name: 'noReviewsForThisProduct',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------profile-----------' key

  /// `Currency`
  String get currency {
    return Intl.message('Currency', name: 'currency', desc: '', args: []);
  }

  /// `Personal Information`
  String get personalInfo {
    return Intl.message(
      'Personal Information',
      name: 'personalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `My Leagues`
  String get myLeagues {
    return Intl.message('My Leagues', name: 'myLeagues', desc: '', args: []);
  }

  /// `Settings`
  String get settings {
    return Intl.message('Settings', name: 'settings', desc: '', args: []);
  }

  /// `Policies & FAQs`
  String get faq {
    return Intl.message('Policies & FAQs', name: 'faq', desc: '', args: []);
  }

  /// `Support & Contact Channels`
  String get support {
    return Intl.message(
      'Support & Contact Channels',
      name: 'support',
      desc: '',
      args: [],
    );
  }

  /// `If you encounter an issue or have a suggestion to improve the service, you can contact us through one of the following channels`
  String get supportDescription {
    return Intl.message(
      'If you encounter an issue or have a suggestion to improve the service, you can contact us through one of the following channels',
      name: 'supportDescription',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get addressBook {
    return Intl.message('Address', name: 'addressBook', desc: '', args: []);
  }

  /// `Manage My Account`
  String get manageMyAccount {
    return Intl.message(
      'Manage My Account',
      name: 'manageMyAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `SIGN OUT`
  String get signOut {
    return Intl.message('SIGN OUT', name: 'signOut', desc: '', args: []);
  }

  /// `Do you really want to sign out?`
  String get doYouReallyWantToSignOut {
    return Intl.message(
      'Do you really want to sign out?',
      name: 'doYouReallyWantToSignOut',
      desc: '',
      args: [],
    );
  }

  /// `Application language`
  String get applicationLanguage {
    return Intl.message(
      'Application language',
      name: 'applicationLanguage',
      desc: '',
      args: [],
    );
  }

  /// `Change password`
  String get changePassword {
    return Intl.message(
      'Change password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Delete account`
  String get deleteAccount {
    return Intl.message(
      'Delete account',
      name: 'deleteAccount',
      desc: '',
      args: [],
    );
  }

  /// `Do you really want to delete your account? You will lose all related data.`
  String get deleteAccountConfirmation {
    return Intl.message(
      'Do you really want to delete your account? You will lose all related data.',
      name: 'deleteAccountConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Change currency`
  String get changeCurrency {
    return Intl.message(
      'Change currency',
      name: 'changeCurrency',
      desc: '',
      args: [],
    );
  }

  /// `Change Phone Number`
  String get changePhoneNumber {
    return Intl.message(
      'Change Phone Number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Safirah`
  String get appName {
    return Intl.message('Safirah', name: 'appName', desc: '', args: []);
  }

  /// `Safirah app is specialized in selling sportswear, providing championships and creating leagues. Our goal is to provide distinctive and high-quality service.`
  String get appDescription {
    return Intl.message(
      'Safirah app is specialized in selling sportswear, providing championships and creating leagues. Our goal is to provide distinctive and high-quality service.',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Edit profile`
  String get editProfile {
    return Intl.message(
      'Edit profile',
      name: 'editProfile',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get saveChanges {
    return Intl.message(
      'Save changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Current phone number`
  String get phoneNumberCurrent {
    return Intl.message(
      'Current phone number',
      name: 'phoneNumberCurrent',
      desc: '',
      args: [],
    );
  }

  /// `New phone number`
  String get phoneNumberNew {
    return Intl.message(
      'New phone number',
      name: 'phoneNumberNew',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------user-----------' key

  /// `Create account`
  String get createAccount {
    return Intl.message(
      'Create account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get verificationCode {
    return Intl.message(
      'Verification code',
      name: 'verificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message('Log in', name: 'logIn', desc: '', args: []);
  }

  /// `Continue as guest`
  String get continueAsGuest {
    return Intl.message(
      'Continue as guest',
      name: 'continueAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumber {
    return Intl.message(
      'Phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Enter phone number`
  String get enterPhoneNumber {
    return Intl.message(
      'Enter phone number',
      name: 'enterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Log in to Safirah`
  String get loginTitle {
    return Intl.message(
      'Log in to Safirah',
      name: 'loginTitle',
      desc: '',
      args: [],
    );
  }

  /// `Using phone number`
  String get loginSubTitle {
    return Intl.message(
      'Using phone number',
      name: 'loginSubTitle',
      desc: '',
      args: [],
    );
  }

  /// `Please enter phone number`
  String get pleaseEnterPhoneNumber {
    return Intl.message(
      'Please enter phone number',
      name: 'pleaseEnterPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must start with 7 (Yemen)`
  String get phoneMustStartWith7 {
    return Intl.message(
      'Phone number must start with 7 (Yemen)',
      name: 'phoneMustStartWith7',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must not be less than 9 digits`
  String get phoneMustBe9Digits {
    return Intl.message(
      'Phone number must not be less than 9 digits',
      name: 'phoneMustBe9Digits',
      desc: '',
      args: [],
    );
  }

  /// `Resend code in`
  String get resendCodeIN {
    return Intl.message(
      'Resend code in',
      name: 'resendCodeIN',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message('Resend', name: 'resend', desc: '', args: []);
  }

  /// `Code has been send to`
  String get codeHasBeenSendTo {
    return Intl.message(
      'Code has been send to',
      name: 'codeHasBeenSendTo',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code`
  String get pleaseEnterTheVerificationCode {
    return Intl.message(
      'Please enter the verification code',
      name: 'pleaseEnterTheVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `Create an account in Safirah`
  String get createAccountS {
    return Intl.message(
      'Create an account in Safirah',
      name: 'createAccountS',
      desc: '',
      args: [],
    );
  }

  /// `Register a new account to enjoy all Safirah services`
  String get createAccountDesc {
    return Intl.message(
      'Register a new account to enjoy all Safirah services',
      name: 'createAccountDesc',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Please enter your name`
  String get pleaseEnterYourName {
    return Intl.message(
      'Please enter your name',
      name: 'pleaseEnterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Birth date`
  String get birthDate {
    return Intl.message('Birth date', name: 'birthDate', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  // skipped getter for the '--------success-----------' key

  /// `Account created successfully`
  String get accountCreatedSuccessfully {
    return Intl.message(
      'Account created successfully',
      name: 'accountCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logged in successfully`
  String get loginSuccessful {
    return Intl.message(
      'Logged in successfully',
      name: 'loginSuccessful',
      desc: '',
      args: [],
    );
  }

  /// `The operation was completed successfully`
  String get successfully {
    return Intl.message(
      'The operation was completed successfully',
      name: 'successfully',
      desc: '',
      args: [],
    );
  }

  /// `The password has been changed`
  String get thePasswordHasBeenChanged {
    return Intl.message(
      'The password has been changed',
      name: 'thePasswordHasBeenChanged',
      desc: '',
      args: [],
    );
  }

  /// `Deleted address successfully`
  String get deletedAddressSuccessfully {
    return Intl.message(
      'Deleted address successfully',
      name: 'deletedAddressSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Logout successfully`
  String get logoutSuccessfully {
    return Intl.message(
      'Logout successfully',
      name: 'logoutSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Products have been added to the list`
  String get productsHaveBeenAddedToTheList {
    return Intl.message(
      'Products have been added to the list',
      name: 'productsHaveBeenAddedToTheList',
      desc: '',
      args: [],
    );
  }

  /// `The modification has been completed successfully`
  String get theModificationHasBeenCompletedSuccessfully {
    return Intl.message(
      'The modification has been completed successfully',
      name: 'theModificationHasBeenCompletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `The list has been deleted successfully`
  String get theListHasBeenDeletedSuccessfully {
    return Intl.message(
      'The list has been deleted successfully',
      name: 'theListHasBeenDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Deleted successfully`
  String get deletedSuccessfully {
    return Intl.message(
      'Deleted successfully',
      name: 'deletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `A new list has been created successfully`
  String get aNewListHasBeenCreatedSuccessfully {
    return Intl.message(
      'A new list has been created successfully',
      name: 'aNewListHasBeenCreatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Product added to cart successfully`
  String get productAddedToCartSuccessfully {
    return Intl.message(
      'Product added to cart successfully',
      name: 'productAddedToCartSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Coupon verified successfully`
  String get couponVerificationSuccess {
    return Intl.message(
      'Coupon verified successfully',
      name: 'couponVerificationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Profile updated successfully`
  String get profileUpdatedSuccess {
    return Intl.message(
      'Profile updated successfully',
      name: 'profileUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Phone number changed successfully.`
  String get phoneNumberUpdatedSuccess {
    return Intl.message(
      'Phone number changed successfully.',
      name: 'phoneNumberUpdatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Account deleted successfully.`
  String get accountDeletedSuccess {
    return Intl.message(
      'Account deleted successfully.',
      name: 'accountDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '--------error-----------' key

  /// `Sorry, no internet connection`
  String get network {
    return Intl.message(
      'Sorry, no internet connection',
      name: 'network',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection`
  String get network2 {
    return Intl.message(
      'Check your internet connection',
      name: 'network2',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, there is an internet issue`
  String get timeout {
    return Intl.message(
      'Sorry, there is an internet issue',
      name: 'timeout',
      desc: '',
      args: [],
    );
  }

  /// `Internal server error`
  String get internalServerError {
    return Intl.message(
      'Internal server error',
      name: 'internalServerError',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later or contact support`
  String get internalServerError2 {
    return Intl.message(
      'Please try again later or contact support',
      name: 'internalServerError2',
      desc: '',
      args: [],
    );
  }

  /// `Feature not supported on the server`
  String get notImplemented {
    return Intl.message(
      'Feature not supported on the server',
      name: 'notImplemented',
      desc: '',
      args: [],
    );
  }

  /// `Make sure the app is updated or contact support`
  String get notImplemented2 {
    return Intl.message(
      'Make sure the app is updated or contact support',
      name: 'notImplemented2',
      desc: '',
      args: [],
    );
  }

  /// `Bad gateway`
  String get badGateway {
    return Intl.message('Bad gateway', name: 'badGateway', desc: '', args: []);
  }

  /// `Please try again shortly`
  String get badGateway2 {
    return Intl.message(
      'Please try again shortly',
      name: 'badGateway2',
      desc: '',
      args: [],
    );
  }

  /// `Service unavailable`
  String get serviceUnavailable {
    return Intl.message(
      'Service unavailable',
      name: 'serviceUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later`
  String get serviceUnavailable2 {
    return Intl.message(
      'Please try again later',
      name: 'serviceUnavailable2',
      desc: '',
      args: [],
    );
  }

  /// `Gateway timeout`
  String get gatewayTimeout {
    return Intl.message(
      'Gateway timeout',
      name: 'gatewayTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection or try again later`
  String get gatewayTimeout2 {
    return Intl.message(
      'Check your internet connection or try again later',
      name: 'gatewayTimeout2',
      desc: '',
      args: [],
    );
  }

  /// `HTTP version not supported`
  String get httpVersionNotSupported {
    return Intl.message(
      'HTTP version not supported',
      name: 'httpVersionNotSupported',
      desc: '',
      args: [],
    );
  }

  /// `Please update the app to the latest version`
  String get httpVersionNotSupported2 {
    return Intl.message(
      'Please update the app to the latest version',
      name: 'httpVersionNotSupported2',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get somethingWentWrong {
    return Intl.message(
      'Something went wrong',
      name: 'somethingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `Please try again`
  String get pleaseTryAgain {
    return Intl.message(
      'Please try again',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Unable to reach the server`
  String get cannotReachServer {
    return Intl.message(
      'Unable to reach the server',
      name: 'cannotReachServer',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection or service URL`
  String get checkInternetOrServiceUrl {
    return Intl.message(
      'Check your internet connection or service URL',
      name: 'checkInternetOrServiceUrl',
      desc: '',
      args: [],
    );
  }

  /// `Receiving data timed out`
  String get receiveTimeout {
    return Intl.message(
      'Receiving data timed out',
      name: 'receiveTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Please try again later or reduce the data size`
  String get receiveTimeout2 {
    return Intl.message(
      'Please try again later or reduce the data size',
      name: 'receiveTimeout2',
      desc: '',
      args: [],
    );
  }

  /// `Sending data timed out`
  String get sendTimeout {
    return Intl.message(
      'Sending data timed out',
      name: 'sendTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Check your connection and try again`
  String get sendTimeout2 {
    return Intl.message(
      'Check your connection and try again',
      name: 'sendTimeout2',
      desc: '',
      args: [],
    );
  }

  /// `SSL certificate error`
  String get sslError {
    return Intl.message(
      'SSL certificate error',
      name: 'sslError',
      desc: '',
      args: [],
    );
  }

  /// `Ensure your certificate is configured or try again later`
  String get sslError2 {
    return Intl.message(
      'Ensure your certificate is configured or try again later',
      name: 'sslError2',
      desc: '',
      args: [],
    );
  }

  /// `Request was cancelled`
  String get requestCancelled {
    return Intl.message(
      'Request was cancelled',
      name: 'requestCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Retry if the cancellation was unintentional`
  String get requestCancelled2 {
    return Intl.message(
      'Retry if the cancellation was unintentional',
      name: 'requestCancelled2',
      desc: '',
      args: [],
    );
  }

  /// `Invalid service URL`
  String get invalidApiUrl {
    return Intl.message(
      'Invalid service URL',
      name: 'invalidApiUrl',
      desc: '',
      args: [],
    );
  }

  /// `Check the server address (Base URL) and try again`
  String get invalidApiUrl2 {
    return Intl.message(
      'Check the server address (Base URL) and try again',
      name: 'invalidApiUrl2',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
