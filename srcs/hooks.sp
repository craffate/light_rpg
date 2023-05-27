#include "lightrpg.inc"

public Action	Hook_OnTakeDamage(int victim, int &attacker, int &inflictor,
float &damage, int &damagetype, int &weapon, float damageForce[3],
float damagePosition[3])
{
	Action	ret;

	ret = Plugin_Continue;
	if (0 < attacker
	&& 0 < victim
	&& MaxClients > attacker
	&& MaxClients > victim
	&& !(attacker == victim)
	&& IsClientInGame(attacker)
	&& IsClientInGame(victim))
	{
		damage *= g_Stats[attacker].damage_mul;
		ret = Plugin_Changed;
	}
	return ret;
}