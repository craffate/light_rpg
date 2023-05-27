#include "lightrpg.inc"

public Action	Event_PlayerHurt(Event event, char[] name, bool dontBroadcast)
{
	Action	ret;
	int	client;
	int	attacker;

	ret = Plugin_Handled;
	client = GetClientOfUserId(event.GetInt("userid"));
	attacker = GetClientOfUserId(event.GetInt("attacker"));
	if (0 == client
	|| 0 == attacker)
	{
		ret = Plugin_Continue;
	}
	if (Plugin_Handled == ret
	&& !(client == attacker)
	&& IsClientInGame(attacker)
	&& g_Config.xp_max > g_Stats[attacker].xp
	&& g_Stats[attacker].level < CalcLevel(g_Config.xp_max))
	{
		g_Stats[attacker].xp +=
		RoundFloat(event.GetInt("dmg_health") * g_Config.xp_mul_per_hit);
		while (g_Stats[attacker].level < CalcLevel(g_Stats[attacker].xp))
		{
			LevelUp(attacker);
		}
	}
	return ret;
}

public Action	Event_PlayerDeath(Event event, char[] name, bool dontBroadcast)
{
	Action	ret;
	int	client;
	int	attacker;

	ret = Plugin_Handled;
	client = GetClientOfUserId(event.GetInt("userid"));
	attacker = GetClientOfUserId(event.GetInt("attacker"));
	if (0 == client
	|| 0 == attacker)
	{
		ret = Plugin_Continue;
	}
	if (Plugin_Handled == ret
	&& !(client == attacker)
	&& IsClientInGame(attacker)
	&& g_Config.xp_max > g_Stats[attacker].xp
	&& g_Stats[attacker].level < CalcLevel(g_Config.xp_max))
	{
		g_Stats[attacker].xp += g_Config.xp_per_kill;
		while (g_Stats[attacker].level < CalcLevel(g_Stats[attacker].xp))
		{
			LevelUp(attacker);
		}
	}
	return ret;
}

public Action	Event_PlayerSpawn(Event event, char[] name, bool dontBroadcast)
{
	Action	ret;
	int	client;

	ret = Plugin_Handled;
	client = GetClientOfUserId(event.GetInt("userid"));
	if (0 == client)
	{
		ret = Plugin_Continue;
	}
	if (Plugin_Handled == ret
	&& IsClientInGame(client))
	{
		SetHp(client, g_Stats[client].max_hp);
		SetArmor(client, g_Stats[client].max_armor);
		SetSpeed(client, g_Stats[client].speed_mul);
		if (0 < g_Config.armor_give_helmet)
		{
			GiveHelmet(client);
		}
	}
	return ret;
}
