# Word-Nerd
This is a personal project created as a capstone for the Udacity iOS Nanodegree program. 

The purpose of Word-Nerd is to help the user increase their vocabulary. This is done by presenting the user with a new word each day, by allowing them to randomly update the word, or by letting them search for a specific word. The users can also save the words in different, specific lists, so that they can go back and learn them. 


# Features
The first feature of this app is "Today's Word". On the first screen, the app displays the word of the day and its definition which are both updated each day. From there, the user has the option to save the word. If they tap "Save Word" they are navigated to a table of lists.
This brings us to our next feature: lists. The user can add a list and name it what they'd like. This makes making categories of words easier for users. After adding a list, when they tap on it, their saved word will be added to that list. Tapping on the list will display all the words saved for that list. 
The user also has the ability to delete saved words or the lists containing the saved words by sliding left on them. 
Navigating back to the first screen, the user has three other feature options. The first is "View Saved Lists". This allows the user to view their saved lists and words without saving the current displayed word. 
The second option is "New Word". This will update the view with a new random word and definition. The user can now save this word by tapping on "Save Word".
The last feature is "search" which can be done by tapping the search icon on the top right-hand corner of the screen. Tapping on search will present a new view where the user can enter any word they like and search for its definition. If a definition is found, the user is returned to the first screen where the word and definition are now updated. They can now save this word by tapping on "Save Word". If no definition is found, an error appears and the user remains on the search screen.


# Usage
This app requires the user to have Xcode installed or have an iOS device. Fork the repo to your computer and either run it with an iOS simulator or drop the file onto your device. 

# Note
This app integrates with the Wordnik API. Currently, their "search" endpoint is down. Because of this, I integrated with the Merriam-Webster dictionary API to search for definitions. The Wordnik api is still used to return a random word when the user taps on "new word", but the Merriam-Webster dictionary does not have a definition for all wordnik words. This is handled by an alert, but you may have to go through a few alerts before it returns a random word that the Merriam-Webster dictionary API does have a definition for. 
I have included commented out code that would have used the wordnik API search endpoint if the endpoint was functional. I also reached out to their API team to get an estimate on how long it will be down, and they said until the end of the year (2019). Once the endpoint is functional, I can uncomment out that code and the rate of words with no definitions should go down a lot. 
