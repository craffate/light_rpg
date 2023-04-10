public void	Event_PlayerHurt(Event event, char[] name, bool dontBroadcast)
{
	int	client;
	int	total;
	int	level;

	client = GetClientOfUserId(event.GetInt("attacker"));
	if (IsClientConnected(client) && IsClientInGame(client) && g_Config.xp_max > g_Stats[client].xp)
	{
		total = RoundFloat(event.GetInt("dmg_health") * g_Config.xp_mul_per_hit);
		g_Stats[client].xp += total;
		level = CalcLevel(g_Stats[client].xp);
		if (g_Stats[client].level < level)
		{
			levelUp(client)
		}
	}
}

public void	Event_PlayerDeath(Event event, char[] name, bool dontBroadcast)
{
	int	client;
	int	level;

	client = GetClientOfUserId(event.GetInt("attacker"));
	if (IsClientConnected(client) && IsClientInGame(client) && g_Config.xp_max > g_Stats[client].xp)
	{
		g_Stats[client].xp += g_Config.xp_per_kill;
		level = CalcLevel(g_Stats[client].xp);
		if (g_Stats[client].level < level)
		{
			levelUp(client)
		}
	}
}

public void	Event_PlayerSpawn(Event event, char[] name, bool dontBroadcast)
{
	int	client;

	client = GetClientOfUserId(event.GetInt("userid"));
	if (IsClientConnected(client) && IsClientInGame(client))
	{
		setHp(client, g_Stats[client].max_hp);
	}
}
