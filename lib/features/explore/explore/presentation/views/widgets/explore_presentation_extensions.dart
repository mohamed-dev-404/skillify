import 'package:skillify/features/explore/data/models/explore_filters.dart';
import 'package:skillify/features/explore/explore/presentation/view_model/explore_cubit/explore_cubit.dart';

extension ExploreFiltersPresentation on ExploreFilters {
  int get activeCount {
    return [
      skillId,
      langId,
      minRating,
    ].where((value) => value != null).length;
  }
}

extension ExploreUsersStatePresentation on ExploreUsersState {
  bool get isRefreshing {
    return status == ExploreUsersStatus.loading && users.isNotEmpty;
  }
}
