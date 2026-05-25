import '../../../../generated/l10n.dart';
import 'payment_methods_model.dart';

class PaySpec {
  final String instruction;
  final String codeLabel;
  final String codeHint;
  final String codeEmptyError;
  final bool requiresAmount;
  final bool requiresPhoneNumber;
  final bool requiresCodeField;
  final bool requiresManualPointNumber;

  const PaySpec({
    required this.instruction,
    required this.codeLabel,
    required this.codeHint,
    required this.codeEmptyError,
    required this.requiresAmount,
    required this.requiresPhoneNumber,
    this.requiresCodeField = true,
    this.requiresManualPointNumber = false,
  });

  PaySpec copyWith({
    String? instruction,
    String? codeLabel,
    String? codeHint,
    String? codeEmptyError,
    bool? requiresAmount,
    bool? requiresPhoneNumber,
    bool? requiresCodeField,
    bool? requiresManualPointNumber,
  }) {
    return PaySpec(
      instruction: instruction ?? this.instruction,
      codeLabel: codeLabel ?? this.codeLabel,
      codeHint: codeHint ?? this.codeHint,
      codeEmptyError: codeEmptyError ?? this.codeEmptyError,
      requiresAmount: requiresAmount ?? this.requiresAmount,
      requiresPhoneNumber: requiresPhoneNumber ?? this.requiresPhoneNumber,
      requiresCodeField: requiresCodeField ?? this.requiresCodeField,
      requiresManualPointNumber:
          requiresManualPointNumber ?? this.requiresManualPointNumber,
    );
  }
}

Map<String, PaySpec> paySpecs = {
  'kuraimi': PaySpec(
    instruction: S.current.payKuraimiInstruction,
    codeLabel: S.current.payKuraimiCodeLabel,
    codeHint: S.current.payKuraimiCodeHint,
    codeEmptyError: S.current.payKuraimiCodeEmptyError,
    requiresAmount: true,
    requiresPhoneNumber: false,
    requiresCodeField: true,
  ),
  'jaib': const PaySpec(
    instruction: 'أدخل كود الشراء المنشأ في تطبيق جيب',
    codeLabel: 'كود الشراء',
    codeHint: 'كود الشراء',
    codeEmptyError: 'يرجى إدخال كود الشراء',
    requiresAmount: false,
    requiresPhoneNumber: true,
    requiresCodeField: true,
  ),
  'jawali': PaySpec(
    instruction: S.current.payJawaliInstruction,
    codeLabel: S.current.payJawaliCodeLabel,
    codeHint: S.current.payJawaliCodeHint,
    codeEmptyError: S.current.payJawaliCodeEmptyError,
    requiresAmount: false,
    requiresPhoneNumber: true,
    requiresCodeField: true,
  ),
  'flousk': const PaySpec(
    instruction:
        'أدخل رقم الهاتف ومبلغ العربون أو أكثر، وبعد نجاح العملية سيتم طلب كود التحقق لإتمام الدفع.',
    codeLabel: '',
    codeHint: '',
    codeEmptyError: '',
    requiresAmount: true,
    requiresPhoneNumber: true,
    requiresCodeField: false,
  ),
  'manual': const PaySpec(
    instruction:
        'قم بالتحويل إلى رقم نقطة الدفع الموضح أدناه، ثم أدخل رقم الحوالة لإتمام عملية الدفع وتأكيد الحجز.',
    codeLabel: 'رقم الحوالة',
    codeHint: 'أدخل رقم الحوالة',
    codeEmptyError: 'يرجى إدخال رقم الحوالة',
    requiresAmount: false,
    requiresPhoneNumber: false,
    requiresCodeField: true,
    requiresManualPointNumber: true,
  ),
};

const Set<String> _jawaliMethodAliases = {
  'jawali',
  'جوالي',
};

const Set<String> _jaibMethodAliases = {
  'جيب',
  'jaib',
};

String normalizePayMethodName(String? value) {
  final normalized = (value ?? '').trim().toLowerCase();
  if (normalized == 'jawali') return 'jawali';
  if (_jaibMethodAliases.contains(normalized)) return 'jaib';
  if (normalized == 'kuraimi') return 'kuraimi';
  if ({'flousk', 'fulosak', 'flosak', 'flousak', 'فلوسك'}
      .contains(normalized)) {
    return 'flousk';
  }
  return normalized;
}

PaySpec? paySpecForMethod(String? value) {
  if (isJaibPayMethod(value)) {
    return paySpecs['jaib'];
  }
  if (isJawaliPayMethod(value)) {
    return paySpecs['jawali'];
  }
  return paySpecs[normalizePayMethodName(value)];
}

PaySpec? paySpecForPaymentMethod(PaymentMethodsModel? method) {
  if (method == null) return null;
  final baseSpec = !method.isConnected
      ? paySpecs['manual']
      : paySpecForMethod(method.name);
  if (baseSpec == null) return null;

  final note = method.note.trim();
  if (note.isEmpty) return baseSpec;

  return baseSpec.copyWith(
    instruction: note,
  );
}

bool isJaibPayMethod(String? value) {
  return _jaibMethodAliases.contains((value ?? '').trim().toLowerCase());
}

bool isJawaliPayMethod(String? value) {
  return _jawaliMethodAliases.contains((value ?? '').trim().toLowerCase());
}

bool isFloosakPayMethod(String? value) {
  return normalizePayMethodName(value) == 'flousk';
}

bool isManualPayMethod(PaymentMethodsModel? method) {
  return method != null && !method.isConnected;
}

