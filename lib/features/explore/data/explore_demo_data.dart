import 'package:skillify/features/explore/data/models/explore_model.dart';

abstract final class ExploreDemoData {
  static const users = [
    ExploreUserCardData(
      userId: 1,
      fullName: 'Ahmed Mohamed',
      jobTitle: '.NET Backend Developer',
      imageUrl:
          'https://res.cloudinary.com/dql3zffpt/image/upload/v1780163078/SkillifyAPI/avatars/SkillifyAPI/avatars/fc007a14-1f40-461c-b06e-32394bd5a529.jpg',
      offeredSkill: 'Programming',
      neededSkills: ['DevOps', 'Docker'],
      rating: 4.9,
    ),
    ExploreUserCardData(
      userId: 2,
      fullName: 'Sara Khaled',
      jobTitle: 'Product Designer',
      offeredSkill: 'UI/UX Design',
      neededSkills: ['Flutter', 'Public Speaking'],
      rating: 4.8,
    ),
    ExploreUserCardData(
      userId: 3,
      fullName: 'Omar Hassan',
      jobTitle: 'Mobile Developer',
      offeredSkill: 'Flutter',
      neededSkills: ['Product Design', 'UI/UX Design', 'English'],
      rating: 4.7,
    ),
    ExploreUserCardData(
      userId: 4,
      fullName: 'Mariam Abdelrahman El Sayed',
      jobTitle: 'Senior Digital Marketing',
      offeredSkill: 'Digital Marketing',
      neededSkills: ['Data Analysis', 'English', 'Photography'],
      rating: 4.6,
    ),
  ];
}
