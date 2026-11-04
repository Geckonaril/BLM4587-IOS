
using System.ComponentModel.DataAnnotations;

namespace Takvim.Api.DTOs.Auth;

public class RegisterRequest
{
    [Required, StringLength(100, MinimumLength = 2)]
    public string Name { get; set; } = "";

    [Required, EmailAddress, MaxLength(254)]
    public string Email { get; set; } = "";

    [Required, MinLength(10), MaxLength(128)]
    public string Password { get; set; } = "";
}
