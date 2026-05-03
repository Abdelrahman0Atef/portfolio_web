import '../models/education.dart';
import '../models/experience.dart';
import '../models/project.dart';
import '../models/skill_category.dart';

/// All of Abdelrahman's CV content, structured for the UI.
class CvData {
  CvData._();

  // --- Identity -------------------------------------------------------------
  static const String name = 'Abdelrahman Atef Darwish';
  static const String shortName = 'Abdelrahman A. Darwish';
  static const String role = 'Flutter Developer';
  static const String location = 'Cairo, Egypt';

  static const String tagline =
      'I build cross-platform Flutter apps that ship to production — '
      'end-to-end, from architecture to App Store. Currently across '
      'e-commerce, healthcare, and enterprise HR.';

  static const String summary =
      'Flutter developer with 3+ years of production experience owning four '
      'cross-platform apps end-to-end — from architecture to App Store and '
      'Google Play release across e-commerce, healthcare, and enterprise HR. '
      'Delivered measurable impact: 20% crash rate reduction, 100% faster '
      'deployments via Shorebird OTA, and 15+ critical bugs resolved in live '
      'production. Proficient in Dart, Bloc/Cubit, Clean Architecture, '
      'GraphQL, and CI/CD pipelines.';

  // --- Contact --------------------------------------------------------------
  static const String email = 'abdelrahman.a.darwish.3@gmail.com';
  static const String phone = '+20 101 173 0253';
  static const String linkedin = 'abdelrahmanatefdarwish';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/abdelrahmanatefdarwish/';
  static const String github = 'Abdelrahman0Atef';
  static const String githubUrl = 'https://github.com/Abdelrahman0Atef';

  /// Where the "Download CV" button points.
  static const String cvUrl =
      'https://drive.google.com/uc?export=download&id=1jKHv0M_WHlux8aD5D9K4PppiyiaTr40E';

  // --- Headline metrics (for the home stat strip) --------------------------
  static const List<({String value, String label})> headlineStats = [
    (value: '3+', label: 'YEARS PRODUCTION'),
    (value: '5', label: 'PUBLISHED APPS'),
  ];

  // --- Experience -----------------------------------------------------------
  static const List<Experience> experiences = [
    Experience(
      company: 'Croco IT',
      role: 'Flutter Developer',
      period: 'Feb 2025 — Present',
      isCurrent: true,
      bullets: [
        'Worked on 4 production apps across e-commerce, healthcare, and HR; delivered features end-to-end from architecture and UI to App Store and Google Play release.',
        'Built and connected REST and GraphQL APIs, implemented JWT authentication with token refresh, and designed Dio interceptors for connectivity and automatic token renewal.',
        'Designed UI screens independently using Google\'s Stitch AI, filling the UI/UX role and delivering features 30%+ faster across multiple projects.',
        'Integrated Shorebird OTA updates, reducing deployment time by 100% and enabling instant production patches without full store resubmission.',
        'Resolved 15+ critical bugs across production apps, reducing crash rates by 20%, and handled an Apple App Store rejection by working directly with Apple\'s review team.',
      ],
    ),
    Experience(
      company: 'Freelance Yard',
      role: 'Flutter Developer · Freelance',
      period: 'Jun 2024 — Jan 2025',
      bullets: [
        'Built personal Flutter projects applying Bloc state management, Clean Architecture, local storage, and REST API integration.',
        'Developed a To-Do App (Bloc + SQFlite) and a Balanced Meal Planner (REST API via Dio with a clean UI).',
      ],
    ),
    Experience(
      company: 'Rqmmyat',
      role: 'Flutter Developer',
      period: 'Jan 2024 — May 2024',
      bullets: [
        'Worked on two Flutter projects: Valencia (restaurant task management) and HR Rqmmyat (internal HR system).',
        'Designed UI screens, fixed business logic, and connected API integrations to link Admin, Manager, and Staff workflows in both apps.',
        'Built the full authentication flow for HR Rqmmyat from scratch and integrated the backend API for end-to-end session management.',
        'Resolved a critical API data retrieval bug in Valencia that was blocking core functionality across all user roles.',
      ],
    ),
  ];

  // --- Volunteering ---------------------------------------------------------
  /// Community / non-paid roles.
  static const List<Experience> volunteering = [
    Experience(
      company: 'GDSC Future Academy',
      role: 'Flutter Development Instructor',
      period: 'Jun 2021 — May 2023',
      bullets: [
        'Led and mentored technical workshops and hackathons for students learning Flutter.',
        'Designed and developed mobile-app projects used as teaching material across the chapter.',
        'Enhanced students\' coding skills and deepened their understanding of cutting-edge mobile technologies.',
        'Fostered a collaborative, inclusive community of learners within the Google Developer Student Clubs initiative.',
      ],
    ),
  ];

