local ply = FindMetaTable("Player")
local teams = {}

teams[0] = {
	name = "Red",
	color = Vector(1.0,0,0),
	model = "models/player/Group03m/Male_01.mdl",
	health = 100,
	walkspeed = 500,
	sprintspeed = 650,
}
teams[1] = {
	name = "Blue",
	color = Vector(0,0,1.0),
	model = "models/player/Group03m/Male_09.mdl",
	health = 100,
	walkspeed =500,
	sprintspeed = 650,
}

function ply:SetUpTeam(n,s)
	if(not teams[n]) then return end
	self:SetTeam(n)
	self:SetPlayerColor(teams[n].color)
	self:SetHealth(teams[n].health)
	self:SetMaxHealth(teams[n].health)
	self:SetWalkSpeed(teams[n].walkspeed)
	self:SetRunSpeed(teams[n].sprintspeed)
	self:SetModel(teams[n].model)
	self:Give(s)
	end 

