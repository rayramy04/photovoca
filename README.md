# PhotoVoca

English | [日本語](README_JP.md)

<p align="center">
  <img src="assets/images/logo.png" alt="PhotoVoca Logo" width="200"/>
</p>

A Flutter application that transforms everyday objects into English vocabulary learning opportunities through camera-based object recognition.

**🏆 Excellence Award Winner at [RSS Hackathon 2025 Beyond "あたりまえ"の、その先へ](https://www.craftstadium.com/hackathon/rss-hackathon-2025-beyond) - September 7, 2025**

## Overview

PhotoVoca is a mobile app that helps users learn English vocabulary by simply taking photos of objects around them. By combining Google ML Kit's object detection with Gemini AI's description generation, it creates an engaging and memorable learning experience that connects visual recognition with language acquisition.

## Key Features

### Camera & Object Recognition
- Real-time object detection powered by Google ML Kit
- Automatic cropping of detected objects
- Multiple object selection from a single photo

### AI-Powered Content Generation
- Gemini AI generates English names and descriptions
- Context-aware practical example sentences
- Visual-linguistic association for better retention

### Flashcard Learning System
- Captured objects saved as flashcards
- Tap to reveal answers
- Swipe navigation between cards
- Learning history tracking

### Data Management
- Local SQLite database storage
- Persistent learning history
- Offline learning capability

## Tech Stack

- **Framework**: Flutter 3.8.1+
- **State Management**: Riverpod 2.5.1
- **Routing**: go_router 14.3.0
- **AI/ML**:
  - Google Generative AI (Gemini) 0.4.7
  - Google ML Kit Object Detection 0.14.0
- **Camera**: camera 0.11.0+
- **Database**: Drift (SQLite) 2.21.0
- **Image Processing**: image 4.2.0

## Setup

### Prerequisites
- Flutter SDK 3.8.1 or higher
- iOS 12.0+ / Android API level 21+
- Gemini API key

### Installation

1. Clone the repository
```bash
git clone https://github.com/rayramy04/photovoca.git
cd photovoca
```

2. Configure environment variables
Create a `.env` file in the project root with your Gemini API key
```
GEMINI_API_KEY=your_api_key_here
```

3. Install dependencies
```bash
flutter pub get
```

4. Run code generation
```bash
flutter pub run build_runner build
```

5. Launch the app
```bash
flutter run
```

## Project Structure

```
lib/
├── app/              # Application configuration
│   └── router.dart   # Routing setup
├── features/         # Feature modules
│   ├── camera/       # Camera & object recognition
│   ├── home/         # Home screen
│   └── quiz/         # Quiz & flashcard functionality
├── infrastructure/   # Infrastructure layer
│   └── database/     # Database implementation
└── main.dart         # Entry point
```

## How to Use

1. Launch the app and select "Camera" from the home screen
2. Point your camera at objects you want to learn
3. Select detected objects from the overlay
4. Review the AI-generated English name and description
5. Start "Quiz" mode to practice with flashcards
6. Tap cards to reveal answers, swipe to navigate

## Roadmap

- Voice pronunciation feature
- Learning progress visualization
- Category-based vocabulary organization
- Multi-language support
- Cloud synchronization

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## Contact

For questions or suggestions, please open an issue on GitHub.