using System.Text;

namespace Wordle {

    public class User{
        //Fields
        public string Name {get;set;}
        public string Pass {get;set;}
        public int Wins {get;set;}
        public int Played {get;set;}
        public int[] turnsPerWin = new int[6];

        //Constructors
        public User(string n, string p){
            Name=n;
            Pass=p;
            Wins=0;
            Played=0;
            for (int i=0;i<6;i++){
                turnsPerWin[i]=0;
            }
        }

        //Methods
        public int[] getTurns(){
            return turnsPerWin;
        }
        public void incTurns(int index){
            turnsPerWin[index]++;
        }

        //return the win% as a double
        public double winRate(){
            return (float)Wins/Played*100.0;
        }

        //return average number of turns per win
        public double avgTurns(){
            float sum=0;
            for (int i=1;i<=6;i++){
                sum += (float)turnsPerWin[i-1]*i;
            }
            return sum/Wins;
        }

        //to string
        public override string ToString()
        {
            StringBuilder result = new StringBuilder();
            result.Append("------------------------\n");
            result.AppendLine("User: "+Name);
            result.AppendLine("Played: "+Played.ToString());
            result.AppendLine("Wins: "+Wins.ToString());
            double wr = winRate();
            result.AppendLine("Win Rate: "+wr.ToString()+"%");
            double avg = avgTurns();
            result.AppendLine("Average Turns per Win: "+avg.ToString());
            result.AppendLine("Win Distribution\n_______________________");
            for (int i=1; i<=6;i++){
                result.AppendLine(i.ToString()+": "+turnsPerWin[i-1].ToString());
            }
            result.AppendLine("_______________________");

            return result.ToString();
        }
    }
}