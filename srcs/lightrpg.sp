#include "lightrpg.inc"
#include "events.sp"
#include "stats.sp"

public Plugin		myinfo =
{
	name = "Light RPG",
	author = "exha",
	description = "Light RPG",
	version = "0.1",
	url = ""
};


public void		OnPluginStart()
{
	LoadConfig();
	HookEvent("player_spawn", Event_OnPlayerSpawn, EventHookMode_Post);
	HookEvent("player_hurt", Event_PlayerHurt, EventHookMode_Pre);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
}

public void		OnMapStart()
{
	int		idx;

	idx = 0;
	while (MaxClients >= ++idx)
	{
		ResetStats(idx);
	}
}

public void		OnClientPutInServer(int client)
{
	ResetStats(client);
}

public void		OnClientDisconnect(int client)
{
	ResetStats(client);
}

static void		LoadConfig()
{
	char		config_path[PLATFORM_MAX_PATH];
	KeyValues	kv;
	char		buf[128];

	BuildPath(Path_SM, config_path, sizeof(config_path), "configs/lightrpg.txt");
	kv = new KeyValues("LightRPG");
	kv.ImportFromFile(config_path);
	kv.GotoFirstSubKey();
	do
	{
		kv.GetSectionName(buf, sizeof(buf));
		if (StrEqual(buf, "XP"))
		{
			g_Config.xp_max = kv.GetNum("max");
			g_Config.xp_per_kill = kv.GetNum("per_kill");
			g_Config.xp_mul_per_hit = kv.GetFloat("mul_per_hit");
		}
	} while (kv.GotoNextKey());
}
