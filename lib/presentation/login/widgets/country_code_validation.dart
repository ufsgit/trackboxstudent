class CountryPhoneValidation {
  static Map<String, Map<String, dynamic>> countryPhoneData = {
    'IN': {'minLength': 10, 'maxLength': 10}, // India
    'AE': {'minLength': 9, 'maxLength': 9}, // UAE
    'US': {'minLength': 10, 'maxLength': 10}, // United States
    'UK': {'minLength': 10, 'maxLength': 11}, // United Kingdom
    'IE': {'minLength': 7, 'maxLength': 12}, // Ireland
    'CA': {'minLength': 10, 'maxLength': 10}, // Canada
    'MY': {'minLength': 9, 'maxLength': 10}, // Malaysia
    'NZ': {'minLength': 8, 'maxLength': 10}, // New Zealand
    'AU': {'minLength': 9, 'maxLength': 10}, // Australia
    'DE': {'minLength': 10, 'maxLength': 11}, // Germany
    'PL': {'minLength': 9, 'maxLength': 9}, // Poland
    'PT': {'minLength': 9, 'maxLength': 9}, // Portugal
  };

  static Map<String, dynamic> getPhoneLengthByCountry(String countryCode) {
    return countryPhoneData[countryCode] ?? {'minLength': 10, 'maxLength': 15};
  }
}