  // --- Projects -------------------------------------------------------------
  static const List<Project> projects = [
    Project(
      name: 'AlMasry Integration App',
      tagline: 'Cross-platform e-commerce management dashboard.',
      category: 'E-commerce',
      role: 'Solo developer',
      image: 'assets/images/almasry_integration.png',
      gallery: [
        'assets/images/almasry_integration_login.png',
        'assets/images/almasry_integration_profile.png',
        'assets/images/almasry_integration_sync.png',
        'assets/images/almasry_integration_stock.png',
        'assets/images/almasry_integration_password.png',
      ],
      description:
          'A cross-platform dashboard integrating three marketplaces — Jumia, '
          'Noon, and Talabat — into a single app. Owned end-to-end as the '
          'sole developer.',
      tech: [
        'Flutter',
        'Bloc/Cubit',
        'MVVM',
        'Clean Architecture',
        'REST',
        'GraphQL',
      ],
      highlights: [
        'Implemented secure JWT authentication with token refresh and a Dio REST layer with custom interceptors for connectivity, cookies, and automatic token renewal.',
        'Developed order management, ERP inventory sync, stock updates, report generation, and competitor intelligence modules.',
        'Implemented GraphQL-based product reviews with efficient pagination and a full GraphQL logging system.',
      ],
    ),
    Project(
      name: 'AlMasry Pharmacy App',
      tagline: 'Live pharmacy app with real-time customer support.',
      category: 'Healthcare',
      role: 'Feature lead',
      platforms: ProjectPlatforms(
        googlePlay: true,
        appStore: true,
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.almasrypharmacy',
        appStoreUrl: 'https://apps.apple.com/us/app/almasry-store/id6483365001',
      ),
      image: 'assets/images/almasry_pharmacy.png',
      gallery: [
        'assets/images/almasry_pharmacy_offers.png',
        'assets/images/almasry_pharmacy_pharboty.png',
        'assets/images/almasry_pharmacy_blogs.png',
      ],
      description:
          'Consumer pharmacy app with smart search, integrated chatbot, and '
          'real-time customer support via Chatwoot, shipped to both stores.',
      tech: ['Flutter', 'Cubit', 'GraphQL', 'Chatwoot', 'WebView', 'HMAC'],
      highlights: [
        'Integrated Chatwoot real-time chat support via a WebView JS bridge with HMAC encryption, enabling live customer support.',
        'Redesigned the login interface three times to optimise and perfect the authentication user experience.',
        'Redesigned Smart Search and Chatbot UI with smooth animations; upgraded product filtering with multi-select capabilities via a new backend endpoint.',
        'Developed the Payment Method Selection interface and led post-migration end-to-end production testing.',
      ],
    ),
    Project(
      name: 'HR Mobic',
      tagline: 'Enterprise HR app with role-based access.',
      category: 'Enterprise HR',
      role: 'Feature lead',
      platforms: ProjectPlatforms(
        googlePlay: true,
        appStore: true,
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.crocoit.erp&hl=ar',
        appStoreUrl: 'https://apps.apple.com/fi/app/hrmobic/id6476941417',
      ),
      image: 'assets/images/hr_mobic.png',
      gallery: [
        'assets/images/hr_mobic_tasks.png',
        'assets/images/hr_mobic_leaves.png',
      ],
      description:
          'Internal HR app with strict role separation between Admin and '
          'Employee, paginated task management, and instant OTA patching.',
      tech: ['Flutter', 'Cubit', 'Shorebird OTA', 'REST API'],
      highlights: [
        'Implemented role-based security with strict Admin/Employee routing and access separation; built a paginated task filter handling 1,000+ records.',
        'Integrated Shorebird OTA updates, reducing deployment time by 100% and enabling instant production patches.',
        'Resolved an Apple App Store rejection by collaborating directly with Apple\'s review board.',
      ],
    ),
    Project(
      name: 'FozDoc — Skin Analysis',
      tagline: 'ML-powered skin analysis with adaptive UI.',
      category: 'Healthcare · ML',
      role: 'Feature developer',
      platforms: ProjectPlatforms(
        googlePlay: true,
        appStore: true,
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.fozdoc',
        appStoreUrl: 'https://apps.apple.com/eg/app/fozdoc/id6757810245',
      ),
      image: 'assets/images/fozdoc.png',
      gallery: [
        'assets/images/fozdoc_login.png',
        'assets/images/fozdoc_personalize.png',
        'assets/images/fozdoc_lifestyle.png',
        'assets/images/fozdoc_shop.png',
        'assets/images/fozdoc_routine.png',
        'assets/images/fozdoc_settings.png',
      ],
      description: 'A skin-analysis app that translates ML model output into '
          'intuitive, personalised skincare recommendations.',
      tech: ['Flutter', 'Cubit', 'ML Integration', 'REST API', 'Adaptive UI'],
      highlights: [
        'Designed and implemented the Skin Health Report screen, visualising API data with personalised skincare routines.',
        'Integrated ML-powered skin analysis models with the Flutter frontend, translating complex model outputs into intuitive recommendations.',
      ],
    ),
    Project(
      name: 'Valencia',
      tagline: 'Restaurant task management for staff hierarchies.',
      category: 'Operations',
      role: 'Contributor',
      description: 'Task management for Admin, Manager, and Staff roles in a '
          'restaurant operations setting.',
      tech: ['Flutter', 'Bloc', 'REST API'],
      highlights: [
        'Redesigned task management screens and corrected broken business logic to match actual app workflows.',
        'Connected the API layer to correctly link Admin, Manager, and Staff roles and resolved a critical data retrieval bug blocking core functionality.',
      ],
    ),
    Project(
      name: 'HR Rqmmyat',
      tagline: 'Internal HR system — authentication & sessions.',
      category: 'Enterprise HR',
      role: 'Contributor',
      description:
          'Internal HR system where I owned the authentication module and '
          'session handling for all user types.',
      tech: ['Flutter', 'REST API', 'Authentication'],
      highlights: [
        'Designed login and authentication screens from scratch and implemented the full login logic end-to-end.',
        'Integrated the backend authentication API to handle user sessions correctly for all user types.',
      ],
    ),
  ];

