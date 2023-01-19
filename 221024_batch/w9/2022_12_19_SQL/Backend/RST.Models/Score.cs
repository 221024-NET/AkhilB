using System.ComponentModel.DataAnnotations;

namespace RST.Models;

public class Score
{
    [Key]
    public int? refID { get; set; }
    public int? restID { get; set; }
    public int? points { get; set; }
    public DateTime? reviewdate { get; set; }
}