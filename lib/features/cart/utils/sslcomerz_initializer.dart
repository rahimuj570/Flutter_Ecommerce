import 'package:flutter_ecommerce/app/sercet_values.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class SslcomerzInitializer {
  Future<void> initSSL(double paymentAmount) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //   ipn_url: "www.ipnurl.com",
        multi_card_name: "visa,master,bkash",
        currency: SSLCurrencyType.BDT,
        product_category: "Digital Product",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: SercetValues.storeId,
        store_passwd: SercetValues.storePass,
        total_amount: paymentAmount,
        tran_id:
            '${DateTime.timestamp().millisecond}${AuthManagement.getUserModel!.id}',
      ),
    );

    await sslcommerz.payNow();
  }
}
