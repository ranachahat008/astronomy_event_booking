# 🔭 Astronomy Event Booking App

A Flutter mobile application that allows users to browse astronomy events and make bookings. Built with Flutter, Firebase, and GetX.

---

## 📸 Screenshots

<!-- Add your screenshots here -->

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
Select your Firebase project and target platforms (Android/iOS). This auto-generates `firebase_options.dart`.

#### Step 5 — Firestore Security Rules
In Firebase Console → Firestore → **Rules**, paste: