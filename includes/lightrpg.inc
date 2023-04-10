#include <sourcemod>

enum struct	Config
{
	int	xp_max;
	int	xp_per_kill;
	float	xp_mul_per_hit;
	int	xp_req;
	float	xp_req_mul;
}

enum struct	Stats
{
	int	xp;
	int	level;
}

Config		g_Config;
Stats		g_Stats[MAXPLAYERS + 1];
