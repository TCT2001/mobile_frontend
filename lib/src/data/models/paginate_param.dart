class PaginateParam {
  int page;
  late String? sortField = "updateTime";
  late bool? sortAscending = true;
  late String? filter = "";

  PaginateParam({required this.page});

  PaginateParam.sortByCreateTime({required this.page});

  Map<String, dynamic>? toJson() {
    Map<String, dynamic>? map = {};
    map['page'] = page;
    if (sortField != null) {
      map['sortField'] = sortField;
    }
    if (sortAscending != null) {
      map['sortAscending'] = sortAscending;
    }

    if (filter != "") {
      map['filter'] = filter;
    }
    return map;
  }
}
