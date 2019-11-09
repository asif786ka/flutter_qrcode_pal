class History {
  String type, data;

  static History fromMap(data) {
    return History()
      ..type = data["type"]
      ..data = data["data"];
  }

  toMap() {
    return {
      "type": type,
      "data": data,
    };
  }
}
