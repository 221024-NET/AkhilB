
using System.Text;

namespace MinAPIClient.Logic
{
    public class Person
    {
        public int Id { get; set; }
        public string Fname { get; set; }
        public string Lname { get; set; } 

        public Person() { }

        public Person(int id, string fn, string ln)
        {
            Id = id;
            Fname = fn;
            Lname = ln;
        }

        public override string ToString()
        {
            StringBuilder sb = new();

            sb.AppendLine($"ID: {Id}\nName: {Fname} {Lname}");
            return sb.ToString();
        }
    }
}