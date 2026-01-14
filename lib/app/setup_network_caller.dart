import 'package:flutter_ecommerce/core/services/network_caller.dart';
import 'package:flutter_ecommerce/features/auth/utils/auth_management.dart';

NetworkCaller getNetworkCaller() {
  return NetworkCaller(
    header: {
      'Content-Type': 'application/json',
      'token': AuthManagement.getToken ?? '',
    },
    onUnauthorized: () {},
  );
}
