import 'package:flutter/material.dart';
import 'local.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final PaymentService paymentService = PaymentService();
  final TextEditingController paymentController = TextEditingController();

  @override
  void dispose() {
    // Dispose the controller when the widget is disposed
    paymentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: paymentController,
              keyboardType: TextInputType.number, // Yalnız rəqəmlər daxil edilsin
              decoration: InputDecoration(
                hintText: 'Enter payment amount',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Ödəniş məbləğini text field-dən alın
                final paymentAmount = double.tryParse(paymentController.text) ?? 0;
                // Ödənişi göndər
                await paymentService.savePayment(paymentAmount.toInt());
              },
              child: Text('Make Payment'),
            ),
          ],
        ),
      ),
    );
  }
}
