#include "lightrpg.inc"

public Action	Timer_ShowHud(Handle timer)
{
	int	idx;

	idx = 0;
	SetHudTextParams(g_Config.hud_x, g_Config.hud_y, g_Config.hud_refresh,
	g_Config.hud_r, g_Config.hud_g, g_Config.hud_b, g_Config.hud_a);
	while (MaxClients >= ++idx)
	{
		if (IsClientInGame(idx)
		&& !IsFakeClient(idx))
		{
			ShowSyncHudText(idx, g_HudSync, "%t", "HUD",
			g_Stats[idx].level, g_Stats[idx].xp,
			CalcRequiredXp(g_Stats[idx].level + 1));
		}
	}
	return Plugin_Continue;
}
