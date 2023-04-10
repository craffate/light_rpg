void	ResetStats(int client)
{
	g_Stats[client].xp = 0;
	g_Stats[client].level = 1;
}

int	CalcLevel(int xp)
{
	return RoundFloat(xp / g_Config.xp_req_mul / g_Config.xp_req);
}

int	CalcRequiredXp(int level)
{
	return RoundFloat(level * g_Config.xp_req_mul * g_Config.xp_req);
}
