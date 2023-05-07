#include <sourcemod>
#include <sdkhooks>

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
	int	hp_per_level;
	float	damage_mul_per_level;
	float	speed_mul_per_level;
	int	armor_per_level;
	int	armor_give_helmet;
}

enum struct	Stats
{
	int	xp;
	int	level;
	int	max_hp;
	int	max_armor;
	float	damage_mul;
	float	speed_mul;
}

Config		g_Config;
Stats		g_Stats[MAXPLAYERS + 1];
Handle		g_HudSync;
