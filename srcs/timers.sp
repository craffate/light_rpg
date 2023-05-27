#include "lightrpg.inc"

public Action	Timer_ShowHud(Handle timer)
{
	Action	ret;
	int	idx;

	ret = Plugin_Continue;
	idx = 0;
	SetHudTextParams(g_Config.hud_x, g_Config.hud_y, g_Config.hud_refresh,
	g_Config.hud_r, g_Config.hud_g, g_Config.hud_b, g_Config.hud_a);
	while (MaxClients >= ++idx)
	{
		if (IsClientInGame(idx)
		&& !IsFakeClient(idx))
		{
			if (g_Stats[idx].level < CalcLevel(g_Config.xp_max))
			{
				if (-1 == ShowSyncHudText(idx,
				g_HudSync, "%t", "HUD",
				g_Stats[idx].level, g_Stats[idx].xp,
				CalcRequiredXp(g_Stats[idx].level + 1)))
				{
					ret = Plugin_Stop;
				}
			}
			else
			{
				if (-1 == ShowSyncHudText(idx,
				g_HudSync, "%t", "HUD_MAX"))
				{
					ret = Plugin_Stop;
				}
			}
		}
	}
	return ret;
}
