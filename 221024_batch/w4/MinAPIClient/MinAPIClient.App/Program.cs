
using MinAPIClient.Logic;
using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;

namespace MinAPIClient.App
{
    public class Program
    {
        static HttpClient client = new HttpClient();

        public static void Main(string[] args)
        {
            RunAsync().GetAwaiter().GetResult();
        }

        static async Task RunAsync()
        {
            client.BaseAddress = new Uri("https://localhost:7289/");
            client.DefaultRequestHeaders.Accept.Clear();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

            try
            {
                var people = await GetAllPeople();
                foreach (var p in people)
                {
                    ShowPerson(p);
                }

                //create a new person
                Person person = new Person
		{
			Id=5;
			Fname="Xander";
			Lname="Xiles";
		};

                //make person
                var url = await CreatePersonAsync(person);
                Console.WriteLine($"Created at {url}");

                //get person
                person = await GetPersonAsync(url.ToString());
                ShowPerson(person);

                Console.WriteLine("Person record created. Please check in DB...");
                Console.WriteLine("Press any key to Update the record...");
                Console.ReadLine();

                //Update now
                Console.WriteLine("Updating First Name...");
                person.Fname = "Samuel";
                await UpdatePersonAsync(person);

                //get the updated person
                person = await GetPersonAsync(url.ToString());
                ShowPerson(person);

                //delete the person
                var statuscode = await DeletePersonAsync(person.Id);
                Console.WriteLine($"Deleted (HTTP Status = {(int)statuscode})");
                Console.WriteLine("Press any key to exit...");
            }
            catch (Exception e)
            {
                Console.WriteLine(e.Message);
            }
            Console.ReadLine();
        }

        static async Task<List<Person>> GetAllPeople()
        {
            List<Person> result = new();
            var path = "people";
            HttpResponseMessage response = await client.GetAsync(path);
            if (response.IsSuccessStatusCode) result = await response.Content.ReadAsAsync<List<Person>>();

            return result; 
        }

        static void ShowPerson(Person p)
        {
            Console.WriteLine(p.ToString());
        }

        static async Task<Uri> CreatePersonAsync(Person p)
        {
            HttpResponseMessage response = await client.PostAsJsonAsync("people", p);
            response.EnsureSuccessStatusCode();

            return response.Headers.Location;
        }

        static async Task<Person> GetPersonAsync(string path)
        {
            Person person = null;
            HttpResponseMessage response = await client.GetAsync(path);
            if (response.IsSuccessStatusCode) person = await response.Content.ReadAsAsync<Person>();
            return person;
        }

        static async Task<Person> UpdatePersonAsync(Person person)
        {
            HttpResponseMessage response = await client.PutAsJsonAsync(
                $"people/{person.Id}", person);
            response.EnsureSuccessStatusCode();

            //deserialize the person
            person = await response.Content.ReadAsAsync<Person>();
            return person;
        }

        static async Task<HttpStatusCode> DeletePersonAsync(long id)
        {
            HttpResponseMessage response = await client.DeleteAsync($"categories/{id}");
            return response.StatusCode;
        }
    }
}
