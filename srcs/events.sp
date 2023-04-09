public void	Event_OnPlayerSpawn(Event event, char[] name, bool dontBroadcast)
{
	int	client;

	client = GetClientOfUserId(event.GetInt("userid"));
	if (IsClientConnected(client) && IsClientInGame(client))
	{
		PrintToChat(client, "You have %d experience points.", g_Stats[client].xp);
	}
}

public void	Event_PlayerHurt(Event event, char[] name, bool dontBroadcast)
{
	int	client;
	int	total;

	client = GetClientOfUserId(event.GetInt("attacker"));
	if (IsClientConnected(client) && IsClientInGame(client) && g_Config.xp_max > g_Stats[client].xp)
	{
		total = RoundFloat(event.GetInt("dmg_health") * g_Config.xp_mul_per_hit);
		g_Stats[client].xp += total;
	}
}

public void	Event_PlayerDeath(Event event, char[] name, bool dontBroadcast)
{
	int	client;

	client = GetClientOfUserId(event.GetInt("attacker"));
	if (IsClientConnected(client) && IsClientInGame(client) && g_Config.xp_max > g_Stats[client].xp)
	{
		g_Stats[client].xp += g_Config.xp_per_kill;
	}
}
