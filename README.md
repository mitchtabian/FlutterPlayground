# Flutter Playground
Playing around with flutter. Figuring out if it is for babies or not.


# This app
**Expense Tracker**
![Screenshot](https://raw.githubusercontent.com/mitchtabian/FlutterPlayground/Expense-Tracker/assets/images/app_screenshot.png | width=250)

# Resources:
1. Travel Information app:
	- https://www.youtube.com/watch?v=pTJJsmejUOQ
2. Flutter and Dart - The Complete Guide:
	- https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps
3. Widget catalog:
	- https://flutter.dev/docs/development/ui/widgets
4.


# Continue
1. https://www.udemy.com/course/learn-flutter-dart-to-build-ios-android-apps/learn/lecture/14951040#content



# Third Party libs
1. Dates
	- Intl: https://pub.dev/documentation/intl/latest/
2.



# Questions
1. Debugging
2. state
3. architecture?
	- block pattern?
4. Testing?
5. Restoring list position? (after rotation/background or forward/back navigation)
6. Dialog behavior on rotation/background
7. ListView performance
	1. Does is load everything even if not visible?
		- ListView.builder() vs ListView(children: [])
8. Asynchronous work?
	- Is there a "main thread" issue?
9. Memory leaks?
    - Can you leak memory?
    - how can you detect? (ex: Leak Canary on android)



# Things I like
1.




# Day 1 (June 2)
1. Kinda neat. Interesting state management

# Day 2 (June 3)
1. I like how some color opacity's come prebuilt as constants.
	- ex: black12, black26, black87, etc..
	- makes things more consistent across different apps.
	- Gives description. Ex: "This is a good constrasting color for light themes."
2. Images
	- It is way easier to display a simple image. No third party library needed. No async knowledge.
3. Assets
	- Getting stuff from assets is much easier. No need for context or any of that BS. Just write the path and boom you got it.

# Day 3 (June 4)
1. Finished ListView + DetailView with static data example
	- https://github.com/mitchtabian/FlutterPlayground/tree/listview-static-data
	- I'm not amazed by this. I could have built the same thing on android with the same amount of code and time.
	- I guess the fact that it is **cross platform** is the real payoff.
2. Dates
	- https://pub.dev/packages/intl#-readme-tab-
	- Working with dates is very easy with intl third party library.
3. Inputs
	1. All inputs must be Strings?
		- Obviously I don't like this. b/c you have to do the conversions yourself after the fact.
4. SingleChildScrollView
	- Like a ScrollView?
	- This is cool. It would be nice if a Recyclerview was this easy to hook up and delegate scroll behavior to the parent. Often times it has issues if multiple views that can detect gestures are involved. But I wonder... What is the performance like with a massive list? Say 1000 entries with media?

# Day 4 (June 11)
1. ListView
	- ListView.builder(itemBuilder: <>, itemCount: <>) will **not** load items that are not visible
		- This is the `Recyclerview` equivalent
		- itemBuilder: is the RecyclerView Adapter basically
	- ListView(children[]) will load ALL items, even if they are not visible on screen.
2. showModalBottomSheet(context: ctx, builder: (bCtx){})
	- This is a nice built-in widget for displaying a bottom sheet. Pretty convenient.
	- video: `91. Showing a Model Bottom Sheet` @ 7:55
3. Navigator
	1. Navigator.of(context).pop();
		- Navigator is a "global" navigation object? Like the backstack on android?
4. ThemeData(primarySwatch: Colors.purple)
	- This is cool. You can easily set the theme to a variety of pre-packaged material colors.
	- this isn't that much different than what native does though. You have a theme in stlyes.xml
	- *However* this is much less confusing than with android. There is so many different themes and sub-themes. Some don't work with others and cause problems. Flutter seems very straightforward.
	- video: `93: configuring and using themes`
5. Creating a Chart
	1. Creating/drawing shapes is extremely simple compared to native.
		- `100. Creating Bars for our Chart`
6. FittedBox widget
	- automatically shrinks text to fit a box
	- on android this would be difficult to implement. You'd have to calculate the space and manually set the text size based on testing. With Flutter there is a simple widget that does this.
7. showDatePicker(context: null, initialDate: null, firstDate: null, lastDate: null)
    - nice packaged way to show a date picker


# Day 5 (June 12)
1. trailing/leading attributes in a ListTile
    - Ex: (trailing) Trash can icon at the end of a list item layout. Convenient since this is very common
    - Ex: (leading) Something at the front of a list item layout. 
2. Nested Scrolling
    - If you have a SingleChildScrollView and a Listview inside it, it works as you would expect. Which is not the case on android. Scrolling is "difficult" to deal with regarding nesting.
    - But on flutter it is simple. Whichever widget you touch will scroll.
3. MediaQuery
    - This isn't better than what we have available on android. I prefer the layout designs using xml for this.
    1. holds information:
        - Screen pixel ratio
        - disable animations
        - brightness
        - size (width and height of device)
4. LayoutBuilder
    - can wrap a widget in this to apply constraints or get information about the sizing. Similar to ViewTreeObserver on android.
        - `119. Using the LayoutBuilder widget`
5. SystemChrome
    - Set allowed device orientations (force portrait only or landscape only)
    - system wide settings for application
    - `WidgetsFlutterBinding.ensureInitialized();` 
    - `SystemChrome.setPreferredOrientations(
             [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]
         );`
6. Build and Flutter Widget Tree
    - `137: Widget Tree & Element Tree`
7. Lifecycle states
    - `WidgetsBindingObserver`
    - How to listen for the various lifecycle states in a particular widget or app: `146. Understanding the App Lifecycle`


# Thoughts on Flutter
1. June 11
	- I think Flutter became very popular among "new" developers because:
		1. cross platform
		2. it's easier to hack something together that works. There aren't as many architectural patterns, architectures, etc... And much less judgement from the developer community. Like if you build a piece of shit on native and show the community, they will crucify you. But if you did the same thing with flutter, I doubt anyone would say much.
2. June 12
    - Nothing to say today. 
3. 
    
































