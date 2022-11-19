using MinAPI.Logic;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Text;
using System.Threading.Tasks;

namespace MinAPI.Data
{
    public class SqlRepo
    {
        //private string _connectionstring;

        public SqlRepo()
        {
            
        }

        public IEnumerable<Person> getAllPersons(string connectionstring)
        {
            //this._connectionstring = connectionstring;

            List<Person> result = new();
            using (SqlConnection connection = new SqlConnection(connectionstring))
            {
                SqlCommand cmd = new("SELECT * FROM Min.Person;", connection);
                connection.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    Person p = new();
                    p.Id = reader.GetInt32(0);
                    p.Fname = reader.GetString(1);
                    p.Lname = reader.GetString(2);

                    result.Add(p);
                }
                reader.Close();
                cmd.Dispose();
            }

            return result;
        }

        public Person Create(string connectionstring, string fname, string lname)
        {
            //this._connectionstring = connectionstring;
            using SqlConnection connection = new SqlConnection(connectionstring);
            connection.Open();

            string cmdS = @"INSERT INTO Min.Person (f_name, l_name) VALUES (@fn, @ln);";

            using SqlCommand cmd = new(cmdS, connection);

            cmd.Parameters.AddWithValue("@fn", fname);
            cmd.Parameters.AddWithValue("@ln", lname);

            cmd.ExecuteNonQuery();

            cmdS = "SELECT * FROM Min.Person WHERE f_name = @fn AND l_name = @ln;";

            using SqlCommand cmd2 = new(cmdS, connection);

            cmd2.Parameters.AddWithValue("@fn", fname);
            cmd2.Parameters.AddWithValue("@ln", lname);

            using SqlDataReader reader = cmd2.ExecuteReader();

            Person tmp;
            while (reader.Read())
            {
                Person p = new();
                p.Id = reader.GetInt32(0);
                p.Fname = reader.GetString(1);
                p.Lname = reader.GetString(2);
                return tmp = p;
            }
            connection.Close();
            Person noPerson = new();
            return noPerson;
        }

        public Person Get(string connectionstring, int ID)
        {
            //this._connectionstring = connectionstring;
            var person = new Person();
            using SqlConnection connection = new SqlConnection(connectionstring);
            connection.Open();

            string cmdS = "SELECT * FROM Min.Person WHERE ID=@id;";

            using SqlCommand cmd = new(cmdS, connection);
            cmd.Parameters.AddWithValue("@id", ID);

            using SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                person.Id = reader.GetInt32(0);
                person.Fname = reader.GetString(1);
                person.Lname = reader.GetString(2);
            }

            connection.Close();

            if (person != null) return person;
            else return null;
        }

        public void Update(string connectionstring, int id, Person person)
        {
            using SqlConnection connection = new SqlConnection(connectionstring);

            string cmdS = $"UPDATE Min.Person SET ID ='{person.Id}', f_name='{person.Fname}', l_name='{person.Lname}' WHERE ID={id};";
            SqlCommand cmd = new SqlCommand(cmdS, connection);
            connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            connection.Close();
            return;
        }

        public void Delete(string connectionstring, int id)
        {
            using SqlConnection connection = new SqlConnection(connectionstring);

            string cmdS = $"DELETE FROM Min.Person WHERE ID={id};";

            SqlCommand cmd = new SqlCommand(cmdS, connection);
            connection.Open();
            cmd.ExecuteNonQuery();
            cmd.Dispose();
            connection.Close();

            return;
        }
        
    }
}
