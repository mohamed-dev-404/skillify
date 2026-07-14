import 'badge_model.dart';
import 'language_model.dart';
import 'main_skill.dart';
import 'needed_skill.dart';
import 'offered_skill.dart';
import 'profile_model.dart';
import 'review_model.dart';
import 'sub_skill.dart';

class ProfileMock {
  ProfileMock._();

  static final ProfileModel mockProfile = ProfileModel(
    userId: 1,
    fullName: 'Ahmed Mohamed',
    bio: '3rd year computer science student |  .Net Backend Developer',
    profilePictureUrl:
        'https://res.cloudinary.com/dql3zffpt/image/upload/v1780163078/SkillifyAPI/avatars/SkillifyAPI/avatars/fc007a14-1f40-461c-b06e-32394bd5a529.jpg',
    jobTitle: '.Net Backend Developer',
    creditBalance: 100,

    badges: [
      BadgeModel(
        id: 1,
        name: 'First Session',
        slug: 'first-session',
        description: 'Completed your very first skill-share session!',
        iconKey: 'badge_star',
      ),
      BadgeModel(
        id: 2,
        name: 'Top Mentor',
        slug: 'top-mentor',
        description: 'Received 5-star rating from 3 learners',
        iconKey: 'badge_trophy',
      ),
    ],

    languages: [
      LanguageModel(id: 1, name: 'Arabic', code: 'ar'),
      LanguageModel(id: 2, name: 'English', code: 'en'),
    ],

    offeredSkill: OfferedSkill(
      userSkillId: 1,
      mainSkill: MainSkill(
        id: 1,
        name: 'Programming',
        slug: 'programming',
        iconKey: null,
      ),
      subSkills: [
        SubSkill(id: 1, name: 'Backend Development', iconKey: null),
        SubSkill(id: 7, name: 'API Design', iconKey: null),
      ],
      description: 'I can teach you .Net, WEB API, RESTful API',
    ),

    neededSkills: [
      NeededSkill(
        userSkillId: 2,
        mainSkill: MainSkill(
          id: 46,
          name: 'DevOps',
          slug: 'devops',
          iconKey: null,
        ),
        subSkills: [
          SubSkill(id: 451, name: 'CI/CD Pipelines', iconKey: null),
          SubSkill(id: 458, name: 'Secrets Management', iconKey: null),
        ],
        description:
            'Need to learn how to make a CI/CD pipeline and how to store secrets in the server',
      ),
    ],

    completedSessions: '5',

    receivedReviews: [
      ReviewModel(
        id: 1,
        sessionId: 101,
        score: 5,
        reviewText:
            'Ahmed explained .NET concepts in a very clear and structured way. Highly recommend!',
        createdAt: '2026-07-10T14:30:00.000Z',
        reviewer: ReviewerModel(
          userId: 42,
          fullName: 'Sara Ali',
          profilePictureUrl:
              'https://i.pravatar.cc/150?img=47',
        ),
      ),
      ReviewModel(
        id: 2,
        sessionId: 98,
        score: 4,
        reviewText:
            'Great session on RESTful APIs. Would love to have more advanced sessions.',
        createdAt: '2026-06-28T09:15:00.000Z',
        reviewer: ReviewerModel(
          userId: 15,
          fullName: 'Omar Hassan',
          profilePictureUrl:
              'https://i.pravatar.cc/150?img=12',
        ),
      ),
    ],

    overallRatingScore: 4.5,
  );
}
