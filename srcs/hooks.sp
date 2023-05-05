public Action Hook_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3])
{
	if (1 > attacker || 1 > victim || MaxClients < attacker || MaxClients < victim || !IsClientInGame(attacker) || IsFakeClient(attacker))
	{
		return Plugin_Continue;
	}
	damage *= g_Stats[attacker].damage_mul;

	return Plugin_Changed;
}