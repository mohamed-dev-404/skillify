class ExploreFilters {
  const ExploreFilters({
    this.page,
    this.pageSize,
    this.name,
    this.skillId,
    this.minRating,
    this.langId,
  });

  final int? page;
  final int? pageSize;
  final String? name;
  final int? skillId;
  final double? minRating;
  final int? langId;

  Map<String, dynamic> toQueryParameters() {
    final trimmedName = name?.trim();

    return {
      if (page != null) 'page': page,
      if (pageSize != null) 'pageSize': pageSize,
      if (trimmedName != null && trimmedName.isNotEmpty) 'name': trimmedName,
      if (skillId != null) 'skillId': skillId,
      if (minRating != null) 'minRating': minRating,
      if (langId != null) 'langId': langId,
    };
  }

  ExploreFilters copyWith({
    int? page,
    int? pageSize,
    String? name,
    int? skillId,
    double? minRating,
    int? langId,
  }) {
    return ExploreFilters(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
      name: name ?? this.name,
      skillId: skillId ?? this.skillId,
      minRating: minRating ?? this.minRating,
      langId: langId ?? this.langId,
    );
  }
}
