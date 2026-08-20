import '../models/education.dart';
import '../models/experience.dart';
import '../models/project.dart';
import '../models/skill_category.dart';

class CvData {
  const CvData._();

  // ---------------------------------------------------------------------------
  // Identity
  // ---------------------------------------------------------------------------

  static const String name = 'Abdelrahman Atef Darwish';
  static const String shortName = 'Abdelrahman A. Darwish';

  static const String role = 'Mobile Developer (Flutter)';
  static const String location = 'Cairo, Egypt';

  static const String tagline =
      'I ship Flutter apps that real people use every day — currently across '
      'e-commerce, healthcare, and enterprise HR.';

  static const String summary =
      'Flutter developer who has shipped seven production apps on Android and '
      'iOS across e-commerce, healthcare, and enterprise HR, including a live '
      'app serving 10,000+ users. Works across the security layer — JWT with '
      'token refresh, OTP verification, HMAC-signed requests, encrypted token '
      'storage, and biometric sign-in — and on the performance side, cutting '
      'cold start from 5s to 2s and shipping production hotfixes in minutes '
      'with Shorebird OTA. Comfortable migrating live codebases: REST to '
      'GraphQL, and setState to Bloc/Cubit, without breaking what is already '
      'in production.';

  // ---------------------------------------------------------------------------
  // Contact
  // ---------------------------------------------------------------------------

  static const String email = 'abdelrahman.a.darwish.3@gmail.com';
  static const String phone = '+20 101 173 0253';

  static const String linkedin = 'abdelrahmanatefdarwish';
  static const String linkedinUrl =
      'https://www.linkedin.com/in/abdelrahmanatefdarwish/';

  static const String github = 'Abdelrahman0Atef';
  static const String githubUrl = 'https://github.com/Abdelrahman0Atef';

  /// Where the "Download CV" button points.
  static const String cvUrl =
      'https://drive.google.com/uc?export=download&id=1XJVbxY543_CdHaV79C42P-OBFU7TkFh8';

  // ---------------------------------------------------------------------------
  // Headline metrics
  // ---------------------------------------------------------------------------

  static const List<({String value, String label})> headlineStats = [
    (value: '7', label: 'PRODUCTION APPS'),
    (value: '3', label: 'LIVE ON BOTH STORES'),
    (value: '10K+', label: 'USERS SERVED'),
  ];

  // ---------------------------------------------------------------------------
  // Experience
  // ---------------------------------------------------------------------------

