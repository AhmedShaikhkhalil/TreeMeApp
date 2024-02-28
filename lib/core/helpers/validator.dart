class Validator {
  static String? validatePassword(String value) {
    {
      if (value.length < 8) {
        return "Please must be 8 characters your password ";
      } else {
        return null;
      }
    }
  }

  static String? validateConfirmPassword(String value, String input) {
    {
      if (input != value) {
        return "the password is not match ";
      } else {
        return null;
      }
    }
  }

  static String? validateName(String value) {
    if (value.length < 3) {
      return 'Name must be more than 2 charater';
    } else {
      return null;
    }
  }

  static String? validateMobile(String value) {
// Indian Mobile number are of 10 digit only
    if (value.length != 10) {
      return 'Mobile Number must be of 10 digit';
    } else {
      return null;
    }
  }

  static String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter Valid Email';
    } else {
      return null;
    }
  }

  static String? validateStoreNumber(String value) {
// Indian Mobile number are of 10 digit only
    if (value.toString().isEmpty) {
      return 'Store Number must be not empty';
    } else {
      return null;
    }
  }

  static String? validateBusinessAddress(String value) {
// Indian Mobile number are of 10 digit only
    if (value.toString().isEmpty) {
      return 'Business Address must be not empty';
    } else {
      return null;
    }
  }

  static String? validateYearsOfExperience(String value) {
    if (value.toString().isEmpty) {
      return 'Years Of experience must be not empty';
    } else {
      return null;
    }
  }

  static String? validateLocation(String value) {
    if (value.toString().isEmpty) {
      return 'Location must be not empty';
    } else {
      return null;
    }
  }

  static String? validateLicenseNumber(String value) {
    if (value.toString().isEmpty) {
      return 'License must be not empty';
    } else {
      return null;
    }
  }

  static String? validatePrimeNumber(String value) {
    if (value.toString().isEmpty) {
      return 'Prime must be not empty';
    } else {
      return null;
    }
  }

  static String? validateDriverLicenseNumber(String value) {
    if (value.toString().isEmpty) {
      return 'Driver License must be not empty';
    } else {
      return null;
    }
  }

  static String? gstHstNumber(String value) {
    if (value.toString().isEmpty) {
      return 'GST/HST must be not empty';
    } else {
      return null;
    }
  }

  static String? globalPharmanetID(String value) {
    if (value.toString().isEmpty) {
      return 'Global Pharmanet ID must be not empty';
    } else {
      return null;
    }
  }

  static String? validateDelNumber(String value) {
    if (value.toString().isEmpty) {
      return 'Prime must be not empty';
    } else {
      return null;
    }
  }
}
