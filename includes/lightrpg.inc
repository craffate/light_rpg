#include <sourcemod>

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
}

enum struct	Stats
{
	int	xp;
	int	level;
}

Config		g_Config;
Stats		g_Stats[MAXPLAYERS + 1];
Handle		g_HudSync;
