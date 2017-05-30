local ply = FindMetaTable("Player")

local teams = {}

teams[0] = {
	name = "Red",
	color = Vector(1.0,0,0),
	model = "models/player/Group03m/Male_01.mdl",
	health = 5,
	walkspeed = 750,
	sprintspeed = 1500,
	weapons = {"weapon_357"}
}
teams[1] = {
	name = "Blue",
	color = Vector(0,0,1.0),
	model = "models/player/Group03m/Male_09.mdl",
	health = 5,
	walkspeed =750,
	sprintspeed = 1500,
	weapons = {"weapon_357"}
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
	self:GiveWeapons(n)
	self:GiveWeaponAmmo(n)
	end 

function ply:GiveWeapons(n)
for k, weapon in pairs(teams[n].weapons) do
	self:Give(weapon)

end


end

function ply:GiveWeaponAmmo(n)
	if n==0 then
		self:SetAmmo(0,5)
		self:GiveAmmo(1000,"357",true)
	else
		self:SetAmmo(0,5)
		self:GiveAmmo(1000,"357",true)	
	end

end

