void		ResetStats(int client)
{
	g_Stats[client].xp = 0;
	g_Stats[client].level = 1;
	g_Stats[client].max_hp = 100;
}

void		levelUp(int client)
{
	int	curr_health;

	g_Stats[client].xp -= CalcRequiredXp(g_Stats[client].level);
	g_Stats[client].level = g_Stats[client].level + 1;
	curr_health = GetEntProp(client, Prop_Send, "m_iHealth");
	g_Stats[client].max_hp = g_Stats[client].max_hp + g_Config.hp_per_level;
	setMaxHp(client, g_Stats[client].max_hp);
	setHp(client, curr_health + g_Config.hp_per_level);
}

int		CalcLevel(int xp)
{
	return RoundFloat(xp / g_Config.xp_req_mul / g_Config.xp_req);
}

int		CalcRequiredXp(int level)
{
	return RoundFloat(level * g_Config.xp_req_mul * g_Config.xp_req);
}

void		setHp(int client, int amount)
{
	SetEntProp(client, Prop_Send, "m_iHealth", amount);
}

void		setMaxHp(int client, int amount)
{
	SetEntProp(client, Prop_Data, "m_iMaxHealth", amount);
}
