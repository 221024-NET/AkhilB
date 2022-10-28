using System;
using PokemonApp;

namespace Program{

    class Program{

        static void Main(string[] args)
        {
            //Initializing an object
            //We call the constructor, and pass it the desired values for this object

            //Pokemon pikachu = new Pokemon("Pikachu", 25, "Electric", 12, "Static");
            //Pokemon pikachu2 = new Pokemon("Pikachu", 25, "Electric", 12);
            //Pokemon charizard = new Pokemon("Charizard");
            string? inp;
            int  teamsize=6;
            Pokemon[] team = new Pokemon[teamsize];
            Console.WriteLine("Give "+teamsize+" pokemon for your team.");
            Console.WriteLine("Provide a name, Dex number, type, HP, & ability.");
            Console.WriteLine("Enter nothing to add a Ditto instead.");
            Console.WriteLine("ex. Charizard\n6\nFire\n78\nBlaze");
            for (int i=0;i<teamsize;i++){
                Console.WriteLine("\nPokemon #"+(i+1)+": ");
                inp = Console.ReadLine();

                team[i] = new Pokemon();
                if (inp!="") team[i].Name=inp;
                inp=Console.ReadLine();
                if (inp != ""){
                    //not blank input means more fields
                    team[i].DexNumber = stoi(inp);
                    team[i].Type = Console.ReadLine();
                    team[i].Health = stoi(Console.ReadLine());
                    team[i].Ability = Console.ReadLine();
                }
            }//team filled

            Console.WriteLine("Reading out team:\n");
            for (int i=0;i<teamsize;i++){
                Console.WriteLine("#"+(i+1));
                Console.Write(String.Format("Name: {0} | Dex Number: {1} | Type: {2} | Health: {3} | Ability: {4}\n", team[i].Name, team[i].DexNumber, team[i].Type, team[i].Health, team[i].Ability));
            }

            //Calling an Instance method - belongs to the object itself.
            //Called by using object.method() 

            //pikachu.PrintName();
            //pikachu2.PrintName();
            //charizard.PrintName();

            //Calling a Static method - belongs to the class.
            //Called by using Class.method()
            //Pokemon.PrintMessage();

            //Accessing a Static field - belongs to the class.
            //Called by referencing the class itself.
            //Console.WriteLine(Pokemon.isPokemon);


            //Console.WriteLine(pikachu.ToString());

            //Console.WriteLine(pikachu.name);

        }

        //Attempts to parse user input to int, repeats until number is entered
        public static int stoi(string? s){
            int toint;
            bool goodparse = Int32.TryParse(s, out toint);
            while (!goodparse){
                Console.Write("Not a number. Reenter: ");
                goodparse = Int32.TryParse(Console.ReadLine(), out toint);
            }
            return toint;
        }
        

    }

}