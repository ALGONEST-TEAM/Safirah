class FloosakPaymentSessionModel {
  final String paymentMethodName;
  final String phoneNumber;
  final int amount;
  final String purchaseId;

  const FloosakPaymentSessionModel({
    required this.paymentMethodName,
    required this.phoneNumber,
    required this.amount,
    required this.purchaseId,
  });

  bool get hasPurchaseId => purchaseId.isNotEmpty;

  Map<String, dynamic> toConfirmJson() {
    return {
      if (purchaseId.isNotEmpty) 'purchase_id': purchaseId,
    };
  }

  factory FloosakPaymentSessionModel.fromJson(
    Map<String, dynamic> json, {
    required String paymentMethodName,
    required String phoneNumber,
    required int amount,
  }) {
    return FloosakPaymentSessionModel(
      paymentMethodName: paymentMethodName,
      phoneNumber: phoneNumber,
      amount: amount,
      purchaseId: json['purchase_id']?.toString() ?? '',
    );
  }

  factory FloosakPaymentSessionModel.empty() {
    return const FloosakPaymentSessionModel(
      paymentMethodName: '',
      phoneNumber: '',
      amount: 0,
      purchaseId: '',
    );
  }
}

