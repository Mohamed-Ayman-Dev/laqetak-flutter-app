class PaginationList<T> {
  List<T>? data;
  int? currentPage;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  PaginationList(
      {this.data,
      this.currentPage,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  factory PaginationList.fromJson(Map<String, dynamic> json) {
    return PaginationList<T>(
      data: json['data'] != null ? List<T>.from(json['data']) : [],
      currentPage: json['meta']['current_page'],
      firstPageUrl: json['first_page_url'],
      from: json['meta']['from'],
      lastPage: json['meta']['last_page'],
      lastPageUrl: json['last_page_url'],
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['meta']['per_page'] is int
          ? json['meta']['per_page']
          : int.parse(json['meta']['per_page'] ?? '10'),
      prevPageUrl: json['prev_page_url'],
      to: json['meta']['to'],
      total: json['meta']['total'],
    );
  }

  addItemsToList(Map<String, dynamic> json) {
    data!.addAll(List<T>.from(json['data']));
    currentPage = json['meta']['current_page'];
    from = json['meta']['from'];
    lastPage = json['meta']['last_page'];
    nextPageUrl = json['next_page_url'];
    prevPageUrl = json['prev_page_url'];
    to = json['meta']['to'];
  }
  // addItemsToList({List<T> data = const [], int? currentPage, int? lastPage}) {
  //   this.data ??= [];
  //   this.data!.addAll(data);
  //   if (currentPage != null) {
  //     this.currentPage = currentPage;
  //   }
  //   if (lastPage != null) {
  //     this.lastPage = lastPage;
  //   }
  // }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    data['data'] = data;
    return data;
  }
}
