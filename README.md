# BuzzNews

BuzzNews is a modern, *Gemini* integrated news application designed to keep users informed with the latest news from around the world. With a wide range of categories and powerful content generation tools, BuzzNews delivers a personalized and engaging news experience.

## Features

- **News Updates**: Get the latest news across various categories including Technology, Business, Sports, Entertainment, and more.
- **Personalized News Feed**: Customize your news feed based on your preferred language and country.
- **Article Descriptions**: Summarized and informative descriptions of news articles generated using the Gemini API.
- **Daily Highlights**: Quick access to the most important news events of the day, curated and enhanced by the Gemini API.
- **Search Functionality**: Find specific news articles and topics with ease, powered by the Gemini API to deliver relevant summaries.
- **Seamless Navigation**: Intuitive and user-friendly interface with easy navigation between different sections.
- **No Offline Support**: BuzzNews requires an active internet connection to function. It does not support offline usage.

## API Integration (Gemini & NewsData.io)

BuzzNews leverages the [Gemini API](https://ai.google.dev/gemini-api/docs) to enhance the user experience in the following ways:

1. **Article Descriptions**: The Gemini API generates short, informative descriptions for each news article, helping users quickly understand the content.
2. **Daily Highlights**: Every day, the Gemini API curates a list of highlights, giving users an overview of the most critical news events.
3. **Search Summaries**: When users search for specific topics, the Gemini API processes the results to present the most relevant and concise summaries.

Additionally, BuzzNews uses the [Newsdata.io API](https://newsdata.io) to fetch the latest news articles, ensuring that users receive up-to-date information from trusted sources.

## Usage

- **Settings**: Users can customize their language and country preferences in the settings page. Currently, Hindi is not available.
- **Navigation**: The app uses a bottom navigation bar for easy access to different sections, including the Feed, Search, and Home.
- **Swipeable News**: Swipe through articles in the Feed page for a smooth reading experience.

## Dependencies

BuzzNews uses the following Flutter packages:

- `GetX`: For state management.
- `http`: For making API requests.
- `flutter_markdown`: For rendering markdown content.
- `shared_preferences`: For storing user preferences.
- `google_generative_ai`: For integrating Gemini.
- `shimmer`: For cool loading animations.

## Demo

Watch a video of the app in action: [BuzzNews App Demo](https://youtu.be/azluSnlKGkg)

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/c9e78542-3d48-4321-8f00-9d46b4f99d71" width="200" />
  <img src="https://github.com/user-attachments/assets/bc57eb13-177f-41dd-8e7a-0da7302f7f18" width="200" />
  <img src="https://github.com/user-attachments/assets/6b57791b-f127-4903-a9a9-03a214926303" width="200" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/34a948e8-cba5-4f04-bc40-3507208e5312" width="200" />
  <img src="https://github.com/user-attachments/assets/bb0b2151-8487-441d-bb6a-ef98c73bc97a" width="200" />
  <img src="https://github.com/user-attachments/assets/eccd1015-197e-4d41-a620-d8402f4a8814" width="200" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/7ebbaea6-dd1b-46c6-a271-d77a9b8315c7" width="200" />
  <img src="https://github.com/user-attachments/assets/480e56bc-e9e0-4b46-8ea1-2289e36a237e" width="200" />
  <img src="https://github.com/user-attachments/assets/0ad3af44-976c-43cd-930c-6aab425a8a1d" width="200" />
</p>
