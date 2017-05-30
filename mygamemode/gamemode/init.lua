AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("teamsetup.lua")
include("shared.lua")
include("teamsetup.lua")
util.AddNetworkString("redteamscore")
util.AddNetworkString("blueteamscore")
PLAYER = FindMetaTable( "Player" );

function PLAYER:Unassigned( )
	if ( self:Team( ) == TEAM_UNASSIGNED || self:Team( ) == TEAM_SPECTATOR ) then
		return true;
	end

	return false;
end


function GM:PlayerInitialSpawn( Player )
	Player:SetTeam( TEAM_SPECTATOR );
end

function GM:PlayerSpawn( ply )

	if ( ply:Unassigned( ) ) then
		ply:StripAmmo( )
		ply:StripWeapons( );
		ply:Spectate( OBS_MODE_ROAMING )
		ply:ConCommand("team_menu")
		return false;
	else
		ply:SetUpTeam(ply:Team())
		ply:UnSpectate()
	end

end

function GM:PlayerSetHandsModel( ply, ent )

	local simplemodel = player_manager.TranslateToPlayerModelName( ply:GetModel() )
	local info = player_manager.TranslatePlayerHands( simplemodel )
	if ( info ) then
		ent:SetModel( info.model )
		ent:SetSkin( info.skin )
		ent:SetBodyGroups( info.body )
	end

end



function GM:PlayerShouldTakeDamage(ply,attacker)
	local att

	if(attacker:IsPlayer()) then
		att = attacker
	elseif(attacker:IsWorld()) then
		return false
	else
		att = attacker:GetOwner()
	end

	if(ply:Team()==att:Team()) then
		return false
	end
	return true


	end


function GM:PlayerCanSeePlayersChat(text,teamonly,listener,speaker)
	--local dist = listener:GetPos():Distance(speaker:GetPos())

	if(teamonly) then
		return true
	end
	return false 
end 

function GM:PlayerCanHearPlayersVoice(listener,speaker)
	if(listener:Team()==speaker:Team()) then
		return true
	end
	return false 
end 

 function team_1( ply )
 	ply:SetUpTeam(0)
 	PLAYER.f1key = false
 	ply:Spawn()
   	ply:SetUpTeam(0)
	ply:SetupHands()
 end 
 
 function team_2( ply )
 	ply:SetUpTeam(1)
 	PLAYER.f1key = false
	ply:Spawn()
	ply:SetUpTeam(1)
	ply:SetupHands()
 end


function GM:PlayerDeath(victim,inflictor,attacker)
	PLAYER.f1key = false
	if(attacker:IsPlayer()) then
		PrintMessage( HUD_PRINTTALK, victim:Nick().." got killed by "..attacker:Nick())
	else
		PrintMessage( HUD_PRINTTALK, victim:Nick().." got killed by "..attacker:GetOwner():Nick())
	end
end
function GM:Think()
local players = player.GetAll()
local bscore = 0
local rscore = 0
for k,v in pairs(players) do
	if(v:Team()==0) then
		if(v:Frags()>0) then
			rscore = rscore + v:Frags()
			end
	elseif(v:Team()==1) then
		if(v:Frags()>0) then
			bscore = bscore + v:Frags()
			end	
		end
	end
net.Start("redteamscore")
net.WriteInt(rscore,16)
net.Send(players)
net.Start("blueteamscore")
net.WriteInt(bscore,16)
net.Send(players)
end

	
	
concommand.Add( "team_1", team_1 )
concommand.Add( "team_2", team_2 )