
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using Microsoft.IdentityModel.Tokens;
using Takvim.Api.DTOs.Auth;
using Takvim.Api.Models;

namespace Takvim.Api.Services;

public class JwtTokenService
{
    private readonly IConfiguration _config;

    public JwtTokenService(IConfiguration config)
    {
        _config = config;
    }

    public AuthResponse CreateToken(AppUser user)
    {
        var key = _config["Jwt:Key"]
            ?? throw new InvalidOperationException(
                "JWT anahtarı tanımlı değil.");

        var issuer = _config["Jwt:Issuer"]
            ?? throw new InvalidOperationException(
                "JWT issuer tanımlı değil.");

        var audience = _config["Jwt:Audience"]
            ?? throw new InvalidOperationException(
                "JWT audience tanımlı değil.");

        var expires = DateTime.UtcNow.AddHours(2);

        var claims = new List<Claim>
        {
            new(JwtRegisteredClaimNames.Sub,
                user.Id.ToString()),
            new(JwtRegisteredClaimNames.Jti,
                Guid.NewGuid().ToString()),
            new(ClaimTypes.NameIdentifier,
                user.Id.ToString()),
            new(ClaimTypes.Name, user.Name),
            new(ClaimTypes.Role, user.Role)
        };

        var credentials = new SigningCredentials(
            new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(key)),
            SecurityAlgorithms.HmacSha256
        );

        var jwt = new JwtSecurityToken(
            issuer: issuer,
            audience: audience,
            claims: claims,
            expires: expires,
            signingCredentials: credentials
        );

        var token = new JwtSecurityTokenHandler()
            .WriteToken(jwt);

        return new AuthResponse(
            token,
            expires,
            user.Id,
            user.Name,
            user.Email,
            user.Role
        );
    }
}
