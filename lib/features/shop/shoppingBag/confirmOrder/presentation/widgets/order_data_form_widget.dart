import 'package:reactive_forms/reactive_forms.dart';

class OrderDataFormController {
  final group = FormGroup(
    {
      'address_id': FormControl<int>(),
      'address': FormControl<String>(
        validators: [Validators.required],
      ),
      'district': FormControl<dynamic>(),
      'city_name': FormControl<String>(
        validators: [Validators.required],
      ),
      'shipping_method_id': FormControl<int>(
        validators: [Validators.required],
      ),
      'shipping_price': FormControl<num>(),
      'payment_method': FormControl<int>(
        validators: [Validators.required],
      ),
    },
  );

  void reset() {
    group.reset();
  }
}
