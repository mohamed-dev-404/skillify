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
    Object? page = _unset,
    Object? pageSize = _unset,
    Object? name = _unset,
    Object? skillId = _unset,
    Object? minRating = _unset,
    Object? langId = _unset,
  }) {
    return ExploreFilters(
      page: identical(page, _unset) ? this.page : page as int?,
      pageSize: identical(pageSize, _unset) ? this.pageSize : pageSize as int?,
      name: identical(name, _unset) ? this.name : name as String?,
      skillId: identical(skillId, _unset) ? this.skillId : skillId as int?,
      minRating: identical(minRating, _unset)
          ? this.minRating
          : minRating as double?,
      langId: identical(langId, _unset) ? this.langId : langId as int?,
    );
  }
}

const Object _unset = Object();
