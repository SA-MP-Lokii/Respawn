#include <a_samp>
#include <progress2>

new Text:VD_BOX;
new Text:VD_BOX2;
new Text:VD_TEXT;
new PlayerBar:VD_BAR[MAX_PLAYERS];

new Float:VD_VALUE[MAX_PLAYERS] = {0.0,...};

public OnFilterScriptInit()
{
    VD_BOX = TextDrawCreate(-1.999967, 0.844434, "box");
	TextDrawLetterSize(VD_BOX, 0.000000, 50.701057);
	TextDrawTextSize(VD_BOX, 638.000000, 0.000000);
	TextDrawAlignment(VD_BOX, 1);
	TextDrawColor(VD_BOX, -1);
	TextDrawUseBox(VD_BOX, 1);
	TextDrawBoxColor(VD_BOX, 0x3C3C3C30);
	TextDrawSetShadow(VD_BOX, 0);
	TextDrawBackgroundColor(VD_BOX, 255);
	TextDrawFont(VD_BOX, 1);
	TextDrawSetProportional(VD_BOX, 1);
	VD_BOX2 = TextDrawCreate(555.333374, 418.977722, "box");
	TextDrawLetterSize(VD_BOX2, 0.000000, 1.800001);
	TextDrawTextSize(VD_BOX2, 618.000000, 0.000000);
	TextDrawAlignment(VD_BOX2, 1);
	TextDrawColor(VD_BOX2, -1);
	TextDrawUseBox(VD_BOX2, 1);
	TextDrawBoxColor(VD_BOX2, 240);
	TextDrawSetShadow(VD_BOX2, 0);
	TextDrawBackgroundColor(VD_BOX2, 255);
	TextDrawFont(VD_BOX2, 1);
	TextDrawSetProportional(VD_BOX2, 1);
	VD_TEXT = TextDrawCreate(502.666778, 421.281341, "RESPAWN");
	TextDrawLetterSize(VD_TEXT, 0.249666, 0.894814);
	TextDrawAlignment(VD_TEXT, 1);
	TextDrawColor(VD_TEXT, -1);
	TextDrawSetShadow(VD_TEXT, 0);
	TextDrawBackgroundColor(VD_TEXT, 255);
	TextDrawFont(VD_TEXT, 2);
	TextDrawSetProportional(VD_TEXT, 1); 
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(!IsPlayerNPC(playerid))
	{
		VD_VALUE[playerid] = 0.0;
		VD_BAR[playerid] = CreatePlayerProgressBar(playerid, 562.666870, 424.785217, 52.0, 5.0, 0xFF0000FF, 100.0, BAR_DIRECTION_RIGHT, 0x000000FF);
	}
	return 1;
}

public OnPlayerSpawn(playerid)
{
	VD_VALUE[playerid] = 0.0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    if(!IsPlayerNPC(playerid))
	{
	    VD_VALUE[playerid] = 0.0;
	    DestroyPlayerProgressBar(playerid, VD_BAR[playerid]);
	}
	return 1;
}

public OnPlayerUpdate(playerid)
{
    if(VD_VALUE[playerid] >= 1.0)
	{
	    VUpdateBar(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(!IsPlayerNPC(playerid))
	{
		if(IsPlayerNPC(killerid) || killerid == 0xFFFF || playerid == killerid) return 1;
		VD_VALUE[playerid] = 1.0;
		TextDrawShowForPlayer(playerid, VD_BOX);
		TextDrawShowForPlayer(playerid, VD_BOX2);
		TextDrawShowForPlayer(playerid, VD_TEXT);
		ShowPlayerProgressBar(playerid, VD_BAR[playerid]);
		TogglePlayerSpectating(playerid, 1);
		PlayerSpectatePlayer(playerid, killerid);
	}
	return 1;
}

VUpdateBar(playerid)
{
	VD_VALUE[playerid] += 1.0;
	if(VD_VALUE[playerid] >= 100.0)
 	{
  		TogglePlayerSpectating(playerid, 0);
 	 	HidePlayerProgressBar(playerid, VD_BAR[playerid]);
 	 	TextDrawHideForPlayer(playerid, VD_BOX);
		TextDrawHideForPlayer(playerid, VD_BOX2);
		TextDrawHideForPlayer(playerid, VD_TEXT);
		SpawnPlayer(playerid);
  		return 1;
   	}
   	SetPlayerProgressBarValue(playerid, VD_BAR[playerid], VD_VALUE[playerid]);
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(VD_VALUE[playerid] >= 1.0) 
	{
		if(newkeys & KEY_FIRE)
		{
		    VD_VALUE[playerid] += 10.0;
	     	if(VD_VALUE[playerid] >= 100.0)
		    {
		        TogglePlayerSpectating(playerid, 0);
	    		TextDrawHideForPlayer(playerid, VD_BOX);
				TextDrawHideForPlayer(playerid, VD_BOX2);
				TextDrawHideForPlayer(playerid, VD_TEXT);
		        HidePlayerProgressBar(playerid, VD_BAR[playerid]);
				SpawnPlayer(playerid);
		        return 1;
		    }
		    else
		    {
	        	SetPlayerProgressBarValue(playerid, VD_BAR[playerid], VD_VALUE[playerid]);
			}
		}
	}
	return 1;
}

//EOF.
