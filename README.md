Building a Hangman game for one player against the computer

1 - Load the dictionary file
2 - Convert dictionary to an array and select a word at random which is between 5 and 12 characters long
3 - Display the number of blanks and guesses available 
    Ex. word is notification
    Display: _ _ _ _ _ _ _ _ _ _ - 0/7 guesses
    - store as 2 arrays, one of word and one for display_word
4 - Player takes a turn by entering a single letter
  - Check against word array
  - if letter is included, then update display to show letter
  - Add to the 0/7 guesses counter
5 - At start of turn ask the player if they want to save game
  - If no save -> continue to input guess
  - If yes save -> serialize the data and save to a file
6 - On initial program load, prompt the user to select a saved game
  - This option should display all saved games
  - Load saved game and continue playing
