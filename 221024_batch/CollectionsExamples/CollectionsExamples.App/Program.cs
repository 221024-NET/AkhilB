using System;

namespace CollectionsExamples.App{
    public class Program{
        public static void Main(){
            Console.WriteLine("Collection Example Starting");
            Timer timer = new Timer();

            TimeSpan runtime = timer.Run();

            Console.WriteLine("Total time elapsed = {0}", runtime.TotalMilliseconds);
        }
    }
}
