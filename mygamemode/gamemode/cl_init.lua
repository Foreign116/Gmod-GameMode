include("shared.lua")



local bfrags = 0
local bbfrags = 0
local rfrags = 0
local rrfrags = 0
local kfrags = 0
local kdeaths = 0
local kd = 0
local deathcount = 0
surface.CreateFont( "Special", {
	font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	extended = false,
	size = 30,
	weight = 1000,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

hook.Add("HUDPaint","HudIdent",function()
	local ply = LocalPlayer()
	local plyteam = LocalPlayer():Team()
	surface.SetDrawColor(0,0,0,255)
	surface.DrawRect(30-2,ScrH()-70-2,300+4,30+4)
	if(plyteam==0) then
	surface.SetDrawColor(255,0,0,255)
	elseif(plyteam==1) then
	surface.SetDrawColor(0,0,255,255)
	else
	surface.SetDrawColor(0,0,0,0)
	end
	surface.SetTexture(10)
	surface.DrawRect(30,ScrH()-70,300*(ply:Health()/ply:GetMaxHealth()),30)

	draw.SimpleText(ply:Health(),"Special",30+150,ScrH()-55,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)

end)
net.Receive("redteamscore",function (len)
rfrags = net.ReadInt(16)
if(rfrags>=rrfrags) then
	rrfrags = rfrags
end
end)
net.Receive("blueteamscore",function (len)
bfrags = net.ReadInt(16)
if(bfrags>=bbfrags) then
	bbfrags=bfrags
end
end)

function GM:HUDShouldDraw(name)
	local hud = {"CHudHealth","CHudBattery"}

	for k,element in pairs(hud) do
		if name==element then return false end
	end
	return true
end
function menuTeam()
local torf = false
local frame = vgui.Create("DFrame")
frame:SetText("Pick a Team!")
frame:SetSize(360,360)
frame:SetPos(ScrW()/2,ScrH()/2)
frame:Center()
frame:SetSizable(true)
frame:SetVisible(true)
frame:MakePopup()
frame:SetDeleteOnClose(true)
local x,y = frame:GetSize()
local label = vgui.Create("DLabel",frame)
label:SetPos(130,y-150)
label:SetText("Weapons")
local button = vgui.Create("DButton",frame)
button:SetText("ACR")
button:SetSize(100,20)
button:SetPos(130,y-130)
button.DoClick = function()
	torf = true
	net.Start("p")
	net.WriteString("weapon_mw2_acr")
	net.SendToServer()
end	
local button = vgui.Create("DButton",frame)
button:SetText("F200")
button:SetSize(100,20)
button:SetPos(130,y-110)
button.DoClick = function()
	torf = true
	net.Start("p")
	net.WriteString("weapon_mw2_f2000")
	net.SendToServer()
end	
local button = vgui.Create("DButton",frame)
button:SetText("Intervention")
button:SetSize(100,20)
button:SetPos(130,y-90)
button.DoClick = function()
	torf = true
	net.Start("p")
	net.WriteString("weapon_mw2_intervention")
	net.SendToServer()
end	
local button = vgui.Create("DButton",frame)
button:SetText("M4")
button:SetSize(100,20)
button:SetPos(130,y-70)
button.DoClick = function()
	torf = true
	net.Start("p")
	net.WriteString("weapon_mw2_m4")
	net.SendToServer()
end
local button = vgui.Create("DButton",frame)
button:SetText("MP5K")
button:SetSize(100,20)
button:SetPos(130,y-50)
button.DoClick = function()
	torf = true
	net.Start("p")
	net.WriteString("weapon_mw2_mp5k")
	net.SendToServer()
end
local button = vgui.Create("DButton",frame)
button:SetText("UMP45")
button:SetSize(100,20)
button:SetPos(130,y-30)
button.DoClick = function()
	torf = true
	net.Start("p")
	net.WriteString("weapon_mw2_ump45")
	net.SendToServer()
end
local button = vgui.Create("DButton",frame)
button:SetText("Team Red")
button:SetSize(100,50)
button:SetPos(130,y-310)

button.DoClick = function()
	if(torf==true) then
	RunConsoleCommand("team_1")
	frame:Close()
end
end
local button = vgui.Create("DButton",frame)
button:SetText("Team Blue")
button:SetSize(100,50)
button:SetPos(130,y-200)

button.DoClick = function()
	if(torf==true) then
	RunConsoleCommand("team_2")
	frame:Close()
end
end
end
concommand.Add("team_menu",menuTeam)


function GM:HUDPaint()
	local kills = LocalPlayer():Frags()
	if(kills<0) then
		kills = 0
	end
	draw.SimpleText(LocalPlayer():Nick().." - Kills : "..kills.." Deaths : "..LocalPlayer():Deaths(),"Special",0,0,Color(0,0,0))
	draw.RoundedBox(0,(ScrW()/2)-100,0,100,50,Color(255,0,0))
	draw.SimpleText(rrfrags,"Special",(ScrW()/2)-50,8,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_RIGHT)
	draw.RoundedBox(0,(ScrW()/2),0,100,50,Color(0,0,255))
	draw.SimpleText(bbfrags,"Special",(ScrW()/2)+50,8,Color(0,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_RIGHT)
end


function ChooseGun()
local frame = vgui.Create("DFrame")
frame:SetText("New LoadOut!!")
frame:SetSize(360,360)
frame:SetPos(ScrW()/2,ScrH()/2)
frame:Center()
frame:SetSizable(true)
frame:SetVisible(true)
frame:MakePopup()
frame:SetDeleteOnClose(true)
local x,y = frame:GetSize()
local label = vgui.Create("DLabel",frame)
label:SetPos(130,y-310)
label:SetText("Weapons")
local button = vgui.Create("DButton",frame)
button:SetText("ACR")
button:SetSize(100,20)
button:SetPos(130,y-290)
button.DoClick = function()
	net.Start("neww")
	net.WriteString("weapon_mw2_acr")
	net.SendToServer()
	frame:Close()
end	
local button = vgui.Create("DButton",frame)
button:SetText("F200")
button:SetSize(100,20)
button:SetPos(130,y-270)
button.DoClick = function()
	net.Start("neww")
	net.WriteString("weapon_mw2_f2000")
	net.SendToServer()
	frame:Close()
end	
local button = vgui.Create("DButton",frame)
button:SetText("Intervention")
button:SetSize(100,20)
button:SetPos(130,y-250)
button.DoClick = function()
	net.Start("neww")
	net.WriteString("weapon_mw2_intervention")
	net.SendToServer()
	frame:Close()
end	
local button = vgui.Create("DButton",frame)
button:SetText("M4")
button:SetSize(100,20)
button:SetPos(130,y-230)
button.DoClick = function()
	net.Start("neww")
	net.WriteString("weapon_mw2_m4")
	net.SendToServer()
	frame:Close()
end
local button = vgui.Create("DButton",frame)
button:SetText("MP5K")
button:SetSize(100,20)
button:SetPos(130,y-210)
button.DoClick = function()
	net.Start("neww")
	net.WriteString("weapon_mw2_mp5k")
	net.SendToServer()
	frame:Close()
end
local button = vgui.Create("DButton",frame)
button:SetText("UMP45")
button:SetSize(100,20)
button:SetPos(130,y-190)
button.DoClick = function()
	net.Start("neww")
	net.WriteString("weapon_mw2_ump45")
	net.SendToServer()
	frame:Close()
end

end

function GM:Think()
	local plk = LocalPlayer()
 		if(kfrags<plk:Frags()) then
 			kfrags=plk:Frags()
 			kd = kd + 1
 		elseif(kdeaths<plk:Deaths()) then
			kdeaths= plk:Deaths()
			kd = 0
 		end
 		if(plk:Deaths()>deathcount) then
 			deathcount = plk:Deaths()
 			ChooseGun()
 		end
 	net.Start("killstreak")
 	net.WriteInt(kd,16)
 	net.SendToServer()
end
	
	