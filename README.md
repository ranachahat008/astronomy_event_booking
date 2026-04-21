# 🔭 Astronomy Event Booking App

A Flutter mobile application that allows users to browse astronomy events and make bookings. Built
with Flutter, Firebase, and GetX.

---

## ✨ Features Implemented

### 🔐 Authentication

- User Sign Up with email & password
- User Login with email & password
- Auto-login (persistent session)
- Form validation with inline error messages
- User-friendly Firebase error messages
- Splash screen with auth state detection

### 🏠 Dashboard

- Bottom navigation with 3 tabs: Home, Bookings, Profile
- Clean and responsive UI

### 📅 Home (Events)

- List of 6 astronomy events
- Each card shows event name, date, and location
- Tap to navigate to Event Details screen

### 📋 Event Details

- Event image, description, date, location
- Available seats display
- Book Now button with seat input and validation
- Disables and shows "Already Booked" after booking

### 🎟️ My Bookings

- Lists all booked events from Firestore
- Shows event name and seats booked
- Confirmed badge on each booking
- Empty state when no bookings exist

### 👤 Profile

- Displays logged-in user's email
- Logout button

### ☁️ Firestore Integration

- Bookings stored in Firestore per user
- Bookings fetched on app start
- Secure rules — users can only read/write their own bookings

---

## 🛠️ Setup Steps

### Prerequisites

- Flutter SDK (3.x or above)
- Android Studio / VS Code
- Firebase account

---

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/astronomy_event_booking.git
cd astronomy_event_booking
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Step 1 — Create a Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click **Add Project** and follow the setup steps

#### Step 2 — Enable Authentication

1. In Firebase Console → **Authentication** → **Get Started**
2. Enable **Email/Password** provider

#### Step 3 — Enable Firestore

1. In Firebase Console → **Firestore Database** → **Create Database**
2. Start in **Test Mode** for development

#### Step 4 — Connect Flutter to Firebase

Install the Firebase CLI if you haven't:

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
```

Then run:

```bash
flutterfire configure
```

Select your Firebase project and target platforms (Android/iOS). This auto-generates
`firebase_options.dart`.

#### Step 5 — Firestore Security Rules

In Firebase Console → Firestore → **Rules**, paste:
rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {
match /bookings/{bookingId} {
allow read, write: if request.auth != null
&& request.auth.uid == resource.data.userId;
allow create: if request.auth != null;
}
}
}

---

### 4. Run the App

```bash
flutter run
```

---

## 📦 Packages Used

| Package           | Purpose                       |
|-------------------|-------------------------------|
| `firebase_core`   | Firebase initialization       |
| `firebase_auth`   | Email/password authentication |
| `cloud_firestore` | Storing bookings              |
| `get`             | State management & navigation |
| `google_fonts`    | Outfit font                   |

---

## 📁 Project Structure

lib/
├── controllers/
│   ├── auth_controller.dart
│   ├── booking_controller.dart
│   └── dashboard_controller.dart
├── models/
│   ├── event_model.dart
│   └── booking_model.dart
├── views/
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── dashboard/
│   │   └── dashboard.dart
│   ├── home/
│   │   ├── home_screen.dart
│   │   └── event_details.dart
│   ├── bookings/
│   │   └── bookings_screen.dart
│   ├── profile/
│   │   └── profile_screen.dart
│   └── splash/
│       └── splash_screen.dart
├── initialBinding.dart
└── main.dart


## 📝 Notes

- Bookings are stored in Firestore under a `bookings` collection
- Each booking is linked to the user via their Firebase `uid`
- Events are currently hardcoded — Firestore integration for events is a future improvement