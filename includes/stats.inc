#if !defined LIGHTRPG_STATS_INC
	#define LIGHTRPG_STATS_INC

enum struct	Stats
{
	int	xp;
	int	level;
	int	max_hp;
	int	max_armor;
	float	damage_mul;
	float	speed_mul;
}

Stats		g_Stats[MAXPLAYERS + 1];

#endif