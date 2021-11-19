class CommonResp {
  late String code;
  late List? data;

  CommonResp({required this.code, required this.data});

  factory CommonResp.fromJson(Map<String, dynamic> json) => CommonResp(
        code: json["code"],
        data: json["data"],
      );

  @override
  String toString() {
    return data.toString();
  }
}
