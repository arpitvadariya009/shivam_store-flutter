import 'package:shivam_stores/core/utils/Strings.dart';

class Validators {
  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.kPleaseentermobilenumber;
    } else if (value.length != 10) {
      return Strings.kMobilenumbermustbeexactly10digits;
    }
    return null;
  }

  static String? validate(String? value, String fieldName) {
    final trimmedValue = value?.trim() ?? '';

    if (trimmedValue.isEmpty) {
      return Strings.kPleaseentera + fieldName.toLowerCase();
    }

    return null;
  }
}
