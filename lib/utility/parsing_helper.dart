String asString(Map<String, dynamic>? json, String key, {String defaultValue = ''}) {
  if (json != null && json.containsKey(key)) {
    final value = json[key];
    if (value is String) {
      return value;
    } else if (value != null) {
      return value.toString(); // In case the value is not a string, but convertible to string
    }
  }
  return defaultValue;
}

int asInt(Map<String, dynamic>? json, String key, {int defaultValue = 0}) {
  if (json != null && json.containsKey(key)) {
    final value = json[key];
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value) ?? defaultValue; // Try parsing string to int
    }
  }
  return defaultValue;
}

bool asBool(Map<String, dynamic>? json, String key, {bool defaultValue = false}) {
  if (json != null && json.containsKey(key)) {
    final value = json[key];
    if (value is bool) {
      return value;
    } else if (value is String) {
      return value.toLowerCase() == 'true'; // Convert string to bool if it's 'true'
    } else if (value is int) {
      return value == 1; // Convert int to bool, treating 1 as true
    }
  }
  return defaultValue;
}

Map<String, dynamic> asMap(Map<String, dynamic>? json, String key, {Map<String, dynamic> defaultValue = const {}}) {
  if (json != null && json.containsKey(key)) {
    final value = json[key];
    if (value is Map<String, dynamic>) {
      return value;
    }
  }
  return defaultValue;
}