public void	ResetStats(int client)
{
	g_Stats[client].xp = 0;
	g_Stats[client].level = 1;
	g_Stats[client].max_hp = 100;
	g_Stats[client].damage_mul = 1.0;
	g_Stats[client].speed_mul = 1.0
	g_Stats[client].max_armor = 100;
}

public void	LevelUp(int client)
{
	int	curr_health;
	int	curr_armor;
	int	armor;
	int	max_armor;

	curr_health = GetEntProp(client, Prop_Send, "m_iHealth");
	curr_armor = GetClientArmor(client);
	armor = curr_armor + g_Config.armor_per_level;
	max_armor = g_Stats[client].max_armor + g_Config.armor_per_level;
	if (127 < armor)
	{
		armor = 127;
	}
	if (127 < max_armor)
	{
		max_armor = 127;
	}
	g_Stats[client].xp -= CalcRequiredXp(g_Stats[client].level);
	g_Stats[client].level = g_Stats[client].level + 1;
	g_Stats[client].max_hp = g_Stats[client].max_hp + g_Config.hp_per_level;
	g_Stats[client].damage_mul += g_Config.damage_mul_per_level;
	g_Stats[client].speed_mul += g_Config.speed_mul_per_level;
	g_Stats[client].max_armor = max_armor;
	SetMaxHp(client, g_Stats[client].max_hp);
	SetHp(client, curr_health + g_Config.hp_per_level);
	SetArmor(client, armor);
	SetSpeed(client, g_Stats[client].speed_mul);
	EmitSoundToClient(client, g_Config.sound_lvup);
}

public int	CalcLevel(int xp)
{
	return RoundFloat(xp / g_Config.xp_req_mul / g_Config.xp_req);
}

public int	CalcRequiredXp(int level)
{
	return RoundFloat(level * g_Config.xp_req_mul * g_Config.xp_req);
}

public void	SetHp(int client, int amount)
{
	SetEntProp(client, Prop_Send, "m_iHealth", amount);
}

public void	SetMaxHp(int client, int amount)
{
	SetEntProp(client, Prop_Data, "m_iMaxHealth", amount);
}

public void	SetArmor(int client, int amount)
{
	SetEntProp(client, Prop_Send, "m_ArmorValue", amount);
}

public void	GiveHelmet(int client)
{
	SetEntProp(client, Prop_Send, "m_bHasHelmet", 1);
}

public void	SetSpeed(int client, float amount)
{
	SetEntPropFloat(client, Prop_Data, "m_flLaggedMovementValue", amount);
}