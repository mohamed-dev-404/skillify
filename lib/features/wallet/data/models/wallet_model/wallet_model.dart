import 'history.dart';

class WalletModel {
	List<History>? history;
	int? currentBalance;

	WalletModel({this.history, this.currentBalance});

	factory WalletModel.fromJson(Map<String, dynamic> json) => WalletModel(
				history: (json['history'] as List<dynamic>?)
						?.map((e) => History.fromJson(e as Map<String, dynamic>))
						.toList(),
				currentBalance: json['currentBalance'] as int?,
			);

	Map<String, dynamic> toJson() => {
				'history': history?.map((e) => e.toJson()).toList(),
				'currentBalance': currentBalance,
			};
}
