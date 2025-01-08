# weather_app_programazione_exam_1

A weather app for the PDMIU assignment 

## 

A. DOUIRI MOUHEB , matricola : 338763.
----------------------------------------------------------------------------------------------------
B. Weather app ( for the Mobile Devices And UI Programming ).
----------------------------------------------------------------------------------------------------
C. The Weather App is a user-friendly application designed to provide real-time weather updates 
for any city entered by the user.
Main Features are City-Specific Weather Updates, Dark/Light Theme Support and both English 
and Italian language support 
----------------------------------------------------------------------------------------------------
D. User experience overview:
( you can find screenshots in the README screenshots folder )
-- Searching for Weather in a City:
At the top-right of the app's main screen, there is a search icon when clicked a search bar pops up,
Users simply type the name of a city into the search bar and press the "Search" button
The app instantly fetches and displays the current weather conditions 
and a brief description (e.g., "Clear skies").

-- Switching Between Dark and Light Themes:
Users can toggle between dark and light themes via a theme button 
located in the settings menu in the top-left corner of the app.
The selected theme is applied immediately across the interface for a personalized experience.

-- Changing the Language:
A language selector ( dropdown menu ) is available in the app’s settings.
Users can select between English and Italian by clicking their desired language. 
The app refreshes and displays all text in the chosen language.

-- Viewing Additional Weather Details:
The main weather display includes a "More Info" button.
By clicking this, users can view additional details, such as wind speed, sunrise/sunset times ...
----------------------------------------------------------------------------------------------------

E. Technology:

-- provider ^6.0.5 :
Manages state efficiently, ensuring the app can handle theme changes (light/dark), 
language switching, and weather data updates without unnecessary rebuilds.
-- intl ^0.19.0: 
Facilitates internationalization, enabling dynamic switching between English and Italian. 
This package is essential for formatting dates, times, and other localized content.
-- flutter_localizations: Integrates Flutter's localization APIs, 
making it easier to handle multilingual support and adapt UI content to the selected language.
-- shared_preferences ^2.0.17: 
Stores user preferences for the selected theme (dark/light) and language, 
ensuring these settings persist across sessions.
-- flutter_spinkit  ^5.1.0: 
Provides elegant loading animations while fetching weather data, enhancing user experience.
-- lottie ^3.2.0: Supports rich and interactive animations, used for weather-related visuals 
-- http ^1.2.2: Handles API requests to fetch real-time weather data from a remote weather service.
(openweathermap's Free API)
-- fluttertoast ^8.2.1: Displays toast messages for actions like errors
(e.g., invalid city name or failed network requests).
----------------------------------------------------------------------------------------------------

