using System;

namespace PokemonApp{

    class Pokemon{
        
        //Fields - by default they are Private. 
        public string Name {get; set;}
        public int DexNumber {get; set;}
        public string? Type {get; set;}
        public int? Health {get; set;}
        public string? Ability {get; set;}

        //Static field - every pokemon shares this field and it's value
        public static string isPokemon = "This is a static field. We've been through this, I'm in fact a pokemon.";
        
        //Constructor - method used for object initialization. We pass it the values we want 
        //to set for the object we are creating.

        public Pokemon(string PokemonName, int PokemonNum, string PokemonType, int PokemonHealth=0, string PokemonAbility = "default?"){

            this.Name = PokemonName;
            this.DexNumber = PokemonNum;
            this.Type = PokemonType;
            this.Health = PokemonHealth;
            this.Ability = PokemonAbility;
        }


        public Pokemon(){
            Name="Ditto";
            DexNumber=132;
            Type="Normal";
            Health=48;
            Ability="Limber";
        }

        public Pokemon(string PokemonName){
            Name=PokemonName;
            this.DexNumber = 12;
        }

        //Instance method - depends on the state of an instance of that class. Belongs to the object. 
        public void PrintName(){
            Console.WriteLine("My name is " + this.Name + "." + " My number is " + this.DexNumber + ". My ability is " + this.Ability);

        }

        //Static method - belongs to the class itself
        public static void PrintMessage(){
            Console.WriteLine("This is a static method, and I am a pokemon.");
        }

        //Method Overriding - ToString()
        public override string ToString(){
            return this.Name + " " + this.Type;
        }
    }


}