# EVER AFTER PLANNER - COMPLETE WEDDING PLANNER APP 📃
A wedding planning app built with Flutter, Dart, and GetX on a Firebase backend. It helps plan end‑to‑end with authentication, venue discovery with filters, a task checklist, a budget planner with a pie chart, and guest management with RSVP tracking.

# Key Features Implemented:
* 🔐 Email/Password Authentication:
  * Secure sign up and login using Firebase Authentication with Firestore user profiles.
  * Auth gate redirects to Home after successful login; sign out supported from the Home screen.
* 🏛️ Venues with Smart Filters:
  * Scrollable list of venue cards with asset images, rating, location, capacity, and budget range.
  * Dual RangeSliders to filter by Budget (₹L) and Capacity (guests) in real time; only matching venues are shown.
  * Filtering logic checks range overlap for budget and inclusive range for capacity.
* ✅ Checklist (Tasks):
  * Create tasks with title, category, last date text, and urgency level; validate required fields.
  * Toggle tasks Active/Done using a checkbox; title gets a strike‑through when completed.
  * Filter chips for All, Active, Done; add/edit via bottom sheet forms.
* 💸 Budget Planner with Pie Chart:
  * Input a total budget and allocate amounts to 5 default categories: Venue, Catering, Photography, Décor, Other.
  * Interactive sliders to adjust each category; the pie chart updates live using ff_chart.
  * Three presets (Traditional, Modern, Luxury) prefill category splits; values can be fine‑tuned.
* 🧑‍🤝‍🧑 Guests & RSVP:
  * Add guests with name and contact details; set RSVP status as Yes/No/Maybe/Pending.
  * Category views: All, Yes, No, Maybe, Pending; switching status moves the guest between views automatically.
  * Simple search/filter patterns can be extended later.
* ✨ Delightful Home:
  * Personalized greeting from Firestore, subtle header animation (Lottie or MP4), and four feature cards to jump into modules.
  * Sign‑out action via FloatingActionButton on Home.

# Technologies Used:
* **Frontend**:  Flutter + Dart with GetX for routing/state management and Material 3 design system.
* **Backend**:  Firebase Authentication and Cloud Firestore for user data and app state.
* **Charts**: fl_chart for the responsive budget pie chart.
* **Animations**: Lottie (asset JSON) for a lightweight header loop; can be deferred for faster first paint.

# ScreenRecording Link:

# Run on your device:
* 🔧 Prerequisites
  * Before starting, make sure you have:
    * ✅ Flutter SDK installed and configured
    * ✅ Git installed
    * ✅ Android Studio or Visual Studio Code (with Flutter & Dart plugins)
    * ✅ A connected Android device or emulator
* 📥 Step 1: Clone the Repository-
  * Open a terminal and run:
    * git clone https://github.com/nikhilesh-7119/ever_after_planner
    * cd ever_after_planner
* 📦 Step 2: Install Dependencies-
  * Run the following command to install all required packages:
    * flutter pub get
* 🔐 Step 3: Set Up Firebase-
  * Create a Firebase project in the console
  * Enable Email/Password in Authentication.
  * Add an Android app; download google-services.json into android/app/.
  * Initialize FlutterFire if using the CLI; confirm Firestore is enabled.
* 🛠️ Step 4: Configure Assets
  * Add venue images and Lottie JSON under assets/, and declare in pubspec.yaml.
* 🛠️ Step 5: Run the App-
  * Use the following command to launch the app:
    * flutter run

# 📃 License
* This project is open-source and available under the MIT License.

