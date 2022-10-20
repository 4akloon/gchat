class PaginatorModel<T> {
  final List<T> data;
  final int total;
  final int perPage;
  final int page;
  final bool hasMorePages;

  PaginatorModel({
    this.data = const [],
    required this.total,
    required this.perPage,
    required this.page,
    required this.hasMorePages,
  });

  PaginatorModel<T> copyWith({
    List<T>? data,
    int? total,
    int? perPage,
    int? page,
    bool? hasMorePages,
  }) {
    return PaginatorModel<T>(
      data: data ?? this.data,
      total: total ?? this.total,
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      hasMorePages: hasMorePages ?? this.hasMorePages,
    );
  }

  Map<String, dynamic> toMap(Map Function(T) toMap) {
    return {
      'data': data.map((x) => toMap(x)).toList(),
      'total': total,
      'perPage': perPage,
      'page': page,
      'hasMorePages': hasMorePages,
    };
  }

  factory PaginatorModel.fromMap(
    Map<String, dynamic> map,
    T Function(Map<String, dynamic>) fromMap,
  ) {
    return PaginatorModel<T>(
      data: List<T>.from((map['data'] ?? []).map((x) => fromMap(x))),
      perPage: map['perPage'],
      page: map['page'],
      hasMorePages: map['hasMorePages'],
      total: map['total'],
    );
  }

  @override
  String toString() {
    return 'PaginatorModel(data: $data, total: $total, perPage: $perPage, page: $page, hasMorePages: $hasMorePages)';
  }

  static String graph(String data) =>
      'perPage page hasMorePages total data { $data }';
}
