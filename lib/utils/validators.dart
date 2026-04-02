import '../constants/app_strings.dart';

class Validators {
  Validators._();

  static String? email(String? value) {
    if (value?.isEmpty ?? true) return AppStrings.requiredField;
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) return AppStrings.invalidEmail;
    return null;
  }

  static String? password(String? value, {int minLength = 8}) {
    if (value?.isEmpty ?? true) return AppStrings.requiredField;
    if (value!.length < minLength) return AppStrings.passwordTooShort;
    return null;
  }

  static String? required(String? value, {String? fieldName}) {
    if (value?.isEmpty ?? true) return fieldName != null ? '$fieldName is required' : AppStrings.requiredField;
    return null;
  }

  static String? phone(String? value) {
    if (value?.isEmpty ?? true) return AppStrings.requiredField;
    if (!RegExp(r'^\+?[1-9]\d{1,14}$').hasMatch(value!.replaceAll(RegExp(r'[\s-]'), ''))) return AppStrings.invalidPhone;
    return null;
  }

  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value?.isEmpty ?? true) return fieldName != null ? '$fieldName is required' : AppStrings.requiredField;
    if (value!.length < min) return '${fieldName ?? 'Field'} must be at least $min characters';
    return null;
  }

  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value != null && value.length > max) return '${fieldName ?? 'Field'} must not exceed $max characters';
    return null;
  }

  static String? numeric(String? value) {
    if (value?.isEmpty ?? true) return AppStrings.requiredField;
    if (double.tryParse(value!) == null) return 'Please enter a valid number';
    return null;
  }
}
