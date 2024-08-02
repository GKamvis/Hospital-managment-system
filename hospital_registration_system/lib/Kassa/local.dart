import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  static const _key = 'payment_amount';

  Future<void> savePayment(int amount) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, amount);
  }
  Future<int?> getPayment() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_key);
  }
}
