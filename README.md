# 🎯 Truth or Dare - Flutter Game

A fun and interactive **Truth or Dare** game built with **Flutter** for mobile devices.  
It features a **spinning fortune wheel** to choose the next player, game modes, and a clean, colorful design.

![Game Preview](screenshot.png) <!-- Optional: add your screenshot file -->

---

## ✨ Features

- 🎡 **Fortune Wheel** to randomly pick the next player.
- 🧍 **Player List** – easily manage who’s in the game.
- 🎭 **Game Modes** – choose between different modes (premium & free).
- 📱 **Mobile-Friendly UI** – large touch targets, easy to play with friends.
- 🌈 **Colorful Wheel Slices** – each player gets their own color.
- 🔔 Optional sounds, haptics, and animations.

---

## 📸 Screenshots

| Wheel Screen | Truth or Dare Selection | Game Mode Selector |
|--------------|------------------------|--------------------|
| ![Wheel](wheel.png) | ![Truth or Dare](truth_dare.png) | ![Modes](modes.png) |

---

## 🚀 Getting Started

### 1️⃣ Prerequisites

Make sure you have:
- [Flutter SDK](https://flutter.dev/docs/get-started/install) installed
- Android Studio or VS Code with Flutter extension
- A connected emulator or physical device

### 2️⃣ Clone the Repository

```bash
git clone https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
cd YOUR_REPO_NAME
```

### 3️⃣ Install Dependencies

```bash
flutter pub get
```

### 4️⃣ Run the App

```bash
flutter run
```


## 📂 Project Structure

```bash
lib/
 ├── data/
 │    ├── database.dart        # Player database logic
 │    ├── gamemodes.dart       # Game mode definitions
 ├── pages/
 │    ├── add_player.dart      # Add player screen
 │    ├── game_modes.dart      # Game mode selection screen
 │    ├── player_picker.dart   # Wheel screen logic & UI
 │    ├── premium_page.dart    # Premium game mode screen
 │    ├── players_page.dart    # Player list screen
 │    └── truth_or_dare_pick_screen.dart   # Truth or Dare selection screen
 ├── util/
 │    ├── game_mode_selector.dart # Game mode logic & UI
 ├── widgets/
 │    ├── player_tile.dart     # Player tile UI
 │    ├── game_mode_tile.dart  # Game mode tile UI
 │    ├── add_button.dart      # Add player button UI
 │    ├── buttom_button.dart   # Bottom button UI
 │    ├── game_mode_tile.dart  # Game mode tile UI
 │    ├── game_mode_selector.dart # Game mode logic & UI
 │    ├── gender_selector.dart # Gender selector UI
 │    ├── interaction_icons.dart # Interaction icons UI
 │    ├── name_input_field.dart # Name input field UI
 │    ├── player_tile.dart     # Player tile UI
 │    ├── premium_button.dart  # Premium button UI
 │    └── wheel_tile.dart      # Wheel tile UI
 ├── main.dart                 # App entry point
```

## 🛠 Technologies Used

- **[Flutter](https://flutter.dev/)** – Cross-platform UI toolkit for building mobile apps.
- **[Hive](https://pub.dev/packages/hive)** – Lightweight, fast NoSQL database for storing player data.
- **[hive_flutter](https://pub.dev/packages/hive_flutter)** – Hive integration with Flutter.
- **[cupertino_icons](https://pub.dev/packages/cupertino_icons)** – iOS-style icons for a polished look.
- **[flutter_svg](https://pub.dev/packages/flutter_svg)** – Render SVG images for scalable graphics.
- **[flutter_emoji](https://pub.dev/packages/flutter_emoji)** – Emoji support for fun and expressive UI.
- **[smooth_page_indicator](https://pub.dev/packages/smooth_page_indicator)** – Animated page indicators for onboarding or mode selection.
- **[google_fonts](https://pub.dev/packages/google_fonts)** – Access to 1,000+ Google Fonts.
- **[flutter_fortune_wheel](https://pub.dev/packages/flutter_fortune_wheel)** – Animated spinning wheel for random player selection.
