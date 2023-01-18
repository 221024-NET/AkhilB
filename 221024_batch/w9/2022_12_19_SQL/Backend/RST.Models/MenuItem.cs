using System.ComponentModel.DataAnnotations;

namespace RST.Models;

public class MenuItem 
{
    [Key]
    public int? itemID {get;set;}
    public int? restID {get;set;}
    public string? itemName {get;set;}
    public string? itemDescription {get;set;}
    public decimal? price {get;set;}
}