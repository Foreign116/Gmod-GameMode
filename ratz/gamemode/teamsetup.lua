local ply = FindMetaTable("Player")
local teams = {}

teams[0] = {
	name = "Red",
	color = Vector(1.0,0,0),
	model = "models/player/woody.mdl",
	health = 5,
	walkspeed = 800,
	sprintspeed = 1200,
}
teams[1] = {
	name = "Blue",
	color = Vector(0,0,1.0),
	model = "models/captainbigbutt/vocaloid/miku_classic.mdl",
	health = 5,
	walkspeed =800,
	sprintspeed = 1200,
}

function ply:SetUpTeam(n)
	if(not teams[n]) then return end
	self:SetTeam(n)
	self:SetPlayerColor(teams[n].color)
	self:SetHealth(teams[n].health)
	self:SetMaxHealth(teams[n].health)
	self:SetWalkSpeed(teams[n].walkspeed)
	self:SetRunSpeed(teams[n].sprintspeed)
	self:SetModel(teams[n].model)
	self:Give("weapon_galactic_gatling")
	end 

