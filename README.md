# iOS Engineering Academy by AFSE - Bull's Eye game project
  This is a project developed for Advantage FSE iOS Engineering Academy 2023.


The project is about a mobile game for iOS called Bull's Eye. The objective of the game is to move a slider as close to a randomly chosen target value as you can. Because you can’t see the current value of the slider, you’ll have to "eyeball" it. There are five different difficulty levels, each of which re-evaluates the slider's values in different ranges starting from 1, such as [1, 30], [1, 100], etc.

## Architecture
In order to organize our app's code to maintain it as concise, scalable, yet readable (and of course efficient), it has been divided into three different views, more specifically: 
* ViewController
* AboutViewController
* SettingsViewController
* HighScoreViewController

ViewController is the main screen and cooperates with all other view controllers. AboutViewController is the most simple as it only contains the game's objective. SettingsViewController is implemented as a Singleton design pattern since it is critical to ensure that only one instance of the class exists, as the difficulty level across the app is universal. In other words, it is an application-level functionality. The same goes for HighScoreViewController, as the score table should remain the same and track scores for all levels for the entire lifecycle of a game.

That being said, to maintain the code concise, many concepts of the Swift language were used, such as Extension, Protocol, Enum. Moreover, higher-order functions were used widely. Also, static/lazy/private/final declarations were used to make the app more scalable for future improvements/additions. In addition, force-unwrapping was used only in times where it was sure it won't cause any problems.

For all the screen views of the app, constraints were added to maintain the quality of the experience the same across all the different screen sizes, and all contents are evenly divided on the screen.

## Key features
* When user goes to settings and change the difficulty level, picker view is already showing the current difficulty level.
* When user modifies the slider and press settings button (info button also) and returns back without making any change to the level of the difficulty the screen view is not re-rendering all the components. That means, target value, already modified slider value and score/round counters remain the same.

## Contributors
* [Lefteris Kostakis](https://github.com/terrys48)
