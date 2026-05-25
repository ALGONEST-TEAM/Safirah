
import '../../../shop/myOrders/data/model/order_data_model.dart';
import '../model/payment_request_context_model.dart';

extension BookingPaymentRequestMapper on OrderDataModel {
  PaymentRequestContextModel toPaymentRequest({
    required String initialPhoneNumber,
    required PaymentPhoneValidator phoneValidator,
    PaymentTextBuilder? floosakMinimumAmountErrorBuilder,
    String floosakCountryCode = '967',
    int phoneMaxLength = 9,
  }) {
    return PaymentRequestContextModel(
      extraRequestData: {
        'order': {
          'id': 0,
          'totalPrice': 0,
          'currency': 0,
        },
       // if (customer != null) 'customer': customer!.toJson(),
      },
      initialPhoneNumber: initialPhoneNumber,
      phoneMaxLength: phoneMaxLength,
      showPhoneCounter: false,
      phoneValidator: phoneValidator,
      phoneNumberMapper: (value) => value.trim(),
      floosakTargetPhoneMapper: (value) =>
          '$floosakCountryCode${value.trim()}',
      floosakMinimumAmountErrorBuilder: floosakMinimumAmountErrorBuilder,
    );
  }
}

