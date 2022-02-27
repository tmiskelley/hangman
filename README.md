# Hangman
This CLI(Command Line Interface) Hangman game generates a random word from the given text file, and prompts the player to guess one letter at a time. The player is allowed 6 mistakes before the game results in a loss.

The Hangman game also has save and load functionality, allowing the player to save their progress after choosing to quit, or load their previous save at the beginning of the game. Choosing to save your game overwrites your previous save data.

# Code breakdown
Ruby's rand method is used to generate a random number between 0 and 9,893, selecting the correponding line in the dictonary.txt file to get the random word instance. When the class is initalized, it checks if the save file exists, and if it does, asks the player if they'd like to load their save. The main game loop is then entered, and continues running until the player either wins, looses, or quits. If the player quits, and they choose to save, the class instance variables are stored in a hash and written to a JSON file so they can load them in the future.