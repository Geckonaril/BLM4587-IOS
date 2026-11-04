
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Takvim.Api.Data;
using Takvim.Api.DTOs.Auth;
using Takvim.Api.Models;
using Takvim.Api.Services;

namespace Takvim.Api.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController : ControllerBase
{
    private readonly AppDbContext _db;
    private readonly IPasswordHasher<AppUser> _hasher;
    private readonly JwtTokenService _tokens;

    public AuthController(
        AppDbContext db,
        IPasswordHasher<AppUser> hasher,
        JwtTokenService tokens)
    {
        _db = db;
        _hasher = hasher;
        _tokens = tokens;
    }

    [HttpPost("register")]
    public async Task<ActionResult<AuthResponse>> Register(
        RegisterRequest request)
    {
        var name = request.Name.Trim();
        var email = request.Email.Trim().ToLowerInvariant();

        if (name.Length < 2)
            return BadRequest(new
            {
                message = "Ad en az 2 karakter olmalıdır."
            });

        var exists = await _db.Users
            .AnyAsync(x => x.Email == email);

        if (exists)
            return Conflict(new
            {
                message = "Bu e-posta zaten kayıtlı."
            });

        var user = new AppUser
        {
            Name = name,
            Email = email,
            Role = "User"
        };

        user.PasswordHash =
            _hasher.HashPassword(user, request.Password);

        _db.Users.Add(user);

        try
        {
            await _db.SaveChangesAsync();
        }
        catch (DbUpdateException)
        {
            // Eşzamanlı kayıt isteklerinde unique index
            // ikinci kaydı engeller.
            return Conflict(new
            {
                message = "Kayıt tamamlanamadı. E-posta adresini kontrol edin."
            });
        }

        return Ok(_tokens.CreateToken(user));
    }

    [HttpPost("login")]
    public async Task<ActionResult<AuthResponse>> Login(
        LoginRequest request)
    {
        var email = request.Email.Trim().ToLowerInvariant();

        var user = await _db.Users
            .FirstOrDefaultAsync(x => x.Email == email);

        if (user is null)
            return Unauthorized(new
            {
                message = "E-posta veya parola hatalı."
            });

        var result = _hasher.VerifyHashedPassword(
            user,
            user.PasswordHash,
            request.Password
        );

        if (result == PasswordVerificationResult.Failed)
            return Unauthorized(new
            {
                message = "E-posta veya parola hatalı."
            });

        if (result ==
            PasswordVerificationResult.SuccessRehashNeeded)
        {
            user.PasswordHash =
                _hasher.HashPassword(user, request.Password);

            await _db.SaveChangesAsync();
        }

        return Ok(_tokens.CreateToken(user));
    }

    [Authorize]
    [HttpGet("me")]
    public IActionResult Me()
    {
        return Ok(new
        {
            userId = User.FindFirst(
                System.Security.Claims.ClaimTypes
                    .NameIdentifier)?.Value,
            name = User.Identity?.Name,
            role = User.FindFirst(
                System.Security.Claims.ClaimTypes
                    .Role)?.Value
        });
    }

    [Authorize(Roles = "Admin")]
    [HttpGet("admin-check")]
    public IActionResult AdminCheck()
    {
        return Ok(new
        {
            message = "Yönetici yetkisi doğrulandı."
        });
    }
}
