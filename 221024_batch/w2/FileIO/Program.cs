namespace Wordle{

    public class Program {
        //consider some struct/class that's just a string and some ConsoleColors

        public static void Main(string[] args){
            string fpath="./testFile.txt";
            string[] words = File.ReadAllLines(fpath);
            var rand = new Random();
            //random word from the list
            string secret = words[rand.Next(words.Length)].ToLower().Trim();
            bool solved=false;
            int turns=0;
            string guess;
            //potential array of past guesses to be displayed on every turn's end
            //ColorString[] guesses = new ColorString[6];
            ConsoleColor[] feedback = {ConsoleColor.Gray,ConsoleColor.Gray,ConsoleColor.Gray,ConsoleColor.Gray,ConsoleColor.Gray};
            
            //Get a user
            User player = GetUser();

            //game loop
            while(turns<6){
                Console.WriteLine("Guess: ");
                guess = Console.ReadLine().ToLower();
                if (guess==null || guess.Length!=5){
                    Console.WriteLine("Invalid guess. Must be a 5-letter word");
                    continue;
                }//end of if
                //guesses[turns].S=guess;
                turns++;

                //wrong guess, give feedback
                for (int i=0;i<5;i++){
                    //guessed letter in the right place
                    if (guess[i]==secret[i]) {
                        Console.WriteLine("This {0} is in the right place",guess[i]);  
                        feedback[i]=ConsoleColor.Green;   
                        //guess[turns].setCharColor(ConsoleColor.Green,i);
                    }            
                    
                    //guessed letter wrong
                    //letter is or isn't in the word
                    else {
                        Console.WriteLine("The word {0} contain {1}",secret.Contains(guess[i])?"does":"does not",guess[i]);
                        feedback[i]=secret.Contains(guess[i])?ConsoleColor.Yellow:ConsoleColor.Gray;
                        /*
                        if secret.Contains(guess[i]) guesses[turns].setCharColor(ConsoleColor.Yellow,i);
                        //default color is gray so no need to set there 
                        */
                    }
                }//end of for
                //print the colored guess
                /*If ColorString works just use the given method instead*/
                for (int i=0;i<5;i++){
                    printcolor(guess[i],feedback[i]);
                    Console.BackgroundColor=ConsoleColor.Black;
                }
                Console.Write("\n");

                //correct guess
                if (guess==secret) {
                    solved=true;
                    break;
                }//end of if
            }//end of while

            Console.Write(solved?"Solved ":"Not solved ");
            Console.Write("within {0} turn(s). The word was: {1}\n",turns,secret);

            //Update Played, Wins (if user won), turnsPerWin(if user won)
            player.Played++;
            if (solved) {
                player.Wins++;
                player.incTurns(turns-1);
            }
            Console.Write(player.ToString());
        }

        //Print a char with a specific background color
        private static void printcolor(char c, ConsoleColor cc){
            Console.BackgroundColor=cc;
            Console.Write("{0}",c);
        }

        private static User GetUser(){
            //get User info
            string userpath = "./.Users.txt";
            User u;
            string user, pass="";
            Console.WriteLine("Enter a username:");
            user = Console.ReadLine();
            
            //if User recognized, prompt password and load user
            Console.WriteLine("User {0} found. Enter a password",user);
            //while()

            //User not recognized, make new User
            u = new User(user, pass);

            return u;
        }
    }
        
 }




