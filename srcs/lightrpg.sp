#include "lightrpg.inc"

public Plugin		myinfo =
{
	name = "Light RPG",
	author = "exha",
	description = "Simple role-playing game.",
	version = VERSION,
	url = ""
};

public void		OnPluginStart()
{
	LoadTranslations("lightrpg.phrases");
	LoadConfig();
	HookEvent("player_spawn", Event_PlayerSpawn, EventHookMode_Post);
	HookEvent("player_hurt", Event_PlayerHurt, EventHookMode_Pre);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Post);
}

public void		OnMapStart()
{
	int		idx;
	char		buf[PLATFORM_MAX_PATH];

	idx = 0;
	while (MaxClients >= ++idx)
	{
		ResetStats(idx);
	}
	g_HudSync = CreateHudSynchronizer();
	if (INVALID_HANDLE != g_HudSync)
	{
		if (INVALID_HANDLE == CreateTimer(g_Config.hud_refresh,
		Timer_ShowHud, _,
		TIMER_FLAG_NO_MAPCHANGE | TIMER_REPEAT))
		{
			LogError("Could not create HUD timer.");
			if (null != g_HudSync)
			{
				CloseHandle(g_HudSync);
				g_HudSync = null;
			}
		}
	}
	Format(buf, sizeof(buf), "sound/%s", g_Config.sound_lvup);
	AddFileToDownloadsTable(buf);
	if (false == PrecacheSound(g_Config.sound_lvup))
	{
		SetFailState("Could not precache sound %s.",
		g_Config.sound_lvup);
	}
}

public void		OnClientPutInServer(int client)
{
	ResetStats(client);
	SDKHook(client, SDKHook_OnTakeDamage, Hook_OnTakeDamage);
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

	BuildPath(Path_SM, config_path,
	sizeof(config_path), "configs/lightrpg.cfg");
	kv = new KeyValues("LightRPG");
	if (INVALID_HANDLE == kv)
	{
		SetFailState("Could not initialize configuration file.");
	}
	if (false == kv.ImportFromFile(config_path))
	{
		SetFailState("Could not read configuration file.");
	}
	if (false == kv.GotoFirstSubKey())
	{
		SetFailState("Could not find a first subkey in configuration file.");
	}
	do
	{
		if (false == kv.GetSectionName(buf, sizeof(buf)))
		{
			SetFailState("Could not retrieve section name in configuration file.");
		}
		if (StrEqual(buf, "XP"))
		{
			g_Config.xp_max = kv.GetNum("max");
			g_Config.xp_per_kill = kv.GetNum("per_kill");
			g_Config.xp_mul_per_hit = kv.GetFloat("mul_per_hit");
			g_Config.xp_req = kv.GetNum("req");
			g_Config.xp_req_mul = kv.GetFloat("req_mul");
		}
		else if (StrEqual(buf, "HUD"))
		{
			g_Config.hud_x = kv.GetFloat("x");
			g_Config.hud_y = kv.GetFloat("y");
			g_Config.hud_r = kv.GetNum("r");
			g_Config.hud_g = kv.GetNum("g");
			g_Config.hud_b = kv.GetNum("b");
			g_Config.hud_a = kv.GetNum("a");
			g_Config.hud_refresh = kv.GetFloat("refresh");
		}
		else if (StrEqual(buf, "sounds"))
		{
			kv.GetString("lvup", g_Config.sound_lvup,
			sizeof(g_Config.sound_lvup));
		}
		else if (StrEqual(buf, "HP"))
		{
			g_Config.hp_per_level = kv.GetNum("per_level");
		}
		else if (StrEqual(buf, "damage"))
		{
			g_Config.damage_mul_per_level = kv.GetFloat("mul_per_level");
		}
		else if (StrEqual(buf, "speed"))
		{
			g_Config.speed_mul_per_level = kv.GetFloat("mul_per_level");
		}
		else if (StrEqual(buf, "armor"))
		{
			g_Config.armor_per_level = kv.GetNum("per_level");
			g_Config.armor_give_helmet = kv.GetNum("give_helmet");
		}
	} while (kv.GotoNextKey());

	if (null != kv)
	{
		CloseHandle(kv);
		kv = null;
	}
}
