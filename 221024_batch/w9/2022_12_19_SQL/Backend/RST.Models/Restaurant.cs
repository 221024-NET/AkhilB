using System.ComponentModel.DataAnnotations;

namespace RST.Models;

public class Restaurant
{
    [Key]
    public int? restID {get;set;}
    public string? rName {get;set;}
    public string? rAddress {get;set;}
    public string? rCity {get;set;}
    public string? rState {get;set;}
    public char? grade {get;set;}
}