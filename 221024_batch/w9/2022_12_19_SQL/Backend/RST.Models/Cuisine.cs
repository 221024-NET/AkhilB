using System.ComponentModel.DataAnnotations;

namespace RST.Models;

public class Cuisine 
{
    [Key]
    public int? cuisID {get;set;}
    public int? restID {get;set;}
    public string? cuisName {get;set;}
}