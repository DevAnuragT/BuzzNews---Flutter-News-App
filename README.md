
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

## API Integration

BuzzNews leverages the [Gemini API](https://ai.google.dev/gemini-api/docs
) to enhance the user experience in the following ways:

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

Watch a video of the app in action: [BuzzNews App Demo](#)

---
