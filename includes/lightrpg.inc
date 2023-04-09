#include <sourcemod>

enum struct	Config
{
	int	xp_max;
	int	xp_per_kill;
	float	xp_mul_per_hit;
}

enum struct	Stats
{
	int	xp;
}

Config		g_Config;
Stats		g_Stats[MAXPLAYERS + 1];
