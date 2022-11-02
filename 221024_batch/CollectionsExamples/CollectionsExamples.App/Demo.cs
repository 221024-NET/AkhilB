namespace CollectionsExamples.App{

    public class Demo{
        //Fields
        DateTime[] arr = new DateTime[5];

        //Constructors
        public Demo(){
            for (int i=0;i<arr.Length;i++){
                arr[i]=DateTime.Now;
            }
        }
        //Methods
        public TimeSpan[] getDifferences(){
            TimeSpan[] ts = new TimeSpan[arr.Length-1];
            for (int i=0;i<ts.Length;i++){
                //arr[i] -> start time
                //arr[i+1] -> end time
                ts[i] = arr[i+1]-arr[i];
            }
            return ts;
        }
    }
}