  // --- Skills ---------------------------------------------------------------
  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Languages',
      skills: ['Dart', 'Java', 'Kotlin', 'C++'],
    ),
    SkillCategory(
      title: 'Flutter & Mobile',
      skills: [
        'Flutter Animations',
        'Responsive UI',
        'Design Systems',
        'Localization',
        'iOS & Android',
      ],
    ),
    SkillCategory(
      title: 'Architecture',
      skills: [
        'Bloc / Cubit',
        'MVVM',
        'Clean Architecture',
        'SOLID',
        'GetIt',
        'GoRouter',
      ],
    ),
    SkillCategory(
      title: 'APIs & Networking',
      skills: ['REST', 'GraphQL', 'Dio', 'JWT', 'Postman'],
    ),
    SkillCategory(
      title: 'Backend, Cloud & Storage',
      skills: [
        'Firebase',
        'FCM',
        'Firestore',
        'Google Sign-In',
        'SQLite',
        'SQFlite',
        'Hive',
        'Shared Preferences',
      ],
    ),
    SkillCategory(
      title: 'DevOps & Tools',
      skills: [
        'Git',
        'Fastlane',
        'CI/CD',
        'Shorebird OTA',
        'Jira',
        'Chatwoot',
        'Google Maps',
        'HMAC',
        'Stripe',
      ],
    ),
  ];

  // --- Education ------------------------------------------------------------
  static const List<Education> education = [
    Education(
      institution: 'Digital Egypt Pioneers Initiative (DEPI) & MCIT',
      degree: 'Software Development — Mobile App Development',
      period: 'Jun 2024 — Oct 2024',
      notes: [
        '6-month vocational program under the DEPI initiative, run in partnership with MCIT.',
        'Equivalent to ITI (Information Technology Institute) in curriculum and focus, with a specialised track in mobile application development.',
      ],
    ),
    Education(
      institution: 'Future Academy, Egypt',
      degree: 'Bachelor of Computer Science',
      period: 'Jan 2018 — Sep 2022',
      notes: [
        'GPA: 3.0   ·   Graduation Project: Excellent (A)',
        'Built a strong foundation in programming languages, algorithms, data structures, and software-engineering principles — alongside hands-on skills in quick learning and problem-solving.',
        'Graduation Project: Dr. Brain — Patient-doctor app with voice/video calls, real-time chat, and ML-powered MRI tumor analysis.',
        'Awards: 1st place at the university level, and 3rd place in the Ministry of Higher Education Science Clubs competition.',
      ],
    ),
  ];

  static const List<String> certifications = [
    'Software Development — Mobile App Developer · DEPI & MCIT (2025)',
    'First Time Employee & Business Ethics (2025)',
    'McKinsey Forward Program (2025)',
    'Complete Flutter & Dart — Udemy (2023)',
    'Flutter Bootcamp with Dart — Udemy (2023)',
  ];

  // --- Languages -----------------------------------------------------------
  static const List<({String name, String level})> spokenLanguages = [
    (name: 'Arabic', level: 'Native'),
    (name: 'English', level: 'Professional'),
  ];
}
