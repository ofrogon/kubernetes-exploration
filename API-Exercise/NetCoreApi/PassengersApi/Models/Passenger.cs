using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using CsvHelper.Configuration.Attributes;


namespace PassengersApi.Models
{
    [Table("Passengers", Schema = "dbo")]
    public class Passenger
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        [Display(Name = "Id")]
        [Ignore]
        public int Id { get; set; }

        [Required]
        public int Survived { get; set; }

        [Required]
        public int Pclass { get; set; }

        [Required]
        [MaxLength(100)]
        public string Name { get; set; }

        [Required]
        [MaxLength(10)]
        public string Sex { get; set; }

        [Required]
        public double Age { get; set; }

        [Required]
        [Name("Siblings/Spouses Aboard")]
        public int SiblingsSpouses { get; set; }

        [Required]
        [Name("Parents/Children Aboard")]
        public int ParentsChildren { get; set; }

        [Required]
        public double Fare { get; set; }
    }
}