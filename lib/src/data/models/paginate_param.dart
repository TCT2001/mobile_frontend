class PaginateParam {
  int page;
  late String? sortField = "";
  late bool? sortAscending = true;
  late String? filter = "";

  PaginateParam({required this.page});

  Map<String, dynamic>? toJson() {
    Map<String, dynamic>? map = {};
    map['page'] = page;
    if (sortField != null) {
      map['sortField'] = sortField;
    }
    if (sortAscending != null) {
      map['sortAscending'] = sortAscending;
    }
    if (filter != null) {
      map['filter'] = filter;
    }
    return map;
  }
}