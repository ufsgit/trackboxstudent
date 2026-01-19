# Trackbox Student App - AI Coding Instructions

## Project Overview
**Trackbox** is a Flutter educational platform built with GetX state management, Firebase backend, and Socket.IO real-time communication. The app includes course management, live classes, exams, messaging, and an AI tutor (Breffini).

## Architecture Patterns

### State Management (GetX)
- **Controllers are singletons** created in `main.dart` with `Get.put()` (permanent: true for long-lived controllers)
- **Access controllers** with `Get.put()`, `Get.find()`, or via constructor injection
- **Observable state** using `.obs` (e.g., `RxBool`, `RxString`, `Rx<ModelClass>`)
- **UI reactivity** through `Obx(() => ...)` widgets or `GetBuilder`
- **Key controllers**: `HomeController`, `ProfileController`, `CourseModuleController`, `CallandChatController`, `CourseEnrolController`

Example pattern from `home_controller.dart`:
```dart
class HomeController extends GetxController {
  Rx<HomeModel> homeModelObj;
  RxBool isLoading = true.obs;
  
  Future<void> getTeacherList() async {
    isLoading.value = true;
    // API call
    isLoading.value = false;
  }
}
```

### HTTP & API Layer
- **Dio-based requests** in `lib/http/http_request.dart` with static methods
- **Bearer token auth** stored in SharedPreferences as `'breffini_token'`
- **Base URL** in `http_urls.dart` (currently dev tunnel: `tnk02n8v-3515.inc1.devtunnels.ms`)
- **Pattern**: `HttpRequest.httpGetRequest()`, `httpPostRequest()`, `httpPutRequest()`
- Always check token existence before API calls

### Real-Time Communication
- **Socket.IO** for chat, calls, and notifications via `lib/http/socket_io.dart`
- **Firebase Messaging** for push notifications (foreground handled in `main.dart`)
- **Zego UIKIT** for video/voice calls (initialized in `main.dart`)

## Project Structure

### Key Directories
| Path | Purpose |
|------|---------|
| `lib/presentation/` | All UI screens (40+ screens, organized by feature) |
| `lib/core/utils/` | Utilities: PrefUtils (local storage), logger, image constants |
| `lib/data/models/` | API response/request models |
| `lib/routes/app_routes.dart` | Route definitions (200+ lines) with GetPage bindings |
| `lib/theme/` | Colors, text styles, decorations |
| `lib/widgets/` | Reusable widgets (CustomImageView, shimmer loaders, etc.) |
| `lib/testpage/` | Exam/test UI components |

### Critical Files
- `main.dart` - Firebase init, controller registration, Zego setup, socket initialization
- `core/app_export.dart` - Centralized imports (use everywhere)
- `http/http_request.dart` - All HTTP operations
- `core/utils/pref_utils.dart` - SharedPreferences wrapper for local state

## Development Workflows

### Adding a New Screen
1. Create folder: `lib/presentation/[feature_name]/`
2. Create files: `[feature]_screen.dart`, `controller/[feature]_controller.dart`, `binding/[feature]_binding.dart`
3. In binding, override `dependencies()` with `Get.put()` calls
4. Register route in `app_routes.dart` with `GetPage(name: ..., page: ..., bindings: [...])`
5. Import controllers via `Get.find()` or inject in constructor

### Handling State Updates
- Use `.value =` to update observable values
- Use `.update()` for complex model updates
- Wrap UI with `Obx()` or `GetBuilder` to rebuild on changes
- Use `WidgetsBinding.instance.addPostFrameCallback()` for post-init operations

### Testing & Build Commands
```bash
dart format .           # Format code (required before commits)
flutter pub get         # Install dependencies
flutter build apk       # Android build
flutter analyze         # Check for lint errors
```

## Authentication & User Data
- **Auth flow**: Email/phone → OTP → Profile setup → Courses
- **Tokens stored as**: `SharedPreferences.getString('breffini_token')`
- **Student ID stored as**: `'breffini_student_id'`
- **Controllers**: `LoginController` (auth), `ProfileController` (user data)
- **Auth methods**: Email/password, Google Sign-In, phone OTP

## Key Dependencies
| Package | Purpose |
|---------|---------|
| `get: ^4.6.6` | State management & routing |
| `firebase_core/auth/firestore/storage/messaging` | Backend services |
| `dio` | HTTP client |
| `socket_io_client` | Real-time messaging |
| `zego_uikit_prebuilt_call` | Video/voice calling |
| `just_audio` / `audioplayers` | Audio playback & recording |
| `shared_preferences` | Local persistent storage |
| `cached_network_image` | Image caching |

## Common Patterns & Conventions

### Controller Initialization
Always follow this pattern:
```dart
class MyController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    // Initialize state here
  }
  
  @override
  void onReady() {
    super.onReady();
    // Load data after UI is ready
    loadData();
  }
}
```

### Local Storage
Use `PrefUtils()` singleton:
```dart
final prefs = PrefUtils();
await prefs.init(); // Called once in main.dart
prefs.setAuthToken(token); // Setter pattern exists
String? token = await SharedPreferences.getInstance().getString('breffini_token');
```

### Error Handling
- Check response != null before accessing response.data
- Wrap API calls in try-catch with appropriate error messages
- Use `Loader.showLoader()` / `Loader.stopLoader()` for loading states

### Firebase Models & Controllers
- Course content: `CourseDetailsContentListModel`
- Course reviews: `CourseReviewModel`
- Firestore docs: Cloud Firestore backing course data
- Analytics enabled for user behavior tracking

## Important Notes
- **Naming conventions**: Screen classes end with "Screen", controllers with "Controller"
- **Responsive design**: Uses `SizeUtils` for scaling (responsive heights: `.h`, widths: `.w`)
- **Lottie animations**: Located in `assets/lottie/` (3 animations: briffni_logo.json, newScene.json, record.json)
- **Image assets**: S3 bucket + local assets in `assets/images/`
- **Custom fonts**: Plus Jakarta Sans, Inter, Syne (defined in pubspec.yaml)

## Debugging Tips
- Check `lib/core/utils/logger.dart` for logging utilities
- Use `print()` statements (logging system initialized conditionally)
- Firebase Crashlytics enabled in production (non-kDebugMode)
- Check device logs for socket.io and Zego SDK messages
