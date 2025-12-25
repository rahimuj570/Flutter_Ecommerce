import 'package:flutter_ecommerce/core/services/network_caller.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    header: {'Content-Type': 'application/json'},
    onUnauthorized: () {},
  );
}
