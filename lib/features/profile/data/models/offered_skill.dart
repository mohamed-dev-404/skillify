import 'main_skill.dart';
import 'sub_skill.dart';

class OfferedSkill {
	int? userSkillId;
	MainSkill? mainSkill;
	List<SubSkill>? subSkills;
	String? description;

	OfferedSkill({
		this.userSkillId, 
		this.mainSkill, 
		this.subSkills, 
		this.description, 
	});

	factory OfferedSkill.fromJson(Map<String, dynamic> json) => OfferedSkill(
				userSkillId: json['userSkillId'] as int?,
				mainSkill: json['mainSkill'] == null
						? null
						: MainSkill.fromJson(json['mainSkill'] as Map<String, dynamic>),
				subSkills: (json['subSkills'] as List<dynamic>?)
						?.map((e) => SubSkill.fromJson(e as Map<String, dynamic>))
						.toList(),
				description: json['description'] as String?,
			);

	Map<String, dynamic> toJson() => {
				'userSkillId': userSkillId,
				'mainSkill': mainSkill?.toJson(),
				'subSkills': subSkills?.map((e) => e.toJson()).toList(),
				'description': description,
			};
}