  static const List<Experience> experiences = [
    Experience(
      company: 'Croco IT',
      role: 'Mobile Developer (Flutter)',
      period: 'Feb 2025 — Present',
      isCurrent: true,
      bullets: [
        'Deliver features end-to-end across four production apps in e-commerce, '
            'healthcare, and enterprise HR — from architecture through App Store '
            'and Google Play release.',
        'Migrated the checkout and ordering module of AlMasry Pharmacy '
            '(10,000+ active users) from REST to GraphQL on a live app, cutting '
            'over-fetching while keeping the flow working through the cutover.',
        'Built the mobile security layer: JWT authentication with automatic '
            'token refresh, OTP verification against the backend, HMAC-signed '
            'requests, encrypted token storage with flutter_secure_storage, and '
            'Face ID sign-in via local_auth.',
        'Built and maintained REST layers with Dio, including custom '
            'interceptors for token renewal, retry, cookies, and connectivity, '
            'and integrated third-party SDKs.',
        'Integrated Shorebird OTA, removing the 1–3 day store review cycle for '
            'hotfixes and shipping production patches to Android and iOS in '
            'minutes.',
        'Reduced cold start from 5s to 2s through lazy loading and pagination, '
            'and migrated 10+ screens across two production apps from setState '
            'to Bloc/Cubit — crash rate dropped roughly 20% afterwards, tracked '
            'in Firebase Crashlytics and Sentry.',
        'Resolved an Apple App Store rejection by working directly with the '
            'review team, unblocking the release.',
        'Review teammates\' pull requests, onboard and mentor a new intern, and '
            'work daily with QA and Product in an Agile team.',
        'Design UI screens independently using Google Stitch when no designer '
            'is assigned, shortening the handoff loop on smaller features.',
      ],
    ),
    Experience(
      company: 'Freelance Yard',
      role: 'Flutter Developer · Freelance',
      period: 'Jun 2024 — Jan 2025',
      bullets: [
        'Delivered two Flutter apps for a client as sole developer, from '
            'architecture through handover — Bloc, Clean Architecture, REST '
            'integration, and local storage.',
        'Built complex animated UI from the client\'s designs and integrated '
            'Firebase Cloud Messaging for push notifications.',
        'Completed the DEPI mobile development track with MCIT during the same '
            'period.',
      ],
    ),
    Experience(
      company: 'Rqmmyat',
      role: 'Flutter Developer',
      period: 'Jan 2024 — May 2024',
      bullets: [
        'Worked on two Flutter products: Valencia (restaurant task management) '
            'and HR Rqmmyat (internal HR system).',
        'Built the full authentication flow for HR Rqmmyat from scratch and '
            'integrated the backend API for end-to-end session management.',
        'Designed UI screens, corrected business logic, and connected API '
            'integrations linking Admin, Manager, and Staff workflows across '
            'both apps.',
        'Diagnosed and fixed a critical data-retrieval failure in Valencia that '
            'was blocking core functionality for every user role.',
        'Added widget tests for role-based screens to catch regressions before '
            'they reached QA.',
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Teaching & community
  // ---------------------------------------------------------------------------

  static const List<Experience> volunteering = [
    Experience(
      company: 'GDSC Future Academy',
      role: 'Flutter Development Instructor',
      period: 'Jun 2021 — May 2023',
      bullets: [
        'Led technical workshops and hackathons for students learning Flutter, '
            'across two academic years.',
        'Designed and built mobile-app projects used as teaching material '
            'across the chapter.',
        'Mentored students through their first Flutter builds, from setup to a '
            'working app.',
        'Helped grow a collaborative community of learners within the Google '
            'Developer Student Clubs initiative.',
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Projects
  // ---------------------------------------------------------------------------

  static const List<Project> projects = [
    Project(
      name: 'AlMasry Integration',
      tagline: 'Three marketplaces, one dashboard. Built solo, end to end.',
      category: 'E-commerce · Internal tooling',
      role: 'Solo developer',
      image: 'assets/images/almasryIntegration/01-dashboard-order-status.png',
      gallery: [
        'assets/images/almasryIntegration/02-sync-orders-erp.png',
        'assets/images/almasryIntegration/03-orders-list-noon.png',
        'assets/images/almasryIntegration/04-order-details-timeline.png',
        'assets/images/almasryIntegration/05-reports-list.png',
        'assets/images/almasryIntegration/06-report-details-export.png',
        'assets/images/almasryIntegration/07-advanced-filters.png',
        'assets/images/almasryIntegration/08-order-prep-file-details.png',
        'assets/images/almasryIntegration/09-login.png',
        'assets/images/almasryIntegration/10-localization-ar-en.png',
      ],
      description:
          'A cross-platform dashboard pulling Jumia, Noon, and Talabat into a '
          'single operational view. Owned end to end as the only person on the '
          'project — screen design through architecture, implementation, and '
          'delivery.',
      tech: [
        'Flutter',
        'Bloc/Cubit',
        'Clean Architecture',
        'MVVM',
        'REST',
        'GraphQL',
        'Dio',
        'JWT',
      ],
      highlights: [
        'Took the app from an empty repository to delivery alone: designed the '
            'screens with AI-assisted tooling, set the architecture, built '
            'every module, and shipped it.',
        'Implemented JWT authentication with token refresh over a Dio REST '
            'layer, with custom interceptors handling connectivity, cookies, '
            'and automatic renewal.',
        'Built order management, ERP inventory sync, stock updates, report '
            'generation, and competitor intelligence as separate modules under '
            'Clean Architecture.',
        'Implemented GraphQL-backed product reviews with cursor pagination and '
            'a full GraphQL logging layer for debugging in staging.',
        'Shipped full Arabic and English localisation, including RTL layout '
            'across every screen.',
      ],
    ),
    Project(
      name: 'AlMasry Pharmacy',
      tagline: 'Live pharmacy app serving 10,000+ users.',
      category: 'E-commerce · Healthcare',
      role: 'Feature developer',
      platforms: ProjectPlatforms(
        googlePlay: true,
        appStore: true,
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.almasrypharmacy',
        appStoreUrl: 'https://apps.apple.com/us/app/almasry-store/id6483365001',
      ),
      image: 'assets/images/almasryPharmacy/01-home-offers-banner.png',
      gallery: [
        'assets/images/almasryPharmacy/02-profile-account.png',
        'assets/images/almasryPharmacy/03-categories-offers.png',
        'assets/images/almasryPharmacy/04-acne-treatment-filter.png',
        'assets/images/almasryPharmacy/05-cart-checkout.png',
        'assets/images/almasryPharmacy/06-home-blogs.png',
        'assets/images/almasryPharmacy/07-categories-search.png',
      ],
      description:
          'A consumer pharmacy app with smart search, an integrated chatbot, '
          'and real-time customer support — live on both stores with more than '
          '10,000 active users.',
      tech: [
        'Flutter',
        'Cubit',
        'GraphQL',
        'REST',
        'HMAC',
        'WebView',
        'Chatwoot',
      ],
      highlights: [
        'Migrated the checkout and ordering module from REST to GraphQL on a '
            'live app, then led end-to-end production testing after the cutover.',
        'Integrated Chatwoot real-time support through a WebView JS bridge with '
            'HMAC-signed requests and user identifiers, so a session cannot be '
            'spoofed from the client.',
        'Built the payment method selection interface.',
        'Rebuilt Smart Search and the chatbot UI with smooth animations, and '
            'extended product filtering to multi-select against a new backend '
            'endpoint.',
        'Iterated on the login interface across three redesigns to reduce '
            'drop-off during authentication.',
      ],
    ),
    Project(
      name: 'HR Mobic',
      tagline: 'Enterprise HR with strict role separation.',
      category: 'Enterprise HR',
      role: 'Feature owner',
      platforms: ProjectPlatforms(
        googlePlay: true,
        appStore: true,
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.crocoit.erp&hl=ar',
        appStoreUrl: 'https://apps.apple.com/fi/app/hrmobic/id6476941417',
      ),
      image: 'assets/images/hrMobic/01-home-attendance.png',
      gallery: [
        'assets/images/hrMobic/02-tasks-list-filters.png',
        'assets/images/hrMobic/03-tasks-detailed-view.png',
        'assets/images/hrMobic/04-task-details-progress.png',
        'assets/images/hrMobic/05-add-task-sheet.png',
        'assets/images/hrMobic/06-profile-information.png',
        'assets/images/hrMobic/07-leaves-requests.png',
      ],
      description:
          'Internal HR app with hard separation between Admin and Employee '
          'access, paginated task management, and instant OTA patching.',
      tech: ['Flutter', 'Cubit', 'REST', 'Shorebird OTA'],
      highlights: [
        'Implemented role-based access with strict Admin/Employee routing, so '
            'no employee-scoped session can reach an admin route.',
        'Built a paginated task filter that stays responsive across 1,000+ '
            'records.',
        'Integrated Shorebird OTA, removing the store review cycle for hotfixes '
            'and shipping patches in minutes.',
        'Resolved an Apple App Store rejection by working directly with the '
            'review board to unblock the release.',
      ],
    ),
    Project(
      name: 'FozDoc — Skin Analysis',
      tagline: 'ML skin analysis with a guided capture flow.',
      category: 'Healthcare · ML',
      role: 'Feature owner',
      platforms: ProjectPlatforms(
        googlePlay: true,
        appStore: true,
        googlePlayUrl:
            'https://play.google.com/store/apps/details?id=com.fozdoc',
        appStoreUrl: 'https://apps.apple.com/eg/app/fozdoc/id6757810245',
      ),
      image: 'assets/images/fozdoc/01-welcome-login.png',
      gallery: [
        'assets/images/fozdoc/02-personalize-basics.png',
        'assets/images/fozdoc/03-personalize-lifestyle-budget.png',
        'assets/images/fozdoc/04-photo-guide.png',
        'assets/images/fozdoc/05-personalized-care-routine.png',
        'assets/images/fozdoc/06-shop-products.png',
        'assets/images/fozdoc/07-settings.png',
      ],
      description:
          'A consumer skin-analysis app that turns raw ML model output into a '
          'personalised skincare routine, live on both stores. The analysis is '
          'only as good as the photo, so most of the engineering went into the '
          'capture flow rather than the report.',
      tech: [
        'Flutter',
        'Cubit',
        'REST',
        'ML Kit Face Detection',
        'Camera',
        'Adaptive UI',
      ],
      highlights: [
        'Built the guided capture system on top of google_mlkit_face_detection: '
            'the shutter stays locked until face framing, distance, and '
            'lighting meet the model\'s input requirements, then a countdown '
            'runs with per-second audio cues and a capture confirmation tone, '
            'so the user is never guessing whether the shot registered.',
        'Built two capture modes — a single front-facing shot, or a '
            'three-angle sequence (front, left, right). The dermatologists '
            'annotating the training data reported the three-angle input '
            'produced the more accurate analysis, so it became the '
            'recommended path.',
        'Designed and built the Skin Health Report screen, turning model output '
            'into a routine a person can follow rather than a score they have '
            'to interpret.',
        'Built the personalisation onboarding flow covering skin basics, '
            'lifestyle, and budget.',
      ],
    ),
    Project(
      name: 'FozDoc Clinic',
      tagline: 'The tablet build. Same model, a completely different user.',
      category: 'Healthcare · ML · Clinical',
      role: 'Solo developer',
      image: 'assets/images/fozdocClinic/01-capture-conditions.png',
      gallery: [
        'assets/images/fozdocClinic/02-capture-countdown.png',
        'assets/images/fozdocClinic/03-rear-camera-assisted.png',
        'assets/images/fozdocClinic/04-three-angle-sequence.png',
        'assets/images/fozdocClinic/05-skin-report-wide.png',
        'assets/images/fozdocClinic/06-product-recommendations.png',
      ],
      description:
          'A separate tablet build of FozDoc for dermatologists, cosmetic '
          'clinics, and pharmacies — where a practitioner photographs the '
          'patient instead of the patient photographing themselves. Owned '
          'alone, on its own release cycle, and distributed directly rather '
          'than through the stores.',
      tech: [
        'Flutter',
        'Cubit',
        'REST',
        'ML Kit Face Detection',
        'Camera',
        'Tablet Layouts',
      ],
      highlights: [
        'Sole developer on the build: took the clinical variant from scoping '
            'through to a release-ready tablet app on its own cycle, separate '
            'from the consumer app on the stores.',
        'Reworked capture for a two-person flow — the practitioner frames the '
            'shot and triggers the shutter manually once it looks right, '
            'rather than the subject waiting on an automatic timer they '
            'cannot see.',
        'Enabled the rear camera alongside the front one, since a practitioner '
            'photographing a patient reaches for the rear camera every time. '
            'The consumer app never needed it.',
        'Made the three-angle sequence (front, left, right) the only capture '
            'path here — a clinical result has to be the most accurate one '
            'available, so the faster single-shot mode was deliberately left '
            'out.',
        'Built the layout for tablet rather than scaling the phone UI, so the '
            'capture preview and guidance stay usable at arm\'s length across '
            'a counter or examination chair.',
        'Structured the build to support per-clinic customisation ahead of '
            'first deployment.',
      ],
    ),
    Project(
      name: 'Valencia',
      tagline: 'Restaurant task management across staff hierarchies.',
      category: 'Operations',
      role: 'Contributor',
      description:
          'Task management for Admin, Manager, and Staff roles in a restaurant '
          'operations setting.',
      tech: ['Flutter', 'Bloc', 'REST'],
      highlights: [
        'Rebuilt task management screens and corrected business logic that did '
            'not match the real operational workflow.',
        'Connected the API layer linking Admin, Manager, and Staff roles.',
        'Diagnosed and fixed a critical data-retrieval bug that was blocking '
            'core functionality for every role.',
      ],
    ),
    Project(
      name: 'HR Rqmmyat',
      tagline: 'Owned the authentication module end-to-end.',
      category: 'Enterprise HR',
      role: 'Contributor',
      description:
          'Internal HR system where I owned authentication and session handling '
          'for all user types.',
      tech: ['Flutter', 'REST', 'Authentication'],
      highlights: [
        'Designed the login screens and implemented the full authentication '
            'logic from scratch.',
        'Integrated the backend auth API to handle sessions correctly across '
            'every user type.',
        'Added widget tests for role-based screens to catch regressions before '
            'they reached QA.',
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Skills
  // ---------------------------------------------------------------------------

  static const List<SkillCategory> skillCategories = [
    SkillCategory(
      title: 'Languages',
      skills: ['Dart', 'Java', 'Kotlin', 'C++'],
    ),
    SkillCategory(
      title: 'Flutter & Mobile',
      skills: [
        'Flutter',
        'iOS & Android',
        'Flutter Animations',
        'Responsive UI',
        'Design Systems',
        'Localization & RTL',
      ],
    ),
    SkillCategory(
      title: 'Architecture',
      skills: [
        'Bloc / Cubit',
        'Clean Architecture',
        'MVVM',
        'SOLID',
        'GetIt',
        'GoRouter',
      ],
    ),
    SkillCategory(
      title: 'Security & Auth',
      skills: [
        'Secure Coding',
        'JWT & Token Refresh',
        'OTP Verification',
        'HMAC Request Signing',
        'flutter_secure_storage',
        'Biometric Auth (local_auth)',
        'Role-Based Access',
      ],
    ),
    SkillCategory(
      title: 'Payments',
      skills: ['Paymob', 'Stripe', 'Checkout Flows'],
    ),
    SkillCategory(
      title: 'APIs & Networking',
      skills: ['REST', 'GraphQL', 'Dio', 'Interceptors', 'Pagination'],
    ),
    SkillCategory(
      title: 'ML & Device',
      skills: [
        'Google ML Kit',
        'Face Detection',
        'Camera Pipelines',
        'ML Model Integration',
      ],
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
      ],
    ),
    SkillCategory(
      title: 'Testing & Monitoring',
      skills: [
        'Unit Testing',
        'Widget Testing',
        'Firebase Crashlytics',
        'Sentry',
        'Firebase Analytics',
      ],
    ),
    SkillCategory(
      title: 'DevOps & Tools',
      skills: [
        'Git',
        'CI/CD',
        'Fastlane',
        'Build Flavors',
        'Shorebird OTA',
        'App Store Connect',
        'TestFlight',
        'Google Play Console',
        'Agile / Scrum',
        'Jira',
      ],
    ),
  ];

  // ---------------------------------------------------------------------------
  // Education
  // ---------------------------------------------------------------------------

  static const List<Education> education = [
    Education(
      institution: 'Digital Egypt Pioneers Initiative (DEPI) & MCIT',
      degree: 'Software Development — Mobile App Development',
      period: 'Jun 2024 — Oct 2024',
      notes: [
        'Six-month vocational programme under the DEPI initiative, run in '
            'partnership with MCIT.',
        'Comparable to the ITI programme in curriculum and intensity, with a '
            'specialised mobile application development track.',
      ],
    ),
    Education(
      institution: 'Future Academy, Egypt',
      degree: 'Bachelor of Computer Science',
      period: 'Jan 2018 — Sep 2022',
      notes: [
        'Graduation project graded Excellent (A).',
        'Dr. Brain — a patient-doctor app with voice and video calls, real-time '
            'chat, and ML-powered MRI tumour analysis.',
        'First place at university level, and third place in the Ministry of '
            'Higher Education Science Clubs competition.',
      ],
    ),
  ];

  static const List<String> certifications = [
    'Software Development — Mobile App Developer · DEPI & MCIT (2025)',
    'McKinsey Forward Program (2025)',
    'First Time Employee & Business Ethics (2025)',
    'Complete Flutter & Dart · Udemy (2023)',
    'Flutter Bootcamp with Dart · Udemy (2023)',
  ];

  // ---------------------------------------------------------------------------
  // Spoken languages
  // ---------------------------------------------------------------------------

  static const List<({String name, String level})> spokenLanguages = [
    (name: 'Arabic', level: 'Native'),
    (name: 'English', level: 'Professional'),
  ];
}
