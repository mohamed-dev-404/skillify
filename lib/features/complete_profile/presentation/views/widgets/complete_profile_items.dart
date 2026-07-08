import 'package:skillify/core/utils/assets/app_icons.dart';

/// A selectable skill category (used in the teach/learn steps).
class SkillCategoryItem {
  const SkillCategoryItem({
    required this.title,
    required this.subtitle,
    required this.iconPath,
  });

  final String title;
  final String subtitle;
  final String iconPath;
}

/// Static UI lists for the complete profile flow.
/// TODO: replace with API data when the logic is implemented.
class CompleteProfileItems {
  CompleteProfileItems._();

  static const List<String> languages = [
    'English',
    'Spanish',
    'German',
    'Mandarin',
    'Japanese',
    'Russian',
    'Arabic',
    'Hindi',
    'Korean',
    'Italian',
    'Portuguese',
  ];

  static const List<SkillCategoryItem> skillCategories = [
    SkillCategoryItem(
      title: 'Design',
      subtitle: 'UI/UX, Graphic, Product',
      iconPath: AppIcons.paletteSvg,
    ),
    SkillCategoryItem(
      title: 'Programming',
      subtitle: 'Web, Mobile, AI, Data Science',
      iconPath: AppIcons.codeSvg,
    ),
    SkillCategoryItem(
      title: 'Business',
      subtitle: 'Strategy, Finance, Sales',
      iconPath: AppIcons.briefcaseSvg,
    ),
    SkillCategoryItem(
      title: 'Music & Arts',
      subtitle: 'Instruments, Production, Fine Art',
      iconPath: AppIcons.musicSvg,
    ),
  ];

  static const List<String> programmingSkills = [
    'Flutter',
    'Back end',
    'Objective-C',
    'SwiftUI',
    'Dart',
    'Firebase',
  ];
}
