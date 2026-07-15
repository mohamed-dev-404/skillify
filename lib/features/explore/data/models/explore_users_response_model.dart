import 'package:skillify/features/explore/data/models/explore_user_model.dart';

class ExploreUsersResponseModel {
  const ExploreUsersResponseModel({
    required this.items,
    required this.totalCount,
  });

  factory ExploreUsersResponseModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>? ?? const [];

    return ExploreUsersResponseModel(
      items: items
          .whereType<Map<String, dynamic>>()
          .map(ExploreUserModel.fromJson)
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
    );
  }

  final List<ExploreUserModel> items;
  final int totalCount;
}
