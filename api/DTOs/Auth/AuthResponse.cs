
namespace Takvim.Api.DTOs.Auth;

public record AuthResponse(
    string Token,
    DateTime ExpiresAtUtc,
    int UserId,
    string Name,
    string Email,
    string Role
);
