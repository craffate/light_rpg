#if !defined LIGHTRPG_CONFIG_INC
	#define LIGHTRPG_CONFIG_INC

enum struct	Config
{
	int	xp_max;
	int	xp_per_kill;
	float	xp_mul_per_hit;
	int	xp_req;
	float	xp_req_mul;
	float	hud_x;
	float	hud_y;
	int	hud_r;
	int	hud_g;
	int	hud_b;
	int	hud_a;
	float	hud_refresh;
	char	sound_lvup[PLATFORM_MAX_PATH];
	int	hp_per_level;
	float	damage_mul_per_level;
	float	speed_mul_per_level;
	int	armor_per_level;
	int	armor_give_helmet;
}

Config		g_Config;

#endif