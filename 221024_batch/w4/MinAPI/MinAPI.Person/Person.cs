using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MinAPI.Logic
{
    public class Person
    {
        public int Id { get; set; }
        public string? Fname { get; set; }
        public string? Lname { get; set; }

        public Person() { }

        public override string ToString()
        {
            StringBuilder sb = new();

            sb.AppendLine($"ID: {Id}\nName: {Fname} {Lname}");
            return sb.ToString();
        }
    }
}
