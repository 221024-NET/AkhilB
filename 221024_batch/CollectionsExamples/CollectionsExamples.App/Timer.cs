

namespace CollectionsExamples.App {
    public class Timer {
        //Fields

        //Constructors
        public Timer(){}

        //Methods

        ///represents a time-intensive action
        ///
        ///start timer
        ///do action
        ///stop timer
        public TimeSpan Run(){
            //start
            DateTime start = DateTime.Now;

            //action
            Demo temp = new Demo();
            temp.getDifferences();
            //stop
            DateTime stop = DateTime.Now;

            TimeSpan ts = stop-start;
            return ts;
        }
    }
}