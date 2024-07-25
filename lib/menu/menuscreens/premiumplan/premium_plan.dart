import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mlmdiary/utils/app_colors.dart';
import 'package:mlmdiary/utils/custom_toast.dart';
import 'package:mlmdiary/utils/text_style.dart';
import 'package:mlmdiary/widgets/custom_back_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PremiumPlan extends StatefulWidget {
  const PremiumPlan({super.key});

  @override
  State<PremiumPlan> createState() => _PremiumPlanState();
}

class _PremiumPlanState extends State<PremiumPlan> {
  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    if (kDebugMode) {
      print("Payment Successful: ${response.paymentId}");
    }
    showToastverifedborder('Payment Successful', context);
    // Implement further success logic here
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (kDebugMode) {
      print("Payment Error: ${response.code} - ${response.message}");
    }
    showToasterrorborder('Payment Failed', context);
    // Implement further error logic here
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    if (kDebugMode) {
      print("External Wallet: ${response.walletName}");
    }
  }

  void openCheckout() {
    var options = {
      'key': 'YOUR_RAZORPAY_TEST_KEY', // Replace with your Test Key ID
      'amount': 10, // Amount in paise
      'name': 'Your Company Name',
      'description': 'Premium Plan',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      if (kDebugMode) {
        print("Opening Razorpay Checkout");
      }
      _razorpay.open(options);
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: EdgeInsets.all(size.height * 0.012),
          child: const Align(
            alignment: Alignment.topLeft,
            child: CustomBackButton(),
          ),
        ),
        elevation: 0,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Premium Plan',
              style: textStyleW700(size.width * 0.048, AppColors.blackText),
            ),
          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: openCheckout,
          child: const Text('Buy Premium Plan'),
        ),
      ),
    );
  }
}
