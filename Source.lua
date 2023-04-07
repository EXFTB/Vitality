--[[
This script has been discontinued, and is no longer in use;
With that said, I've released the source to the script that I have made

I don't care what you do with it, however if you sell this, then you're a fagget

Enjoy!
]]
local HM = 5602055394
local HMV = 7951883376

if game.PlaceId == HM or game.PlaceId == HMV then
	local Success, Error = pcall(function()
		repeat
			wait()
		until game:IsLoaded()

		--# Region // No Logs
		game:GetService("RunService").RenderStepped:Connect(function()
			for _, Connection in next, getconnections(game:GetService("ScriptContext").Error) do
				Connection:Disable()
			end

			for _, Connection in next, getconnections(game:GetService("LogService").MessageOut) do
				Connection:Disable()
			end
		end)
		--# Region // End

		--# Region // Services
		local game = game
		local Services = game.GetService

		local Workspace = Services(game, "Workspace")
		local Players = Services(game, "Players")
		local RunService = Services(game, "RunService")
		local ReplicatedStorage = Services(game, "ReplicatedStorage")
		local StarterGui = Services(game, "StarterGui")
		local TeleportService = Services(game, "TeleportService")
		local UserInputService = Services(game, "UserInputService")
		--# Region // End

		--# Region // Variables
		local Client = Players.LocalPlayer
		local Mouse = Client:GetMouse()
		local Camera = Workspace.CurrentCamera
		--# Region // End

		--# Region // Framework Variables
		local UIFramework =
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EXFTB/Vitality/main/UIFramework.lua"))()
		local ESPFramework =
			loadstring(game:HttpGet("https://raw.githubusercontent.com/EXFTB/Vitality/main/ESPFramework.lua"))()
		local NOTIFICATIONFramework = loadstring(
			game:HttpGet("https://raw.githubusercontent.com/EXFTB/Vitality/main/NOTIFICATIONFramework.lua")
		)()
		--# Region // End

		--# Region // Modules
		local Lighting = require(ReplicatedStorage.Modules.Lightning)
		local Xeno = require(ReplicatedStorage.Modules.Xeno)
		local CameraShaker = require(ReplicatedStorage.Modules.CameraShaker)
		--# Region // End

		--# Region // Bools
		local SectionTarget = nil
		local AimbotTarget = nil
		local ChosenGun = nil
		local ChosenOther = nil
		local ChosenArmor = nil
		local StreamableTarget = nil
		local HitsoundID = nil

		local StreamableKey = "v"
		local AimbotKey = "q"
		local AimbotAimpart = "HumanoidRootPart"
		local StreamableAimpart = "HumanoidRootPart"

		local AimbotPrediction = 3.2
		local AimbotSettingsThickness = 2.9
		local AimbotSettingsTransparency = 1
		local AimbotSettingsColor = Color3.fromRGB(44, 44, 195)
		local StreamablePrediction = 2.9
		local StreamableSmoothness = 0.1
		local DesyncStrength = 0
		local VelocityX = 0
		local VelocityY = 0
		local VelocityZ = 0
		local AnimationSpeed = 1
		local DeathReturnPosition = CFrame.new()
		local OldCFrame = CFrame.new()
		local OldDesyncCF = CFrame.new()
		local CFrameSpeed = 4
		local Flyspeed = 4
		local StrafeSpeed = 0.6
		local StrafeDistance = 10
		local StrafeHeight = 4
		local CrashStrength = 2
		local SpinBotSpeed = 50

		local StompChanger = false

		local ServerStomps = false
		local ClientStomps = false

		local YeetServerStomp = false
		local GokuServerStomp = false
		local ScorpionServerStomp = false
		local UppercutServerStomp = false
		local GroundSmashServerStomp = false
		local EnhancedVisionServerStomp = false

		local Lightning = false
		local ShinySpirit = false
		local Shapeshifter = false
		local Dragon = false
		local Rune = false
		local Kameha = false
		local Destroyer = false
		local Megalodon = false

		local Flying = false
		local StarDetector = false
		local AntiAimView = false
		local AutoReload = false
		local OrbitStrafeType = false
		local RandomizeStrafeType = false
		local Aimbot = false
		local AimbotEnabled = false
		local AimbotResolver = false
		local AimbotAutoPrediction = false
		local AimbotLookAt = false
		local AimbotHitboxExtender = false
		local AimbotHighlightTarget = false
		local AimbotTracerTarget = false
		local TargetStrafe = false
		local Streamable = false
		local StreamableEnabled = false
		local GunSelected = false
		local OtherSelected = false
		local ArmorSelected = false
		local HoldingSpace = false
		local CFrameDesync = false
		local CustomAnimationSpeed = false
		local SpinbotAA = false
		local ChatSpy = false
		local FistAura = false
		local StompAura = false
		local Deathreturn = false
		local VelocityAA = false
		local Desync = false
		local CFrameMovement = false
		local TrashTalk = false
		local InfiniteJump = false
		local Teleporting = false
		local StompFarm = false
		local Reach = false
		local Flinging = false
		local AutoCollectAirdrops = false
		local NoJumpCoolDown = false
		local AntiFall = false
		local NeedsRespawn = false
		local HasPiviot = false

		local KeysTable = {
			["W"] = false,
			["A"] = false,
			["S"] = false,
			["D"] = false,
		}
		--# Region // End

		--# Region // Functions

		local function swait(n)
			n = n or 0.05
			local startTime = os.clock()

			while os.clock() - startTime < n do
				task.wait(0.000000000000000001)
			end
		end

		function EquipTool(Item)
			for i, v in next, Client.Backpack:GetChildren() do
				if v.Name == Item then
					v.Parent = Client.Character
				end
			end
		end

		function UnEquipTool(Item)
			for i, v in next, Client.Character:GetChildren() do
				if v.Name == Item then
					v.Parent = Client.Backpack
				end
			end
		end

		function PlaySound(SoundId, Time)
			Client.Character.Humanoid:UnequipTools()

			EquipTool("[Boombox]")

			ReplicatedStorage.MainRemote:FireServer("Play", SoundId)

			UnEquipTool("[Boombox]")

			swait(Time)

			EquipTool("[Boombox]")

			ReplicatedStorage.MainRemote:FireServer("Stop")

			UnEquipTool("[Boombox]")
		end

		function PlayAnimation(AnimId, StopValue)
			local Humanoid = Client.Character:FindFirstChildOfClass("Humanoid")
				or Client.Character:FindFirstChildOfClass("AnimationController")
			if StopValue then
				for i, v in next, Humanoid:GetPlayingAnimationTracks() do
					v:Stop()
				end
			end

			local Animation = Instance.new("Animation")
			Animation.AnimationId = AnimId
			local Track = Client.Character.Humanoid:LoadAnimation(Animation)
			Track:Play()
		end

		function StopAnims()
			local Humanoid = Client.Character:FindFirstChildOfClass("Humanoid")
				or Client.Character:FindFirstChildOfClass("AnimationController")
			for i, v in next, Humanoid:GetPlayingAnimationTracks() do
				v:Stop()
			end
		end

		function CheckForSFX(Target)
			if YeetServerStomp then
				local LookV = Client.Character.HumanoidRootPart.CFrame.LookVector

				local BodyVel = Instance.new("BodyVelocity")
				BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel.Parent = Target.Parent.LowerTorso
				BodyVel.Velocity = Vector3.new(0, 0, 0)

				swait(0.07)

				spawn(function()
					PlaySound("525743689", 0.6)
				end)

				task.delay(0, function()
					for i = 1, 20 do
						BodyVel.Velocity = Vector3.new(0, 170, 0) + LookV * 220
						RunService.RenderStepped:Wait()
					end
				end)

				spawn(function()
					swait(0.9)
					BodyVel:Destroy()
				end)
			end

			if GokuServerStomp then
				local LookV = Client.Character.HumanoidRootPart.CFrame.LookVector

				local BodyVel = Instance.new("BodyVelocity")
				BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel.Parent = Target.Parent.LowerTorso
				BodyVel.Velocity = Vector3.new(0, 0, 0)

				local BodyVel2 = Instance.new("BodyVelocity")
				BodyVel2.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel2.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel2.Parent = Client.Character.LowerTorso
				BodyVel2.Velocity = Vector3.new(0, 0, 0)

				swait(0.55)

				spawn(function()
					for i = 1, 50 do
						BodyVel.Velocity = LookV * 5 + Vector3.new(0.2, 2, 0)
						RunService.RenderStepped:Wait()
					end
				end)

				spawn(function()
					PlayAnimation("http://www.roblox.com/asset/?id=10714389396", true)
				end)

				spawn(function()
					PlaySound("8918040963", 1.8)
					swait(0.05)
					PlaySound("610327604", 2.3)
				end)

				swait(1.8)

				spawn(function()
					BodyVel.Velocity = LookV * 730
				end)

				spawn(function()
					swait(0.4)
					BodyVel2:Destroy()
					swait(0.5)
					BodyVel:Destroy()
				end)
			end

			if ScorpionServerStomp then
				local LookV = Client.Character.HumanoidRootPart.CFrame.LookVector

				local BodyVel = Instance.new("BodyVelocity")
				BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel.Parent = Target.Parent.LowerTorso
				BodyVel.Velocity = Vector3.new(0, 0, 0)

				swait(0.55)

				spawn(function()
					PlayAnimation("http://www.roblox.com/asset/?id=7591947743", false)
					swait(1.1)
					PlayAnimation("http://www.roblox.com/asset/?id=7591841541", false)
					swait(1.9)
					PlayAnimation("http://www.roblox.com/asset/?id=9790031853", false)
				end)

				spawn(function()
					PlaySound("507150998", 0.6)
					swait(0.06)
					PlaySound("203773793", 1.23)
					swait(1.25)
					PlaySound("6808975002", 1.55)
				end)

				swait(0.5)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, 100, 0) + LookV * 280
					swait(0.2)
					BodyVel.Velocity = Vector3.new(0, 0, 0)
				end)

				swait(1.1)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, -40, 0) + LookV * -145
					swait(0.4)
					BodyVel.Velocity = Vector3.new(0, 0, 0)
				end)

				swait(1.6)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, 10, 0) + LookV * 730
				end)

				spawn(function()
					swait(0.9)
					BodyVel:Destroy()
				end)
			end

			if UppercutServerStomp then
				local LookV = Client.Character.HumanoidRootPart.CFrame.LookVector

				local BodyVel = Instance.new("BodyVelocity")
				BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel.Parent = Target.Parent.LowerTorso
				BodyVel.Velocity = Vector3.new(0, 0, 0)

				swait(0.55)

				spawn(function()
					PlayAnimation("http://www.roblox.com/asset/?id=7591947743", false)
				end)

				spawn(function()
					PlaySound("845287176", 3.35)
				end)

				swait(0.5)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, 230, 0) + LookV * 430
				end)

				spawn(function()
					swait(0.9)
					BodyVel:Destroy()
				end)
			end

			if GroundSmashServerStomp then
				local LookV = Client.Character.HumanoidRootPart.CFrame.LookVector

				local BodyVel = Instance.new("BodyVelocity")
				BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel.Parent = Target.Parent.LowerTorso
				BodyVel.Velocity = Vector3.new(0, 0, 0)

				local BodyVel2 = Instance.new("BodyVelocity")
				BodyVel2.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel2.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel2.Parent = Client.Character.LowerTorso
				BodyVel2.Velocity = Vector3.new(0, 0, 0) + LookV * -3

				swait(0.55)

				spawn(function()
					PlayAnimation("http://www.roblox.com/asset/?id=8671451936", false)
					swait(0.9)
					PlayAnimation("http://www.roblox.com/asset/?id=9737194696", false)
					swait(1.1)
					StopAnims()
					wait(0.07)
					PlayAnimation("http://www.roblox.com/asset/?id=9790017938 ", false)
				end)

				spawn(function()
					swait(0.4)
					PlaySound("541909983", 0.5)
					swait(0.3)
					PlaySound("9758530498", 0.7)
					swait(0.1)
					PlaySound("548348185", 1.15)
				end)

				swait(0.6)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, 70, 0) + LookV * 60
					swait(0.2)
					BodyVel.Velocity = Vector3.new(0, 0, 0)
				end)

				swait(0.7)

				spawn(function()
					BodyVel2.Velocity = Vector3.new(0, 75, 0) + LookV * 62
					swait(0.2)
					BodyVel2.Velocity = Vector3.new(0, 0, 0)
					swait(1.1)
					BodyVel2:Destroy()
				end)

				swait(1.15)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, -530, 0) + LookV * 220
				end)

				spawn(function()
					swait(0.9)
					BodyVel:Destroy()
				end)
			end

			if EnhancedVisionServerStomp then
				local LookV = Client.Character.HumanoidRootPart.CFrame.LookVector

				local BodyVel = Instance.new("BodyVelocity")
				BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel.Parent = Target.Parent.LowerTorso
				BodyVel.Velocity = Vector3.new(0, 0, 0)

				local BodyVel2 = Instance.new("BodyVelocity")
				BodyVel2.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
					.. "A-C"
					.. game.GameId
				BodyVel2.MaxForce = Vector3.new("inf", "inf", "inf")
				BodyVel2.Parent = Client.Character.LowerTorso
				BodyVel2.Velocity = Vector3.new(0, 0, 0)

				swait(0.55)

				spawn(function()
					PlayAnimation("http://www.roblox.com/asset/?id=8662201039", false)
					swait(0.9)
					StopAnims()
					swait(0.28)
					PlayAnimation("http://www.roblox.com/asset/?id=7867694778", false)
					swait(1.1)
					PlayAnimation("http://www.roblox.com/asset/?id=8673230426", false)
				end)

				spawn(function()
					PlaySound("405596045", 1.2)
					swait(0.05)
					PlaySound("1043228969", 0.7)
					swait(0.95)
					PlaySound("558640653", 0.6)
				end)

				swait(1)

				spawn(function()
					BodyVel.Velocity = Vector3.new(0, 10, 0) + LookV * 83
					swait(0.3)
					BodyVel.Velocity = Vector3.new(0, 0, 0)
				end)

				swait(0.6)

				spawn(function()
					BodyVel2.Velocity = Vector3.new(0, 1, 0) + LookV * 75
					swait(0.3)
					BodyVel2.Velocity = Vector3.new(0, 0, 0)
					swait(1.4)
					BodyVel2:Destroy()
				end)

				swait(1.4)

				spawn(function()
					BodyVel.Velocity = LookV * 730
				end)

				spawn(function()
					swait(0.9)
					BodyVel:Destroy()
				end)
			end
		end

		function CheckForFX(Target)
			if Lightning then
				task.delay(0, function()
					local v40 = Lighting.Bolt(
						(CFrame.new(Target.CFrame.p) * CFrame.new(0, 250, 0) * CFrame.new(
							math.random(-1, 1),
							math.random(-1, 1),
							math.random(-1, 1)
						)).Position,
						(Target.CFrame * CFrame.new(math.random(-2, 2), math.random(-1, 1), math.random(-1, 1))).Position,
						10,
						0.25,
						false
					)
					v40.PulseSpeed = 12
					v40.PulseLength = 5
					v40.MinRadius = 0
					v40.MaxRadius = 5
					v40.FadeLength = 0.1
					v40.Thickness = 3
					v40.MinTransparency = 0.25
					v40.MaxTransparency = 0.3
					v40.Color = Color3.fromRGB(251, 255, 16)
				end)

				local StompEffect = ReplicatedStorage.KillFX["Lightning"].Stomp:Clone()
				StompEffect.Parent = Target.Parent.UpperTorso or Target
				StompEffect:Play()
				game.Debris:AddItem(StompEffect, 4)

				local StompEffect = ReplicatedStorage.KillFX["Lightning"].HitPart:Clone()
				StompEffect.Parent = workspace.Ignored.Animations
				StompEffect.CFrame = CFrame.new(Target.CFrame.Position)
				task.delay(0.25, function()
					for i, v in pairs(StompEffect.Attachment:GetChildren()) do
						v.Enabled = false
					end
				end)

				task.delay(0.1, function()
					ReplicatedStorage.KillFX["Lightning"].FireEffect:Clone().Parent = Target.Parent.UpperTorso
					for i, v in pairs(Target.Parent:GetDescendants()) do
						if v:IsA("Basepart") and not v:IsA("MeshPart") then
							v.Color = Color3.fromRGB(0, 0, 0)
						elseif v:IsA("Shirt") or v:IsA("Pants") then
							v.Color3 = Color3.fromRGB(0, 0, 0)
						elseif v:IsA("Mesh") then
							v.VertexColor = Color3.fromRGB(0, 0, 0)
						elseif v:IsA("MeshPart") then
							v.TextureID = ""
							v.Color = Color3.fromRGB(0, 0, 0)
						end
					end
				end)
				game.Debris:AddItem(StompEffect, 4)
			elseif Name == "Rings" then
				local StompEffect = ReplicatedStorage.KillFX["Lightning"].Ring:Clone()
				StompEffect.Parent = Target.Parent.UpperTorso or Target
				StompEffect:Play()
				game.Debris:AddItem(StompEffect, 2)

				local StompEffect = ReplicatedStorage.KillFX["Lightning"].Part:Clone()
				StompEffect.Parent = workspace.Ignored.Animations
				StompEffect.Position = Target.Position
				task.delay(0.35, function()
					StompEffect.Attachment.Particle.Enabled = false
				end)
			end

			if ShinySpirit then
				local StompEffect = ReplicatedStorage.KillFX["Shiny Spirit"].Stomp:Clone()
				StompEffect.Parent = Target.Parent.UpperTorso or Target
				StompEffect:Play()
				game.Debris:AddItem(StompEffect, 4)
				local Effect = ReplicatedStorage.KillFX["Shiny Spirit"].Spirit:Clone()
				Effect.Parent = workspace.Ignored.Animations
				Effect.PrimaryPart.CFrame = Client.Character.HumanoidRootPart.CFrame * CFrame.new(0, 48, 25)
				local Son
				if Client and Client:FindFirstChild("Information") then
					Son = Client:FindFirstChild("Information").RayColor.Value
					for i, v in pairs(Effect:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") then
							v.Color = Son
						elseif v.Name == "Effect" then
							v.Color = ColorSequence.new({

								ColorSequenceKeypoint.new(0, Son),
								ColorSequenceKeypoint.new(1, Son),
							})
						end
					end
				end

				game.Debris:AddItem(Effect, 4.5)
				local Anim = Effect.Anim:LoadAnimation(Effect.Animation)
				Anim:Play()
				local Lol2
				Lol2 = Anim:GetMarkerReachedSignal("PUNCH"):Connect(function()
					local Bro = game.ReplicatedStorage.VFX.EXL:Clone()
					Bro.Parent = workspace.Ignored.Animations
					Bro.Position = Target.Position
					game:GetService("TweenService")
						:Create(
							Bro,
							TweenInfo.new(2),
							{ Position = Target.Position + Vector3.new(0, 50, 0), Orientation = Vector3.new(0, 200, 0) }
						)
						:Play()
					game:GetService("TweenService")
						:Create(Bro, TweenInfo.new(2), { Size = Vector3.new(120, 160, 120) })
						:Play()
					game:GetService("TweenService"):Create(Bro, TweenInfo.new(2), { Transparency = 1 }):Play()
					Bro.Sound.Volume = 2
					Bro.Sound:Play()
					game.Debris:AddItem(Bro, 2)

					local position = Target.Position

					local SOnFocus = game.ReplicatedStorage.Adicd.Shock:Clone()
					SOnFocus.Parent = workspace.Ignored.Animations
					SOnFocus.Color = Son and Son or Effect.Head.Color
					SOnFocus.Position = position
					game.TweenService
						:Create(
							SOnFocus,
							TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
							{
								Orientation = Vector3.new(0, 200, 0),
								Position = position,
								Size = SOnFocus.Size + Vector3.new(50, 5, 50),
								Transparency = 1,
							}
						)
						:Play()
					game.Debris:AddItem(SOnFocus, 2.5)

					local SOnFocus = game.ReplicatedStorage.Adicd.Wind:Clone()
					SOnFocus.Parent = workspace.Ignored.Animations
					SOnFocus.Color = Son and Son or Effect.Head.Color
					SOnFocus.Position = position
					game.TweenService
						:Create(
							SOnFocus,
							TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
							{
								Orientation = Vector3.new(0, -200, 0),
								Position = position,
								Size = SOnFocus.Size + Vector3.new(30, 2, 30),
								Transparency = 1,
							}
						)
						:Play()
					game.Debris:AddItem(SOnFocus, 3)

					Effect["Left Arm"].Delete:Destroy()
					Bro.Color = Son and Son or Effect.Head.Color
					for i, v in pairs(Target.Parent:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Decal") then
							game:GetService("TweenService")
								:Create(v, TweenInfo.new(0.5), {
									Transparency = 1,
								})
								:Play()
						end
					end
					Lol2:Disconnect()
				end)

				delay(3.5, function()
					for i, v in pairs(Effect:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Decal") then
							game:GetService("TweenService")
								:Create(v, TweenInfo.new(0.5), {
									Transparency = 1,
								})
								:Play()
						elseif v:IsA("ParticleEmitter") then
							delay(0, function()
								for i = 0, 1, 0.1 do
									v.Transparency = NumberSequence.new({
										NumberSequenceKeypoint.new(0, 0),
										NumberSequenceKeypoint.new(1, i),
									})
									swait(0.01)
								end
							end)
						end
					end
				end)
			end

			if Shapeshifter then
				local Son = Target.Parent.UpperTorso or Target
				local StompEffect = ReplicatedStorage.KillFX["Shapeshifter"].Stomp:Clone()
				StompEffect.Parent = Target.Parent.UpperTorso or Target
				StompEffect:Play()
				game.Debris:AddItem(StompEffect, 5)

				local Effect = ReplicatedStorage.KillFX["Shapeshifter"].Spirit:Clone()
				Effect.Parent = workspace.Ignored.Animations
				Effect.PrimaryPart.CFrame = Client.Character.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)

				if Client and Client:FindFirstChild("Information") then
					for i, v in pairs(Effect:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") then
							v.Color = Client:FindFirstChild("Information").RayColor.Value
						end
					end
				end
				game.Debris:AddItem(Effect, 5)
				local Anim = Effect.Sonned:LoadAnimation(Effect.Animation)
				Anim:Play()
				local Lol2
				local Lol1
				local Lol3
				Lol2 = Anim:GetMarkerReachedSignal("GRAB"):Connect(function()
					local Son = Effect.HumanoidRootPart:FindFirstChildOfClass("BodyPosition")
					Son.Parent = Target.Parent.UpperTorso
					coroutine.wrap(function()
						repeat
							Son.Position = Effect.GRABBER.Position
							swait()
						until Effect.Parent == nil or Son.Parent == nil
						if Son.Parent ~= nil then
							Son:Destroy()
						end
					end)()
					Lol2:Disconnect()
				end)

				Lol1 = Anim:GetMarkerReachedSignal("KILL"):Connect(function()
					local Bro = game.ReplicatedStorage.VFX.AURAAAAA:Clone()
					Bro.Parent = workspace.Ignored.Animations
					Bro.Position = Target.Position
					game:GetService("TweenService")
						:Create(Bro, TweenInfo.new(2), { Position = Target.Position + Vector3.new(0, 50, 0) })
						:Play()
					game:GetService("TweenService")
						:Create(Bro.Mesh, TweenInfo.new(2), { Scale = Vector3.new(120, 90, 120) })
						:Play()
					game:GetService("TweenService"):Create(Bro, TweenInfo.new(2), { Transparency = 1 }):Play()
					Bro.Sound:Play()
					game.Debris:AddItem(Bro, 2)
					Bro.Color = Client:FindFirstChild("Information")
							and Client:FindFirstChild("Information").RayColor.Value
						or Effect.Head.Color
					for i, v in pairs(Target.Parent:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Decal") then
							game:GetService("TweenService")
								:Create(v, TweenInfo.new(0.5), {
									Transparency = 1,
								})
								:Play()
						end
					end
					local sound = Instance.new("Sound", Target.Parent.UpperTorso or Target)
					sound.SoundId = "rbxassetid://821439273"
					sound:Play()
					local a1 = Instance.new("Attachment", Target.Parent.UpperTorso or Target)
					local a2 = Instance.new("Attachment", workspace.Terrain)
					a2.WorldPosition = Vector3.new(
						Son.Position.X + math.random(-1000, 1000),
						Son.Position.Y + 1000,
						Son.Position.Z + math.random(-1000, 1000)
					)
					local Beam = game.ReplicatedStorage.KillFX.Shapeshifter.Beam:Clone()
					Beam.Parent = workspace
					Beam.Attachment0 = a1
					Beam.Attachment1 = a2
					coroutine.wrap(function()
						for i = 0, 2, 0.025 do
							Beam.Transparency = NumberSequence.new(i)
							game:GetService("RunService").Heartbeat:wait()
						end
						a2:Destroy()
					end)()
					Lol1:Disconnect()
				end)

				Lol3 = Anim:GetMarkerReachedSignal("END"):Connect(function()
					for i, v in pairs(Effect:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Decal") then
							game:GetService("TweenService")
								:Create(v, TweenInfo.new(0.6), {
									Transparency = 1,
								})
								:Play()
						end
					end
					Lol3:Disconnect()
				end)
			end

			if Rune then
				local position = Target.Position + Vector3.new(0, 120, 0)
				local allrings = {}
				local doney = false
				for i = 5, 1, -1 do
					if i == 1 then
						local StompEffect = ReplicatedStorage.KillFX["Rune"][i]:Clone()
						StompEffect.Position = position
						StompEffect.Sound:Play()
						StompEffect.Parent = workspace.Ignored.Animations
						game.TweenService
							:Create(
								StompEffect,
								TweenInfo.new(1.25, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0),
								{ Size = Vector3.new(60 * i, 0, 60 * i), Position = position }
							)
							:Play()
						table.insert(allrings, StompEffect)
						task.delay(0, function()
							repeat
								StompEffect.Orientation = StompEffect.Orientation
									+ Vector3.new(0, i % 2 == 0 - 5 or 5, 0)
								swait(0.01)
							until doney == true
						end)
						for i, v in pairs(StompEffect:GetChildren()) do
							if v:IsA("Decal") then
								game.TweenService
									:Create(
										v,
										TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
										{ Transparency = 0 }
									)
									:Play()
							end
						end
					elseif i <= 4 then
						local StompEffect = ReplicatedStorage.KillFX["Rune"][i]:Clone()
						StompEffect.Position = position
						StompEffect.Sound:Play()
						StompEffect.Parent = workspace.Ignored.Animations
						game.TweenService
							:Create(
								StompEffect,
								TweenInfo.new(1.25, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0),
								{ Size = Vector3.new(20 * i, 0, 20 * i), Position = position }
							)
							:Play()
						table.insert(allrings, StompEffect)
						task.delay(0, function()
							repeat
								StompEffect.Orientation = StompEffect.Orientation
									+ Vector3.new(0, i % 2 == 0 - 5 or 5, 0)
								swait(0.01)
							until doney == true
						end)
						for i, v in pairs(StompEffect:GetChildren()) do
							if v:IsA("Decal") then
								game.TweenService
									:Create(
										v,
										TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
										{ Transparency = 0 }
									)
									:Play()
							end
						end
					elseif i == 5 then
						local StompEffect = ReplicatedStorage.KillFX["Rune"].Part3:Clone()
						StompEffect.Position = position
						StompEffect.Parent = workspace.Ignored.Animations
						table.insert(allrings, StompEffect)
						StompEffect.Sound:Play()
						game.TweenService
							:Create(
								StompEffect,
								TweenInfo.new(2, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut, 0),
								{ Size = Vector3.new(89, 0, 89), Position = position }
							)
							:Play()
						task.delay(0, function()
							repeat
								StompEffect.Orientation = StompEffect.Orientation + Vector3.new(0, 5, 0)
								swait(0.01)
							until doney == true
						end)
						for i, v in pairs(StompEffect:GetChildren()) do
							if v:IsA("Decal") then
								game.TweenService
									:Create(
										v,
										TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
										{ Transparency = 0 }
									)
									:Play()
							end
						end
					end
					position = position - Vector3.new(0, 15, 0)
					swait(i / 6)
				end

				swait(1)
				doney = true
				for i, v in pairs(allrings) do
					local StompEffect = v
					game.TweenService
						:Create(
							StompEffect,
							TweenInfo.new(0.7 + i / 4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0),
							{
								Size = v.Size + Vector3.new(
									v.Size.Z / 2 + 80 + (i * 3),
									0,
									v.Size.Z / 2 + 80 + (i * 3)
								),
								Position = position + Vector3.new(0, StompEffect.Position.Y + 20 + (i * 5), 0),
								Orientation = Vector3.new(0, -1200),
							}
						)
						:Play()

					for i, v in pairs(StompEffect:GetChildren()) do
						if v:IsA("Decal") then
							game.TweenService
								:Create(
									v,
									TweenInfo.new(0.7 + i / 4, Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),
									{ Transparency = 1 }
								)
								:Play()
						end
					end
					swait(0.05)
				end

				local bullet = game.ReplicatedStorage.KillFX.Rune.CYLD:Clone()
				bullet.Parent = workspace.Ignored.Animations
				bullet.Anchored = true
				bullet.CanCollide = false
				bullet.Color = Color3.fromRGB(20, 122, 255)
				bullet.Transparency = 0.2
				bullet.Material = Enum.Material.Neon
				bullet.Shape = Enum.PartType.Cylinder
				game.Debris:AddItem(bullet, 5)
				local S = Instance.new("Sound", bullet)
				S.SoundId = "rbxassetid://6808975002"
				S.Volume = 1
				S:Play()
				local POT = Target.Position
				local origin = Vector3.new(POT.X, POT.Y + 400, POT.Z)
				local target = Vector3.new(POT.X, POT.Y - 20, POT.Z)
				local ray = Ray.new(origin, (target - origin).unit * 500)
				local hit, position =
					game.Workspace:FindPartOnRayWithIgnoreList(ray, { workspace.Ignored, workspace.Characters })
				local distance = (origin - position).Magnitude
				bullet.Size = Vector3.new(distance, 0.5, 0.5)
				bullet.CFrame = CFrame.new(origin, target)
					* CFrame.new(0, 0, -distance / 2)
					* CFrame.Angles(0, math.rad(90), 0)

				coroutine.wrap(function()
					delay(0, function()
						repeat
							for i, v in pairs(bullet:GetChildren()) do
								if v:IsA("Beam") then
									bullet.Attachment.WorldPosition = bullet.Position + Vector3.new(0, bullet.Size.X, 0)
									bullet.ATT.WorldPosition = bullet.Position + Vector3.new(0, -bullet.Size.X, 0)
									v.Width0 = bullet.Size.Z / 1.5
									v.Width1 = bullet.Size.Z / 1.5
								end
							end
							swait()
						until bullet.Parent == nil
					end)

					local E = game:GetService("TweenService"):Create(
						bullet,
						TweenInfo.new(0.5),
						{ Transparency = 0.8, Size = Vector3.new(distance, 30, 30) }
					)
					E:Play()
					E.Completed:Wait()
					local E =
						game:GetService("TweenService")
							:Create(bullet, TweenInfo.new(2), { Transparency = 1, Size = Vector3.new(distance, 0, 0) })
					E:Play()
				end)()

				local position = Target.Position

				local SOnFocus = game.ReplicatedStorage.Adicd.Shock:Clone()
				SOnFocus.Parent = workspace.Ignored.Animations

				SOnFocus.Position = position
				game.TweenService
					:Create(
						SOnFocus,
						TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
						{
							Orientation = Vector3.new(0, 200, 0),
							Position = position,
							Size = SOnFocus.Size + Vector3.new(100, 20, 100),
							Transparency = 1,
						}
					)
					:Play()
				game.Debris:AddItem(SOnFocus, 2.5)

				local SOnFocus = game.ReplicatedStorage.Adicd.Wind:Clone()
				SOnFocus.Parent = workspace.Ignored

				SOnFocus.Position = position
				game.TweenService
					:Create(
						SOnFocus,
						TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
						{
							Orientation = Vector3.new(0, -200, 0),
							Position = position,
							Size = SOnFocus.Size + Vector3.new(100, 5, 100),
							Transparency = 1,
						}
					)
					:Play()
				game.Debris:AddItem(SOnFocus, 3)
				local SOnFocus = game.ReplicatedStorage.Adicd.Root:Clone()
				SOnFocus.Parent = workspace.Ignored

				SOnFocus.Position = position
				game.TweenService
					:Create(
						SOnFocus,
						TweenInfo.new(2.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In),
						{
							Orientation = Vector3.new(0, -200, 0),
							Position = position,
							Size = SOnFocus.Size + Vector3.new(100, 100, 100),
							Transparency = 1,
						}
					)
					:Play()
				game.Debris:AddItem(SOnFocus, 2.5)

				local s = Instance.new("Sound", SOnFocus)
				s.Name = "expolsion"
				s.SoundId = "rbxassetid://6554844728"
				s:Play()
				s.Volume = 1
				game.Debris:AddItem(s, 6)
				game.Debris:AddItem(SOnFocus, 7)
				local s = Instance.new("Sound", SOnFocus)
				s.Name = "expolsion"
				s.SoundId = "rbxassetid://6230611917"
				s:Play()
				s.Volume = 1
				game.Debris:AddItem(s, 4)
			end

			if Dragon then
				local StompEffect = ReplicatedStorage.KillFX["Dragon"].Stomp:Clone()
				StompEffect.Parent = Target.Parent.UpperTorso or Target
				StompEffect:Play()
				game.Debris:AddItem(StompEffect, 4)
				local Explosion = ReplicatedStorage.KillFX["Dragon"].DragonFly:Clone()
				Explosion.Parent = workspace.Ignored.Animations
				Explosion.PrimaryPart.CFrame = CFrame.new(Target.Position)
				local Son = Explosion.AC:LoadAnimation(Explosion.Animation)
				Son:Play()
				game.Debris:AddItem(Explosion, 6)
				if Client and Client:FindFirstChild("Information") then
					for i, v in pairs(Explosion:GetDescendants()) do
						if v:IsA("BasePart") or v:IsA("MeshPart") then
							v.Color = Client:FindFirstChild("Information").RayColor.Value
						end
					end
					Explosion.Head.Trail.Color = ColorSequence.new(
						Client:FindFirstChild("Information").RayColor.Value,
						Client:FindFirstChild("Information").RayColor.Value
					)
				end

				local Lol2
				Lol2 = Son:GetMarkerReachedSignal("START"):Connect(function()
					Explosion.Head.Transparency = 0
					Explosion.Head.Trail.Enabled = true

					local Lol5
					Lol5 = Son:GetMarkerReachedSignal("END"):Connect(function()
						Explosion.Head.Trail.Enabled = false
						game.TweenService:Create(Explosion.Head, TweenInfo.new(0.5), { Transparency = 1 }):Play()
						local StompEffect = ReplicatedStorage.KillFX["Dragon"].Sound:Clone()
						StompEffect.Parent = Target.Parent.UpperTorso or Target
						StompEffect:Play()
						game.Debris:AddItem(StompEffect, 4)

						local bullet = Instance.new("Part", workspace.Ignored.Animations)
						bullet.Anchored = true
						bullet.CanCollide = false
						bullet.Color = Client:FindFirstChild("Information").RayColor.Value
							or Color3.fromRGB(85, 170, 255)
						bullet.Transparency = 0.5
						bullet.Material = Enum.Material.Neon
						bullet.Shape = Enum.PartType.Cylinder
						local S = Instance.new("Sound", bullet)
						S.SoundId = "rbxassetid://6808975002"
						S.Volume = 1
						S:Play()
						local POT = Target.Position
						local origin = Vector3.new(POT.X, POT.Y + 400, POT.Z)
						local target = Vector3.new(POT.X, POT.Y - 20, POT.Z)
						local ray = Ray.new(origin, (target - origin).unit * 500)
						local hit, position = game.Workspace:FindPartOnRayWithIgnoreList(
							ray,
							{ workspace.Ignored.Animations, workspace.Characters }
						)
						local distance = (origin - position).Magnitude
						bullet.Size = Vector3.new(distance, 0.5, 0.5)
						bullet.CFrame = CFrame.new(origin, target)
							* CFrame.new(0, 0, -distance / 2)
							* CFrame.Angles(0, math.rad(90), 0)

						coroutine.wrap(function()
							local E = game:GetService("TweenService"):Create(
								bullet,
								TweenInfo.new(0.5),
								{ Transparency = 0.8, Size = Vector3.new(distance, 30, 30) }
							)
							E:Play()
							E.Completed:Wait()
							local E = game:GetService("TweenService"):Create(
								bullet,
								TweenInfo.new(2),
								{ Transparency = 1, Size = Vector3.new(distance, 0, 0) }
							)
							E:Play()
						end)()

						for i, v in pairs(Target.Parent:GetDescendants()) do
							if v:IsA("BasePart") or v:IsA("MeshPart") or v:IsA("Decal") then
								game:GetService("TweenService")
									:Create(v, TweenInfo.new(0.5), {
										Transparency = 1,
									})
									:Play()
							end
						end

						local Explosion = ReplicatedStorage.KillFX["Lotus"].FX:Clone()
						Explosion.Parent = workspace.Ignored.Animations
						Explosion.PrimaryPart.CFrame = CFrame.new(Target.Position)
						Explosion.PrimaryPart.Sound:Play()

						if Client and Client:FindFirstChild("Information") then
							for i, v in pairs(Explosion:GetDescendants()) do
								if v:IsA("BasePart") or v:IsA("MeshPart") then
									v.Color = Client:FindFirstChild("Information").RayColor.Value
								end
							end
						end

						for i, v in pairs(Explosion:GetChildren()) do
							local Invert = 1200
							local ayo = math.random(1, 2)
							if ayo == 2 then
								Invert = -1200
							end
							game:GetService("TweenService")
								:Create(
									v,
									TweenInfo.new(4),
									{
										Transparency = 1,
										Position = Target.Position + Vector3.new(0, 2, 0),
										Size = v.Size + Vector3.new(200, 200, 200),
										Orientation = v.Orientation + Vector3.new(0, 0, Invert),
									}
								)
								:Play()
						end
					end)
					Lol2:Disconnect()
				end)
			end

			if Kameha then
				local SonGok = game.ReplicatedStorage.KillFX.Kameha.Gokz:Clone()
				SonGok.Parent = workspace.Ignored.Animations
				SonGok.PrimaryPart.CFrame = (CFrame.new(Target.Parent.UpperTorso.Position) + Vector3.new(0, 0.2, 0))
					* CFrame.Angles(0, math.rad(math.random(-360, 360)), 0)
				local ayeb = SonGok.Humanoid:LoadAnimation(SonGok.Animation)
				ayeb:Play()
				game.Debris:AddItem(SonGok, 7)
				local Lol1
				Lol1 = ayeb:GetMarkerReachedSignal("start"):Connect(function()
					Lol1:Disconnect()

					SonGok.LF:Play()
					task.delay(0.1, function()
						local BodyVel = Instance.new("BodyVelocity")
						BodyVel.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5))
							.. "A-C"
							.. game.GameId
						BodyVel.MaxForce = Vector3.new("inf", "inf", "inf")
						BodyVel.Parent = Target.Parent.LowerTorso
						BodyVel.Velocity = SonGok.HumanoidRootPart.CFrame.LookVector * 70 + Vector3.new(0, 400, 0)
						game.Debris:AddItem(BodyVel, 0.1)
						SonGok.XZ:Play()
						for i, v in pairs(SonGok["Right Arm"].Charge:GetChildren()) do
							v.Enabled = true
						end
					end)
					local Lol2
					Lol2 = ayeb:GetMarkerReachedSignal("beam"):Connect(function()
						SonGok.SF:Play()
						Target.Parent.LowerTorso.Anchored = true
						Lol2:Disconnect()
						for i, v in pairs(SonGok["Right Arm"].Charge:GetChildren()) do
							v.Enabled = false
						end
						for i, v in pairs(Target.Parent:GetDescendants()) do
							if v:IsA("BasePart") or v:IsA("Decal") then
								game.TweenService
									:Create(
										v,
										TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
										{ Transparency = 1 }
									)
									:Play()
							end
						end
						local Bro = Instance.new("Attachment", workspace.Terrain)
						Bro.WorldPosition = Target.Parent.UpperTorso.Position
						game.Debris:AddItem(Bro, 6)
						for i, v in pairs(SonGok["Right Arm"].Shoot:GetChildren()) do
							v.Enabled = true
							if v:IsA("Beam") then
								v.Attachment1 = Bro
								game.TweenService
									:Create(
										v,
										TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
										{ Width0 = 30, Width1 = 50 }
									)
									:Play()
							end
						end
						local Lol3
						Lol3 = ayeb:GetMarkerReachedSignal("end"):Connect(function()
							for i, v in pairs(SonGok["Right Arm"].Shoot:GetChildren()) do
								if v:IsA("Beam") then
									game.TweenService
										:Create(
											v,
											TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
											{ Width0 = 0, Width1 = 0 }
										)
										:Play()
								else
									v.Enabled = false
								end
							end
							task.delay(0.25, function()
								for i, v in pairs(SonGok:GetDescendants()) do
									if v:IsA("BasePart") or v:IsA("Decal") then
										game.TweenService
											:Create(
												v,
												TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
												{ Transparency = 1 }
											)
											:Play()
									end
								end
							end)
							Lol3:Disconnect()
						end)
					end)
				end)
			end

			if Destroyer then
				if workspace:FindFirstChild(Client.Name .. "-BrolyPower") == nil then
					if Client.Character:FindFirstChild("BrolyAura") == nil then
						local Aura = game.ReplicatedStorage.KillFX.Destroyer.BrolyAura:Clone()
						Aura.Parent = Client.Character
						Aura.Motor6D.Part1 = Client.Character.HumanoidRootPart
						game.Debris:AddItem(Aura, 60)
					end

					local SFF = Instance.new("ColorCorrectionEffect", game.Lighting)
					SFF.Name = "Son"
					game.Debris:AddItem(SFF, 20)
					SFF.Enabled = true
					local defaultone = game.Lighting.GeographicLatitude
					task.delay(0.5, function()
						game:GetService("TweenService")
							:Create(
								game.Lighting,
								TweenInfo.new(3.5, Enum.EasingStyle.Circular),
								{ GeographicLatitude = 360, FogEnd = 1000000 }
							)
							:Play()
						game:GetService("TweenService")
							:Create(
								SFF,
								TweenInfo.new(3.5, Enum.EasingStyle.Circular),
								{
									Brightness = -0.1,
									Contrast = 1,
									TintColor = Color3.fromRGB(140, 255, 179),
									Saturation = -0.5,
								}
							)
							:Play()
					end)
					local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
						workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * shakeCf
					end)
					camShake:Start()
					camShake:Shake(CameraShaker.Presets.Earthquake)

					local StompEffect = ReplicatedStorage.KillFX["Destroyer"].Stomp:Clone()
					StompEffect.Parent = workspace
					StompEffect:Play()
					game.Debris:AddItem(StompEffect, 12)
					local bullet = game.ReplicatedStorage.KillFX.Destroyer.GokuBeam:Clone()
					local sonnyz = bullet.BeamOne
					sonnyz.Parent = workspace.Terrain
					sonnyz.WorldPosition = Target.Parent.UpperTorso.Position
					local POT = Target.Parent.UpperTorso.Position
					task.delay(0.5, function()
						sonnyz.Debris.Enabled = true
						swait(3)
						sonnyz.Debris.Enabled = false
						sonnyz.Debris.Drag = 5
					end)
					delay(4, function()
						local camShake = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(shakeCf)
							workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame * shakeCf
						end)
						camShake:Start()
						camShake:Shake(CameraShaker.Presets.BoomDead)
						local JZJXXZJVZVZVJXv = ReplicatedStorage.KillFX["Destroyer"].Sound:Clone()
						JZJXXZJVZVZVJXv.Parent = workspace
						JZJXXZJVZVZVJXv.TimePosition = 9
						JZJXXZJVZVZVJXv:Play()
						game.TweenService
							:Create(JZJXXZJVZVZVJXv, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Volume = 0.25 })
							:Play()
						game.Debris:AddItem(JZJXXZJVZVZVJXv, 10)

						task.delay(5, function()
							game.TweenService
								:Create(JZJXXZJVZVZVJXv, TweenInfo.new(1, Enum.EasingStyle.Quint), { Volume = 0 })
								:Play()
						end)

						local StompEffect = ReplicatedStorage.KillFX["Destroyer"].shocwav:Clone()
						StompEffect.Parent = workspace
						StompEffect:Play()
						game.Debris:AddItem(StompEffect, 10)

						sonnyz.Debris.Drag = -10

						game:GetService("TweenService")
							:Create(
								SFF,
								TweenInfo.new(5, Enum.EasingStyle.Bounce, Enum.EasingDirection.InOut),
								{
									Brightness = 0.1,
									Contrast = 0.8,
									TintColor = Color3.fromRGB(214, 214, 214),
									Saturation = 1,
								}
							)
							:Play()
						game:GetService("TweenService")
							:Create(
								game.Lighting,
								TweenInfo.new(5, Enum.EasingStyle.Circular),
								{ GeographicLatitude = defaultone, FogEnd = 500 }
							)
							:Play()
						bullet.Parent = workspace.Ignored.Animations
						bullet.Anchored = true
						bullet.CanCollide = false
						bullet.Transparency = 0.2
						bullet.Material = Enum.Material.Neon
						bullet.Shape = Enum.PartType.Cylinder
						game.Debris:AddItem(bullet, 10)
						local S = Instance.new("Sound", bullet)
						S.SoundId = "rbxassetid://6808975002"
						S.Volume = 1
						S:Play()

						local origin = Vector3.new(POT.X, POT.Y + 1024, POT.Z)
						local target = Vector3.new(POT.X, POT.Y - 20, POT.Z)
						local ray = Ray.new(origin, (target - origin).unit * 2000)
						local hit, position =
							game.Workspace:FindPartOnRayWithIgnoreList(ray, { workspace.Ignored, workspace.Characters })
						local distance = (origin - position).Magnitude
						bullet.Size = Vector3.new(distance, 0.5, 0.5)
						bullet.CFrame = CFrame.new(origin, target)
							* CFrame.new(0, 0, -distance / 2)
							* CFrame.Angles(0, math.rad(90), 0)

						local v336 = CFrame.new(POT.X, POT.Y + 2, POT.Z).Position
						local v337 = {

							WideSlam = {
								DebrisPositions = { v336, 200, 200 },
								Properties = {
									Range = math.random(20, 30),
									Speed = 2,
									Duration = 3,
									origPos = v336,
									newSize = Vector3.new(
										math.random(50, 70) / 3,
										math.random(50, 70) / 7,
										math.random(50, 70) / 3
									),
								},
							},
						}

						local v338 = Xeno.createCircle(unpack(v337["WideSlam"].DebrisPositions))
						for v339 = 1, #v338 do
							local v340 = Xeno.RayCastOnMap(v338[v339], Vector3.new(0, -15, 0), true)
							if v340 then
								Xeno.spawnRubble(v340.Instance, v340.Position, v337["WideSlam"].Properties)
							end
						end

						local winder = game.ReplicatedStorage.KillFX.Destroyer.Wind:Clone()
						game:GetService("TweenService")
							:Create(
								winder,
								TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
								{
									Transparency = 1,
									Size = Vector3.new(150, 1000, 150),
									Orientation = Vector3.new(0, math.random(-1800 * 5, 1800 * 5), 0),
								}
							)
							:Play()
						winder.Parent = bullet
						winder.Size = Vector3.new(300, distance / 2, 300)

						winder.Position = bullet.Position

						local winder = game.ReplicatedStorage.KillFX.Destroyer.EXP:Clone()
						game:GetService("TweenService")
							:Create(
								winder,
								TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
								{
									Transparency = 1.1,
									Size = Vector3.new(150, 1000, 150),
									Orientation = Vector3.new(0, math.random(-1800 * 5, 1800 * 5), 0),
								}
							)
							:Play()
						winder.Parent = bullet
						winder.Size = Vector3.new(300, distance, 300)

						winder.Position = bullet.Position

						local IceIce = game.ReplicatedStorage.KillFX.Destroyer.EXP:Clone()
						IceIce.Parent = bullet
						IceIce:PivotTo(CFrame.new(position))

						for i, v in pairs(IceIce:GetChildren()) do
							game:GetService("TweenService")
								:Create(
									v,
									TweenInfo.new(2, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut),
									{
										Transparency = 1,
										Size = Vector3.new(400, 400, 400),
										Orientation = Vector3.new(-360, 360, 360),
									}
								)
								:Play()
						end

						local winder = game.ReplicatedStorage.KillFX.Destroyer.Crack:Clone()

						winder.Parent = workspace.Ignored
						winder.Size = Vector3.new(300, 300, 0.1)
						winder.Position = position - Vector3.new(50, 0, 0)

						game:GetService("TweenService")
							:Create(
								winder,
								TweenInfo.new(6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
								{ Transparency = 1 }
							)
							:Play()

						local winder = game.ReplicatedStorage.KillFX.Destroyer.ShockWaving:Clone()
						game:GetService("TweenService")
							:Create(
								winder,
								TweenInfo.new(6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
								{
									Transparency = 1,
									Size = Vector3.new(150, 1000, 150),
									Orientation = Vector3.new(0, math.random(-1800 * 5, 1800 * 5), 0),
								}
							)
							:Play()
						winder.Parent = bullet
						winder.Size = Vector3.new(100, 50, 100)

						winder.Position = Vector3.new(bullet.Position.X, -bullet.Position.Y, bullet.Position.Z)

						local counter = 0
						for i, v in pairs(game.ReplicatedStorage.KillFX.Destroyer:GetChildren()) do
							if v.Name == "Shock" then
								local shocks = v:Clone()
								shocks.Parent = bullet
								shocks.Size = Vector3.new(150, 25, 150)

								game:GetService("TweenService")
									:Create(
										shocks,
										TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut),
										{
											Transparency = 1,
											Size = Vector3.new(500, 50, 500),
											Orientation = Vector3.new(0, math.random(-360, 420), 0),
										}
									)
									:Play()
								counter += 1
								shocks.CFrame = CFrame.new(bullet.Position.X, distance / counter, bullet.Position.Z)
							end
						end

						coroutine.wrap(function()
							delay(0, function()
								repeat
									for i, v in pairs(bullet:GetChildren()) do
										if v:IsA("Beam") then
											bullet.Attachment.WorldPosition = bullet.Position
												+ Vector3.new(0, bullet.Size.X / 2, 0)
											bullet.ATT.WorldPosition = bullet.Position
												+ Vector3.new(0, -bullet.Size.X / 2, 0)
											v.Width0 = bullet.Size.Z / 1.2
											v.Width1 = bullet.Size.Z / 1.2
										end
									end
									swait()
								until JZJXXZJVZVZVJXv.Volume == 0 and bullet.Size.Z <= 0.01
								game:GetService("TweenService")
									:Create(
										SFF,
										TweenInfo.new(2, Enum.EasingStyle.Circular),
										{
											Brightness = 0,
											Contrast = 0,
											TintColor = Color3.fromRGB(255, 255, 255),
											Saturation = 0,
										}
									)
									:Play()
							end)

							local E = game:GetService("TweenService"):Create(
								bullet,
								TweenInfo.new(0.5),
								{ Transparency = 0.8, Size = Vector3.new(distance, 300, 300) }
							)
							E:Play()
							E.Completed:Wait()
							local E = game:GetService("TweenService"):Create(
								bullet,
								TweenInfo.new(6),
								{ Transparency = 1, Size = Vector3.new(distance, 0, 0) }
							)
							E:Play()
						end)()
					end)
				else
					local JZJXXZJVZVZVJXv = ReplicatedStorage.KillFX["Destroyer"].BDD:Clone()
					JZJXXZJVZVZVJXv.Parent = workspace
					JZJXXZJVZVZVJXv:Play()

					if Client.Character:FindFirstChild("BrolyAura") == nil then
						local Aura = game.ReplicatedStorage.KillFX.Destroyer.BrolyAura:Clone()
						Aura.Parent = Client.Character
						Aura.Motor6D.Part1 = Client.Character.HumanoidRootPart
						game.Debris:AddItem(Aura, 5)
					end
				end
			end

			if Megalodon then
				local Shark = ReplicatedStorage.KillFX.Megalodon.Megalodon:Clone()
				local StompEffect = ReplicatedStorage.KillFX["Megalodon"].Stomp:Clone()
				StompEffect.Parent = Shark["shark original"]

				local random = math.random(-360, 360)
				game.Debris:AddItem(Shark, 8)
				Shark.Parent = workspace.Ignored.Animations
				local Anim = Shark.AnimationController:LoadAnimation(Shark["shark original"].Animation)
				Shark.HumanoidRootPart.CFrame = CFrame.new(Target.Parent.HumanoidRootPart.Position)
					* CFrame.Angles(math.rad(-90), math.rad(-0), math.rad(-180 + random))
				local Puddle = ReplicatedStorage.KillFX.Megalodon.Puddle:Clone()
				game.Debris:AddItem(Puddle, 10)
				Puddle.Parent = workspace.Ignored.Animations
				print(Target.Parent.HumanoidRootPart.Name)
				Puddle.CFrame = CFrame.new(Target.Parent.HumanoidRootPart.Position)
					* CFrame.new(0, -4, 100)
					* CFrame.Angles(math.rad(-0), math.rad(-360 + random), math.rad(-0))
				local sonner = game.TweenService:Create(
					Puddle,
					TweenInfo.new(1, Enum.EasingStyle.Quad),
					{
						Size = Vector3.new(328.925, 3.34, 498.834),
						CFrame = CFrame.new(Target.Parent.HumanoidRootPart.Position)
							* CFrame.new(0, -4, 100)
							* CFrame.Angles(math.rad(-0), math.rad(-360 + random), math.rad(-0)),
					}
				)
				sonner:Play()
				sonner.Completed:Wait()
				Anim:Play()
				local FirstP = 0

				local Lol2
				Lol2 = Anim:GetMarkerReachedSignal("START"):Connect(function()
					local Son = Shark["shark original"]:FindFirstChildOfClass("BodyPosition")
					Son.Parent = Target.Parent.UpperTorso
					coroutine.wrap(function()
						repeat
							Son.Position = Shark["shark original"].Pos.WorldPosition
							swait()
						until Shark.Parent == nil or Son.Parent == nil
						if Son.Parent ~= nil then
							Son:Destroy()
						end
					end)()
					StompEffect:Play()

					game.Debris:AddItem(StompEffect, 4)
					task.delay(3, function()
						game.TweenService:Create(StompEffect, TweenInfo.new(1), { Volume = 0 }):Play()
					end)
					Shark["shark original"].Transparency = 0.5
					local Lol1
					Lol1 = Anim:GetMarkerReachedSignal("PUDDLE"):Connect(function()
						if FirstP == 0 then
							local Lighting = ReplicatedStorage.KillFX.Megalodon.Water:Clone()
							Lighting.CFrame = Puddle.First.WorldCFrame
							Lighting.Parent = workspace.Ignored.Animations
							game.Debris:AddItem(Lighting, 3)
							game.TweenService
								:Create(
									Lighting,
									TweenInfo.new(1),
									{ Size = Vector3.new(120.567, 135.114, 105.723), CFrame = Puddle.First.WorldCFrame }
								)
								:Play()
							game.TweenService
								:Create(
									Lighting.Mesh,
									TweenInfo.new(1, Enum.EasingStyle.Sine),
									{ Scale = Vector3.new(120.567, 135.114, 105.723) }
								)
								:Play()
							task.delay(1, function()
								game.TweenService
									:Create(
										Lighting,
										TweenInfo.new(1),
										{
											Size = Vector3.new(10.567, 5.114, 10.723),
											CFrame = Puddle.First.WorldCFrame,
											Transparency = 1,
										}
									)
									:Play()
								game.TweenService
									:Create(
										Lighting.Mesh,
										TweenInfo.new(1, Enum.EasingStyle.Bounce),
										{ Scale = Vector3.new(10.567, 5.114, 10.723) }
									)
									:Play()
							end)
							Lighting.Sound1:Play()
							print("wthhh")
							FirstP += 1
							return
						end
						print("whaerrt")
						local Lighting = ReplicatedStorage.KillFX.Megalodon.Water:Clone()
						Lighting.CFrame = Puddle.Second.WorldCFrame
						Lighting.Parent = workspace.Ignored.Animations
						game.Debris:AddItem(Lighting, 3)
						game.TweenService
							:Create(Lighting, TweenInfo.new(1), { CFrame = Puddle.Second.WorldCFrame })
							:Play()
						game.TweenService
							:Create(
								Lighting.Mesh,
								TweenInfo.new(1, Enum.EasingStyle.Sine),
								{ Scale = Vector3.new(120.567, 135.114, 105.723) }
							)
							:Play()
						task.delay(1.5, function()
							game.TweenService
								:Create(
									Lighting,
									TweenInfo.new(1),
									{
										Size = Vector3.new(10.567, 5.114, 10.723),
										CFrame = Puddle.Second.WorldCFrame,
										Transparency = 1,
									}
								)
								:Play()
							game.TweenService
								:Create(
									Lighting.Mesh,
									TweenInfo.new(1, Enum.EasingStyle.Bounce),
									{ Scale = Vector3.new(10.567, 5.114, 10.723) }
								)
								:Play()
						end)
						Lighting.Sound:Play()
						print("woahhhh")
						Lol1:Disconnect()
					end)
					local Lol3
					Lol3 = Anim:GetMarkerReachedSignal("END"):Connect(function()
						print("debug")
						game.TweenService:Create(Shark["shark original"], TweenInfo.new(1), { Transparency = 1 }):Play()
						task.delay(1.5, function()
							game.TweenService
								:Create(
									Puddle,
									TweenInfo.new(1),
									{
										Transparency = 1,
										Size = Vector3.new(0, 0, 0),
										Position = Target.Parent.HumanoidRootPart.Position,
									}
								)
								:Play()
						end)
						Lol3:Disconnect()
					end)
					Lol2:Disconnect()
				end)
			end
		end

		function Fly()
			local T = Client.Character:FindFirstChild("LowerTorso")
			local BV, BG = Instance.new("BodyVelocity", T), Instance.new("BodyGyro", T)
			BV.Name = tostring(game.JobId .. math.ceil(game.PlaceId * game.GameId * 0.5)) .. "A-C" .. game.GameId
			BV.Velocity = Vector3.new(0, 0.1, 0)
			BV.MaxForce = Vector3.new("inf", "inf", "inf")
			BG.CFrame = T.CFrame
			BG.P = 9e9
			BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)

			while
				Flying == true
				and Client
				and Client.Character
				and Client.Character:FindFirstChildOfClass("Humanoid")
				and RunService.Stepped:Wait()
				and T
			do
				local Front, Back, Left, Right = 0, 0, 0, 0
				if KeysTable["W"] then
					Front = Flyspeed
				elseif not KeysTable["W"] then
					Front = 0
				end
				if KeysTable["A"] then
					Right = -Flyspeed
				elseif not KeysTable["A"] then
					Right = 0
				end
				if KeysTable["S"] then
					Back = -Flyspeed
				elseif not KeysTable["S"] then
					Back = 0
				end
				if KeysTable["D"] then
					Left = Flyspeed
				elseif not KeysTable["D"] then
					Left = 0
				end
				if tonumber(Front + Back) ~= 0 or tonumber(Left + Right) ~= 0 then
					BV.Velocity = (
						(Camera.CFrame.lookVector * (Front + Back))
						+ ((Camera.CFrame * CFrame.new(Left + Right, (Front + Back) * 0.2, 0).p) - Camera.CFrame.p)
					) * 50
				else
					BV.Velocity = Vector3.new(0, 0.1, 0)
				end
				BG.CFrame = Camera.CFrame
			end
			BG:Remove()
			BV:Remove()
		end

		function DetectStar(Player)
			if Player:IsInGroup("10878346") then
				GroupRole = Player:GetRoleInGroup("10878346")
				NOTIFICATIONFramework:SendNotification("Info", "Star Found, Role: " .. GroupRole, 3)
			end
		end

		function CheckForStars(Player)
			for i, v in pairs(Players:GetPlayers()) do
				if v:IsInGroup("10878346") then
					GroupRole = v:GetRoleInGroup("10878346")
					NOTIFICATIONFramework:SendNotification("Info", "Star Found, Role: " .. GroupRole, 3)
				end
			end
		end

		function SetBypass(Value)
			if Value then
				if not Teleporting then
					Teleporting = true
				end
			else
				if Teleporting then
					Teleporting = false
				end
			end
		end

		function RandomNumberRange(a)
			return math.random(-a * 100, a * 100) / 100
		end

		function RandomVectorRange(a, b, c)
			return Vector3.new(RandomNumberRange(a), RandomNumberRange(b), RandomNumberRange(c))
		end

		function FindClosestPlayer()
			local ClosestDistance, ClosestPlayer = math.huge, nil
			for _, Player in next, Players:GetPlayers() do
				if Player ~= Client then
					local Character = Player.Character
					if Character then
						local Position, IsVisibleOnViewPort =
							Camera:WorldToViewportPoint(Character.HumanoidRootPart.Position)
						if IsVisibleOnViewPort then
							local Distance = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(Position.X, Position.Y)).Magnitude
							if Distance < ClosestDistance then
								ClosestPlayer = Player
								ClosestDistance = Distance
							end
						end
					end
				end
			end
			return ClosestPlayer, ClosestDistance
		end

		function DestroyBody()
			Client.Character.Humanoid.RigType = "R6"
			Client.Character["I_LOADED_I"]:Destroy()
			wait(0.5)
			Client.Character.RagdollConstraints:Destroy()
			for i, v in next, Client.Character:GetChildren() do
				if v:IsA("Accessory") then
					v.Handle:Destroy()
				end
			end
		end

		function ConfirmCallbacks()
			wait()
			StarterGui:SetCore("ResetButtonCallback", true)
		end
		ConfirmCallbacks()

		function PurchaseItem()
			if GunSelected == true and not OtherSelected and not ArmorSelected and ChosenGun ~= nil then
				ReturnPosition = Client.Character.HumanoidRootPart.CFrame
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Ignored.Shop.Guns[ChosenGun].Head.CFrame
				swait(0.05)
				fireclickdetector(game:GetService("Workspace").Ignored.Shop.Guns[ChosenGun].ClickDetector, 0)
				swait(0.25)
				Client.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Ignored.Shop.Guns[ChosenGun].Head.CFrame
				fireclickdetector(game:GetService("Workspace").Ignored.Shop.Guns[ChosenGun].ClickDetector, 0)
				swait(0.1)
				Client.Character.HumanoidRootPart.CFrame = ReturnPosition
				swait(0.16)
				SetBypass(false)
			end
			if OtherSelected == true and not GunSelected and not ArmorSelected and ChosenOther ~= nil then
				ReturnPosition = Client.Character.HumanoidRootPart.CFrame
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Ignored.Shop.Others[ChosenOther].Head.CFrame
				swait(0.05)
				fireclickdetector(game:GetService("Workspace").Ignored.Shop.Others[ChosenOther].ClickDetector, 0)
				swait(0.25)
				Client.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Ignored.Shop.Others[ChosenOther].Head.CFrame
				fireclickdetector(game:GetService("Workspace").Ignored.Shop.Others[ChosenOther].ClickDetector, 0)
				swait(0.1)
				Client.Character.HumanoidRootPart.CFrame = ReturnPosition
				swait(0.16)
				SetBypass(false)
			end
			if ArmorSelected == true and not OtherSelected and not GunSelected and ChosenArmor ~= nil then
				ReturnPosition = Client.Character.HumanoidRootPart.CFrame
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Ignored.Shop.Armor[ChosenArmor].Head.CFrame
				swait(0.05)
				fireclickdetector(game:GetService("Workspace").Ignored.Shop.Armor[ChosenArmor].ClickDetector, 0)
				swait(0.25)
				Client.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Ignored.Shop.Armor[ChosenArmor].Head.CFrame
				fireclickdetector(game:GetService("Workspace").Ignored.Shop.Armor[ChosenArmor].ClickDetector, 0)
				swait(0.1)
				Client.Character.HumanoidRootPart.CFrame = ReturnPosition
				swait(0.16)
				SetBypass(false)
			end
		end

		function StateChangedEvent(T, Changed)
			if AntiFall then
				if Client and Client.Character and Client.Character:FindFirstChildOfClass("Humanoid") then
					if
						Changed == Enum.HumanoidStateType.FallingDown
						or Changed == Enum.HumanoidStateType.PlatformStanding
					then
						Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
						Client.Character.Humanoid.PlatformStand = false
					end
				end
			end
		end
		Client.Character:WaitForChild("Humanoid").StateChanged:Connect(StateChangedEvent)

		Client.CharacterAdded:Connect(function()
			swait(0.6)
			NeedsRespawn = false
			HasPiviot = false
		end)

		Client.CharacterAdded:Connect(function()
			Client.Character:WaitForChild("Humanoid")
			Client.Character.Humanoid.StateChanged:Connect(StateChangedEvent)
		end)

		Client.Character.Humanoid.Died:Connect(function()
			SetBypass(false)
			Flinging = false
			Desync = false
		end)

		Players.PlayerAdded:Connect(function(Player)
			if StarDetector then
				DetectStar(Player)
			end
		end)
		--# Region // End

		--# Region // Error Pocket
		local IsA = game.IsA
		checkcaller = checkcaller
		newcclosure = newcclosure
		hookmetamethod = hookmetamethod
		--# Region // End

		--# Region // Hookmetamethods

		local oldIndex
		oldIndex = hookmetamethod(
			game,
			"__index",
			newcclosure(function(self, Property)
				if Desync then
					if not checkcaller() then
						if
							Property == "CFrame"
							and Desync
							and Client.Character
							and Client.Character:FindFirstChild("HumanoidRootPart")
							and Client.Character:FindFirstChildOfClass("Humanoid")
							and Client.Character:FindFirstChildOfClass("Humanoid").Health > 0
						then
							if self == Client.Character.HumanoidRootPart then
								return OldDesyncCF or CFrame.new()
							end
						end
					end
				end
				if CFrameDesync then
					if not checkcaller() then
						if
							Property == "CFrame"
							and CFrameDesync
							and Client.Character
							and Client.Character:FindFirstChild("HumanoidRootPart")
							and Client.Character:FindFirstChildOfClass("Humanoid")
							and Client.Character:FindFirstChildOfClass("Humanoid").Health > 0
						then
							if self == Client.Character.HumanoidRootPart then
								return OldCFrame or CFrame.new()
							end
						end
					end
				end
				if TargetStrafe and AimbotEnabled and (OrbitStrafeType or RandomizeStrafeType) then
					if not checkcaller() then
						if
							Property == "CFrame"
							and TargetStrafe
							and AimbotEnabled
							and (OrbitStrafeType or RandomizeStrafeType)
							and Client.Character
							and Client.Character:FindFirstChild("HumanoidRootPart")
							and Client.Character:FindFirstChildOfClass("Humanoid")
							and Client.Character:FindFirstChildOfClass("Humanoid").Health > 0
						then
							if self == Client.Character.HumanoidRootPart then
								return AimbotTarget.Character.HumanoidRootPart.CFrame or CFrame.new()
							end
						end
					end
				end
				return oldIndex(self, Property)
			end)
		)

		local oldIndex
		oldIndex = hookmetamethod(
			game,
			"__index",
			newcclosure(function(self, Index)
				if self == Mouse and (Index == "Hit") and AimbotEnabled then
					if not checkcaller() then
						if AimbotResolver and AimbotTarget.Character.HumanoidRootPart:GetAttribute("ReplicatedVelocity") ~= nil then
							return (
								Index == "Hit"
								and AimbotTarget.Character[AimbotAimpart].CFrame
									+ (AimbotTarget.Character.HumanoidRootPart:GetAttribute("ReplicatedVelocity") * AimbotPrediction)
							)
						else
							return (
								Index == "Hit"
								and AimbotTarget.Character[AimbotAimpart].CFrame
									+ (AimbotTarget.Character.HumanoidRootPart.Velocity * AimbotPrediction)
							)
						end
					end
				end
				return oldIndex(self, Index)
			end)
		)

		local newIndex
		newIndex = hookmetamethod(
			game,
			"__newindex",
			newcclosure(function(self, Index, Value)
				if not checkcaller() and IsA(self, "Humanoid") and Index == "JumpPower" and NoJumpCoolDown then
					return
				end
				return newIndex(self, Index, Value)
			end)
		)

		ReplicatedStorage.MainRemote.OnClientEvent:Connect(function(...)
			local Args = { ... }
			if Args[1] == "FX_KILL" and Args[4] == Client then
				local _, withinScreenBounds = workspace.CurrentCamera:WorldToScreenPoint(Args[3].Position)
				local origin = Args[3].Position + Vector3.new(0, 10, 0)
				local target = Client.Character.PrimaryPart.Position
				local ray = Ray.new(origin, (target - origin).unit * 250)
				local hit, position =
					game.Workspace:FindPartOnRayWithWhitelist(ray, { workspace.Map, Client.Character })
				if
					StompChanger
					and (withinScreenBounds or hit)
					and (Client.Character.PrimaryPart.Position - Args[3].Position).Magnitude <= 300
					and ClientStomps
				then
					CheckForFX(Args[3])
				elseif
					StompChanger
					and (withinScreenBounds or hit)
					and (Client.Character.PrimaryPart.Position - Args[3].Position).Magnitude <= 300
					and ServerStomps
				then
					CheckForSFX(Args[3])
				end
			end
		end)
		--# Region // End

		--# Region // Keybinds

		UserInputService.InputBegan:Connect(function(Input, Typing)
			if Typing then
				return
			end
			if Input.KeyCode == Enum.KeyCode.W then
				KeysTable["W"] = true
			end
			if Input.KeyCode == Enum.KeyCode.A then
				KeysTable["A"] = true
			end
			if Input.KeyCode == Enum.KeyCode.S then
				KeysTable["S"] = true
			end
			if Input.KeyCode == Enum.KeyCode.D then
				KeysTable["D"] = true
			end
		end)

		UserInputService.InputEnded:Connect(function(Input, Typing)
			if Typing then
				return
			end
			if Input.KeyCode == Enum.KeyCode.W then
				KeysTable["W"] = false
			end
			if Input.KeyCode == Enum.KeyCode.A then
				KeysTable["A"] = false
			end
			if Input.KeyCode == Enum.KeyCode.S then
				KeysTable["S"] = false
			end
			if Input.KeyCode == Enum.KeyCode.D then
				KeysTable["D"] = false
			end
		end)

		UserInputService.InputBegan:Connect(function(Input, Typing)
			if Typing then
				return
			end
			if Input.KeyCode == Enum.KeyCode.Space then
				if InfiniteJump then
					HoldingSpace = true
					while HoldingSpace and wait() do
						Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Seated)
						swait(0.0001)
						Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
					end
				end
			end
		end)

		UserInputService.InputEnded:Connect(function(Input, Typing)
			if Typing then
				return
			end
			if Input.KeyCode == Enum.KeyCode.Space then
				HoldingSpace = false
			end
		end)

		Mouse.KeyDown:Connect(function(KeyPressed)
			if KeyPressed == AimbotKey and Aimbot then
				if AimbotEnabled == true then
					AimbotEnabled = false
				else
					AimbotTarget = FindClosestPlayer()
					AimbotEnabled = true
				end
			end
		end)

		Mouse.KeyDown:Connect(function(KeyPressed)
			if KeyPressed == StreamableKey and Streamable then
				if StreamableEnabled == true then
					StreamableEnabled = false
				else
					StreamableTarget = FindClosestPlayer()
					StreamableEnabled = true
				end
			end
		end)
		--# Region // End

		--# Region // Extras
		local AABox = Instance.new("Part", Workspace)
		AABox.Shape = Enum.PartType.Block
		AABox.Material = "Neon"
		AABox.Color = Color3.fromRGB(200, 0, 0)

		spawn(function()
			AABox.Anchored = true
			AABox.CanCollide = false
			AABox.Size = Vector3.new(1.6, 2, 0.6)
			AABox.Transparency = 0.8
		end)

		local PlaceBox = Instance.new("Part", Workspace)
		PlaceBox.Shape = Enum.PartType.Block
		PlaceBox.Material = "Neon"
		PlaceBox.Color = AimbotSettingsColor

		spawn(function()
			PlaceBox.Anchored = true
			PlaceBox.CanCollide = false
			PlaceBox.Size = Vector3.new(11, 11, 11)
			PlaceBox.Transparency = 0.8
		end)

		local TargetHL = Instance.new("Highlight")
		local TracerLine = Drawing.new("Line")
		--# Region // End

		--# Region // Loops

		RunService.Heartbeat:Connect(function()
			if CFrameDesync then
				OldCFrame = Client.Character.HumanoidRootPart.CFrame

				Client.Character.HumanoidRootPart.CFrame = OldCFrame
					* CFrame.new(math.random(-10, 10), math.random(0, 10), math.random(-10, 10))

				RunService.RenderStepped:Wait()

				Client.Character.HumanoidRootPart.CFrame = OldCFrame
			end
		end)

		RunService.Heartbeat:Connect(function()
			if VelocityAA then
				ClientLV = Client.Character.HumanoidRootPart.AssemblyLinearVelocity
				ClientV = Client.Character.HumanoidRootPart.Velocity

				Client.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(VelocityX, VelocityY, VelocityZ)
					* -10
				Client.Character.HumanoidRootPart.Velocity = Vector3.new(VelocityX, VelocityY, VelocityZ) * -10

				RunService.RenderStepped:Wait()

				Client.Character.HumanoidRootPart.AssemblyLinearVelocity = ClientLV
				Client.Character.HumanoidRootPart.Velocity = ClientV
			end
		end)

		RunService.Heartbeat:Connect(function()
			if Desync then
				OldDesyncCF = Client.Character.HumanoidRootPart.CFrame
				OldVel = Client.Character.HumanoidRootPart.Velocity

				local NewCF = Client.Character.HumanoidRootPart.CFrame

				NewCF = NewCF * CFrame.new(Vector3.new(0, 0, 0))
				NewCF = NewCF
					* CFrame.Angles(
						math.rad(RandomNumberRange(0.1)),
						math.rad(RandomNumberRange(0.1)),
						math.rad(RandomNumberRange(0.1))
					)

				Client.Character.HumanoidRootPart.CFrame = NewCF

				Client.Character.HumanoidRootPart.Velocity = Vector3.new(1, 1, 1) * -DesyncStrength

				RunService.RenderStepped:Wait()

				Client.Character.HumanoidRootPart.CFrame = OldDesyncCF
				Client.Character.HumanoidRootPart.Velocity = OldVel
			end
		end)

		local FlingTypes = {}
		RunService.Heartbeat:Connect(function()
			if Flinging then
				FlingTypes[1] = Client.Character.HumanoidRootPart.CFrame
				FlingTypes[2] = Client.Character.HumanoidRootPart.AssemblyLinearVelocity

				local SpoofThis = Client.Character.HumanoidRootPart.CFrame

				SpoofThis = SpoofThis * CFrame.new(Vector3.new(0, 0, 0))
				SpoofThis = SpoofThis
					* CFrame.Angles(
						math.rad(RandomNumberRange(0.1)),
						math.rad(RandomNumberRange(0.1)),
						math.rad(RandomNumberRange(0.1))
					)

				Client.Character.HumanoidRootPart.CFrame = SpoofThis

				Client.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(1, 1, 1) * -3400

				RunService.RenderStepped:Wait()

				Client.Character.HumanoidRootPart.CFrame = FlingTypes[1]
				Client.Character.HumanoidRootPart.AssemblyLinearVelocity = FlingTypes[2]
			end
		end)

		RunService.Heartbeat:Connect(function()
			if Teleporting then
				OldVel = Client.Character.HumanoidRootPart.Velocity
				Client.Character.HumanoidRootPart.Velocity = Vector3.new(0, -350, 0)
				RunService.RenderStepped:Wait()
				Client.Character.HumanoidRootPart.Velocity = OldVel
			end
		end)

		RunService.Heartbeat:Connect(function()
			if
				AimbotEnabled
				and AimbotResolver
				and AimbotTarget ~= nil
				and AimbotTarget.Character
				and AimbotTarget.Character:FindFirstChildOfClass("Humanoid")
			then
				local PreviousPosition = AimbotTarget.Character.PrimaryPart.Position
				local PreviousTime = tick()

				swait(0.056631210)

				local CurrentPosition = AimbotTarget.Character.PrimaryPart.Position
				local CurrentTime = tick()

				local Distance = (CurrentPosition - PreviousPosition)
				local DeltaTime = CurrentTime - PreviousTime

				AimbotTarget.Character.HumanoidRootPart:SetAttribute("ReplicatedVelocity", Distance / DeltaTime)

				PreviousPosition = CurrentPosition
				PreviousTime = CurrentTime
			end
		end)

		RunService.Stepped:Connect(function()
			if CFrameMovement then
				Client.Character.HumanoidRootPart.CFrame = Client.Character.HumanoidRootPart.CFrame
					+ Vector3.new(
						Client.Character.Humanoid.MoveDirection.X * CFrameSpeed,
						Client.Character.Humanoid.MoveDirection.Y * CFrameSpeed,
						Client.Character.Humanoid.MoveDirection.Z * CFrameSpeed
					)
			end
		end)

		RunService.Stepped:Connect(function()
			if AntiAimView then
				AABox.Position = Client.Character.HumanoidRootPart.Position
					+ (Client.Character.HumanoidRootPart.Velocity * AimbotPrediction)
			else
				AABox.Position = Vector3.new(0, 9999, 0)
			end
		end)

		RunService.Stepped:Connect(function()
			if Deathreturn and Client.Character.Humanoid.Health == 0 then
				if not HasPiviot then
					DeathReturnPosition = Client.Character.HumanoidRootPart.CFrame
					HasPiviot = true
				end
				NeedsRespawn = true
			end

			if NeedsRespawn then
				Client.Character.HumanoidRootPart.CFrame = DeathReturnPosition
			end
		end)

		RunService.Stepped:Connect(function()
			for i, v in pairs(Players:GetPlayers()) do
				if v and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v ~= Client then
					if
						Reach
						and (Client.Character.LeftHand.Position - v.Character.HumanoidRootPart.Position).Magnitude <= 50
						and v.Character.I_LOADED_I["K.O"].Value ~= true
					then
						v.Character.HumanoidRootPart.Size = Vector3.new(25, 25, 25)
						v.Character.HumanoidRootPart.CanCollide = false
					else
						v.Character.HumanoidRootPart.Size = Vector3.new(1.3, 1.3, 1.3)
					end
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if SpinBotAA then
				Client.Character.HumanoidRootPart.AssemblyAngularVelocity = Vector3.new(0, SpinBotSpeed, 0)
			end
		end)

		RunService.Stepped:Connect(function()
			if AutoReload then
				if
					Client.Character:FindFirstChildOfClass("Tool")
					and Client.Character:FindFirstChildOfClass("Tool"):FindFirstChild("GunScript")
					and Client.Character:FindFirstChildOfClass("Tool").Handle.NoAmmo.Playing == true
				then
					ReplicatedStorage.MainRemote:FireServer("Reload")
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if CustomAnimationSpeed then
				for i, v in pairs(Client.Character.Humanoid:GetPlayingAnimationTracks()) do
					v:AdjustSpeed(AnimationSpeed)
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if StompAura then
				for i, v in ipairs(Players:GetPlayers()) do
					if
						v.Character
						and v.Character:FindFirstChild("HumanoidRootPart")
						and (Client.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude < 35
						and v.Character:FindFirstChild("I_LOADED_I")
						and v.Character.I_LOADED_I["K.O"].Value == true
						and not v.Character:FindFirstChild("DEBUG_DEAD")
						and not v.Character:FindFirstChild("WELD_GRAB")
					then
						SetBypass(true)
						swait(0.16)

						Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
						Client.Character.Humanoid.PlatformStand = false
						Client.Character.HumanoidRootPart.CFrame = v.Character.UpperTorso.CFrame
						ReplicatedStorage.MainRemote:FireServer("Stomp")

						swait(0.16)
						SetBypass(false)
					end
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if StompFarm then
				for i, v in ipairs(Players:GetPlayers()) do
					if
						v.Character
						and v.Character:FindFirstChild("HumanoidRootPart")
						and v.Character:FindFirstChild("I_LOADED_I")
						and v.Character.I_LOADED_I["K.O"].Value == true
						and not v.Character:FindFirstChild("DEBUG_DEAD")
						and not v.Character:FindFirstChild("WELD_GRAB")
					then
						SetBypass(true)
						swait(0.16)

						Client.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
						Client.Character.Humanoid.PlatformStand = false
						Client.Character.HumanoidRootPart.CFrame = v.Character.Head.CFrame
						ReplicatedStorage.MainRemote:FireServer("Stomp")
					end
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if AimbotAutoPrediction then
				local PingValue =
					string.split(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), "(")
				local Ping = tonumber(PingValue[1])
				if Ping <= 250 then
					AimbotPrediction = 0.1711
				elseif Ping <= 150 then
					AimbotPrediction = 0.160
				elseif Ping <= 130 then
					AimbotPrediction = 0.151
				elseif Ping <= 120 then
					AimbotPrediction = 0.149
				elseif Ping <= 110 then
					AimbotPrediction = 0.146
				elseif Ping <= 105 then
					AimbotPrediction = 0.138
				elseif Ping <= 90 then
					AimbotPrediction = 0.136
				elseif Ping <= 80 then
					AimbotPrediction = 0.134
				elseif Ping <= 70 then
					AimbotPrediction = 0.131
				elseif Ping <= 60 then
					AimbotPrediction = 0.1229
				elseif Ping <= 50 then
					AimbotPrediction = 0.1225
				elseif Ping <= 40 then
					AimbotPrediction = 0.1256
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if AimbotEnabled == true and AimbotTarget.Character and Client.Character then
				TracerLine.Color = AimbotSettingsColor
				TracerLine.Transparency = AimbotSettingsTransparency
				TracerLine.Thickness = AimbotSettingsThickness
				TracerLine.From = Vector2.new(
					Camera:WorldToViewportPoint(Client.Character.HumanoidRootPart.Position).X,
					Camera:WorldToViewportPoint(Client.Character.HumanoidRootPart.Position).Y
				)
				if AimbotResolver and AimbotTarget.Character.HumanoidRootPart:GetAttribute("ReplicatedVelocity") ~= nil then
					TracerLine.To = Vector2.new(
						Camera:WorldToViewportPoint(
							AimbotTarget.Character[AimbotAimpart].Position
								+ (
									AimbotTarget.Character.HumanoidRootPart:GetAttribute("ReplicatedVelocity")
									* AimbotPrediction
								)
						).X,
						Camera:WorldToViewportPoint(
							AimbotTarget.Character[AimbotAimpart].Position
								+ (
									AimbotTarget.Character.HumanoidRootPart:GetAttribute("ReplicatedVelocity")
									* AimbotPrediction
								)
						).Y
					)
				else
					TracerLine.To = Vector2.new(
						Camera:WorldToViewportPoint(
							AimbotTarget.Character[AimbotAimpart].Position
								+ (AimbotTarget.Character.HumanoidRootPart.Velocity * AimbotPrediction)
						).X,
						Camera:WorldToViewportPoint(
							AimbotTarget.Character[AimbotAimpart].Position
								+ (AimbotTarget.Character.HumanoidRootPart.Velocity * AimbotPrediction)
						).Y
					)
				end
				TracerLine.Visible = true
			else
				TracerLine.Visible = false
				TargetHL.Parent = game:GetService("CoreGui")
				PlaceBox.CFrame = CFrame.new(0, 9999, 0)
			end
		end)

		RunService.Stepped:Connect(function()
			if AimbotEnabled == true and AimbotHitboxExtender == true and AimbotTarget.Character then
				PlaceBox.CFrame = CFrame.new(
					AimbotTarget.Character[AimbotAimpart].Position
						+ (AimbotTarget.Character.HumanoidRootPart.Velocity * AimbotPrediction)
				)
			else
				PlaceBox.CFrame = CFrame.new(0, 9999, 0)
			end
		end)

		RunService.Stepped:Connect(function()
			if AimbotEnabled == true and AimbotLookAt == true then
				Client.Character.HumanoidRootPart.CFrame = CFrame.lookAt(
					Client.Character.HumanoidRootPart.Position,
					Vector3.new(
						AimbotTarget.Character.HumanoidRootPart.Position.X,
						Client.Character.HumanoidRootPart.CFrame.Position.Y,
						AimbotTarget.Character.HumanoidRootPart.Position.Z
					)
				)
			end
		end)

		i = 0
		RunService.RenderStepped:Connect(function(FramesPerSecond)
			if AimbotEnabled == true and TargetStrafe == true then
				if OrbitStrafeType and not RandomizeStrafeType then
					SetBypass(true)
					swait(0.16)

					i = i + FramesPerSecond / StrafeSpeed % 1

					Client.Character.HumanoidRootPart.Velocity = Vector3.new(0, 25, 0)
					Client.Character.HumanoidRootPart.CFrame = CFrame.new(
						AimbotTarget.Character.HumanoidRootPart.Position
					) * CFrame.Angles(0, 2 * math.pi * i, 0) * CFrame.new(0, StrafeHeight, StrafeDistance)

					swait(0.16)
					SetBypass(false)
				elseif RandomizeStrafeType and not OrbitStrafeType then
					SetBypass(true)
					swait(0.16)

					i = i + 1

					Client.Character.HumanoidRootPart.Velocity = Vector3.new(0, 25, 0)
					Client.Character.HumanoidRootPart.CFrame = CFrame.new(
						AimbotTarget.Character.HumanoidRootPart.Position
					) * CFrame.new(-math.random(-15, 15), 0, -math.random(-15, 15))

					swait(0.16)
					SetBypass(false)
				end
			end
		end)

		RunService.Stepped:Connect(function()
			if AimbotEnabled == true and AimbotTracerTarget == true then
				AimbotSettingsTransparency = 1
			else
				AimbotSettingsTransparency = 0
			end
		end)

		RunService.Stepped:Connect(function()
			if AimbotEnabled == true and AimbotHighlightTarget == true then
				TargetHL.Parent = AimbotTarget.Character
				TargetHL.FillColor = AimbotSettingsColor
				TargetHL.OutlineColor = AimbotSettingsColor
			else
				TargetHL.Parent = game:GetService("CoreGui")
			end
		end)

		RunService.Stepped:Connect(function()
			if StreamableEnabled then
				Camera.CFrame = Camera.CFrame:Lerp(
					CFrame.new(
						Camera.CFrame.Position,
						StreamableTarget.Character[StreamableAimpart].Position
							+ (StreamableTarget.Character.HumanoidRootPart.Velocity * StreamablePrediction)
					),
					StreamableSmoothness,
					Enum.EasingStyle.Elastic,
					Enum.EasingDirection.InOut
				)
			end
		end)
		--# Region // End

		--# Region // Setting up Framework
		local Window = UIFramework:Load({
			Name = "Vitality (Source Leaked)",
			SizeX = 500,
			SizeY = 550,
			Theme = "Blue",
			Extension = "json",
			Folder = "Vitality Folder",
		})

		local CharacterTab = Window:Tab("Character")
		local AimingTab = Window:Tab("Aiming")
		local TeleportTab = Window:Tab("Teleports")
		local MiscTab = Window:Tab("Misc")
		local ConfigTab = Window:Tab("Config")

		--// Character

		--// Character

		local MovementSection = CharacterTab:Section({ Name = "Movement", Side = "Left" })
		local AASection = CharacterTab:Section({ Name = "Velocity AA", Side = "Left" })
		local SpinbotSection = CharacterTab:Section({ Name = "Spin Bot", Side = "Left" })
		local DesyncSection = CharacterTab:Section({ Name = "Desync", Side = "Right" })
		local ViewAASection = CharacterTab:Section({ Name = "View AA", Side = "Right" })

		local BypassSection = CharacterTab:Section({ Name = "Bypass", Side = "Right" })
		local AnimationSection = CharacterTab:Section({ Name = "Animation", Side = "Right" })

		local AimbotSection = AimingTab:Section({ Name = "Aimbot", Side = "Left" })
		local StreamableSection = AimingTab:Section({ Name = "Streamable", Side = "Right" })
		local TargetSection = AimingTab:Section({ Name = "Target", Side = "Right" })

		local TeleportSection = TeleportTab:Section({ Name = "Teleports", Side = "Left" })
		local AutoBuySection = TeleportTab:Section({ Name = "Auto Purchase", Side = "Left" })
		local StrafeSection = TeleportTab:Section({ Name = "Target Strafe", Side = "Right" })

		local EspSection = MiscTab:Section({ Name = "Player Visuals", Side = "Left" })
		local ExtraSection = MiscTab:Section({ Name = "Extras", Side = "Left" })
		local StompSection = MiscTab:Section({ Name = "Stomp", Side = "Left" })
		local CrashSection = MiscTab:Section({ Name = "Crash Server", Side = "Left" })
		local ToolSection = MiscTab:Section({ Name = "Tool", Side = "Right" })
		local StompChangerSection = MiscTab:Section({ Name = "Stomp Changer", Side = "Right" })

		local ConfigSection = ConfigTab:Section({ Name = "Configs", Side = "Left" })

		MovementSection:Toggle({
			Name = "CFrame Movement",
			Flag = "Flag_CFrame_Movement",
			Default = false,
			Callback = function(Value)
				CFrameMovement = Value
			end,
		}):Keybind({
			Flag = "Flag_CFrame_Movement_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		MovementSection:Toggle({
			Name = "Fly",
			Flag = "Flag_Fly",
			Default = false,
			Callback = function(Value)
				Flying = Value
				Fly()
			end,
		}):Keybind({
			Flag = "Flag_Fly_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		MovementSection:Toggle({
			Name = "Infinite Jump",
			Flag = "Flag_Infinite_Jump",
			Default = false,
			Callback = function(Value)
				InfiniteJump = Value
				NoJumpCoolDown = Value
			end,
		}):Keybind({
			Flag = "Flag_Infinite_Jump_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		MovementSection:Toggle({
			Name = "Anti Fall",
			Flag = "Flag_Anti_Fall",
			Default = false,
			Callback = function(Value)
				AntiFall = Value
			end,
		}):Keybind({
			Flag = "Flag_Anti_Fall_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		MovementSection:Seperator("")

		MovementSection:Slider({
			Name = "CFrame Speed",
			Default = 4,
			Min = 1,
			Max = 6,
			Float = 0.1,
			Flag = "Flag_CFrame_Speed",
			Callback = function(Value)
				CFrameSpeed = Value
			end,
		})
		MovementSection:Slider({
			Name = "Fly Speed",
			Default = 4,
			Min = 1,
			Max = 4.5,
			Float = 0.1,
			Flag = "Flag_Fly_Speed",
			Callback = function(Value)
				Flyspeed = Value
			end,
		})

		AASection:Toggle({
			Name = "Enabled",
			Flag = "Flag_Velocity_AA",
			Default = false,
			Callback = function(Value)
				VelocityAA = Value
			end,
		}):Keybind({
			Flag = "Flag_Velocity_AA_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		AASection:Seperator("")

		AASection:Slider({
			Name = "X Velocity",
			Default = 0,
			Min = 0,
			Max = 100,
			Float = 0.1,
			Flag = "Flag_Velocity_X",
			Callback = function(Value)
				VelocityX = Value
			end,
		})
		AASection:Slider({
			Name = "Y Velocity",
			Default = 0,
			Min = 0,
			Max = 100,
			Float = 0.1,
			Flag = "Flag_Velocity_Y",
			Callback = function(Value)
				VelocityY = Value
			end,
		})
		AASection:Slider({
			Name = "Z Velocity",
			Default = 0,
			Min = 0,
			Max = 100,
			Float = 0.1,
			Flag = "Flag_Velocity_Z",
			Callback = function(Value)
				VelocityZ = Value
			end,
		})

		SpinbotSection:Toggle({
			Name = "Enabled",
			Flag = "Flag_Spin_Bot",
			Default = false,
			Callback = function(Value)
				SpinBotAA = Value
			end,
		}):Keybind({
			Flag = "Flag_Spin_Bot_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		SpinbotSection:Seperator("")

		SpinbotSection:Slider({
			Name = "Spin Speed",
			Default = 0,
			Min = 0,
			Max = 200,
			Float = 0.1,
			Flag = "Flag_Spin_Bot_Speed",
			Callback = function(Value)
				SpinBotSpeed = Value
			end,
		})

		DesyncSection:Toggle({
			Name = "CFrame Desync",
			Flag = "Flag_CFrame_Desync",
			Default = false,
			Callback = function(Value)
				CFrameDesync = Value
			end,
		}):Keybind({
			Flag = "Flag_CFrame_Desync_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		DesyncSection:Toggle({
			Name = "Velocity Desync",
			Flag = "Flag_Velocity_Desync",
			Default = false,
			Callback = function(Value)
				Desync = Value
			end,
		}):Keybind({
			Flag = "Flag_Velocity_Desync_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		DesyncSection:Seperator("")

		DesyncSection:Slider({
			Name = "Velocity Desync Strength",
			Default = 0,
			Min = 0,
			Max = 3000,
			Float = 0.1,
			Flag = "Flag_Velocity_Desync_Strength",
			Callback = function(Value)
				DesyncStrength = Value
			end,
		})

		ViewAASection:Toggle({
			Name = "Enabled",
			Flag = "Flag_AA_Viewer",
			Default = false,
			Callback = function(Value)
				AntiAimView = Value
			end,
		}):Keybind({
			Flag = "Flag_AA_Viewer_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		BypassSection:Toggle({
			Name = "Remove Chairs",
			Flag = "Flag_Remove_Chairs",
			Default = false,
			Callback = function(Value)
				for i, v in pairs(game.Workspace:GetDescendants()) do
					if v:IsA("Seat") then
						v.Disabled = Value
					end
				end
			end,
		})

		BypassSection:Seperator("")

		BypassSection:Button({
			Name = "God Mode",
			Callback = function()
				Client.Character:FindFirstChildOfClass("Humanoid").Health = 0
				local Spoof = Client.CharacterAdded:Wait()
				repeat
					wait()
				until Client.Character:FindFirstChildOfClass("Humanoid")
				swait(0.08)
				Client.Character["I_LOADED_I"].Ragdoll:Destroy()
			end,
		})
		BypassSection:Button({
			Name = "Force Reset",
			Callback = function()
				DestroyBody()
			end,
		})

		AnimationSection:Toggle({
			Name = "Custom Animation Speed",
			Flag = "Flag_Custom_Animation_Speed",
			Default = false,
			Callback = function(Value)
				CustomAnimationSpeed = Value
			end,
		})

		AnimationSection:Seperator("")

		AnimationSection:Button({
			Name = "Boxing Punch",
			Callback = function()
				Animation = Instance.new("Animation")
				Animation.AnimationId = "http://www.roblox.com/asset/?id=8429196710"

				AnimationTrack = Client.Character.Humanoid:LoadAnimation(Animation)
				AnimationTrack:Play()
				AnimationTrack:AdjustSpeed(3)
			end,
		})

		AnimationSection:Seperator("")

		AnimationSection:Slider({
			Name = "Animation Speed",
			Default = 1,
			Min = 1,
			Max = 100,
			Float = 0.1,
			Flag = "Flag_Animation_Speed",
			Callback = function(Value)
				AnimationSpeed = Value
			end,
		})

		AimbotSection:Toggle({
			Name = "Enabled",
			Flag = "Flag_Aimbot_Enabled",
			Default = false,
			Callback = function(Value)
				Aimbot = Value
			end,
		})

		AimbotSection:Seperator("")

		AimbotSection:Toggle({
			Name = "Highlights",
			Flag = "Flag_Aimbot_Highlights",
			Default = false,
			Callback = function(Value)
				AimbotHighlightTarget = Value
			end,
		})
		AimbotSection:Toggle({
			Name = "Tracers",
			Flag = "Flag_Aimbot_Tracers",
			Default = false,
			Callback = function(Value)
				AimbotTracerTarget = Value
			end,
		})

		AimbotSection:Seperator("")

		AimbotSection:Toggle({
			Name = "Hitbox Expander",
			Default = false,
			Flag = "Flag_Aimbot_HitboxExpander",
			Callback = function(Value)
				AimbotHitboxExtender = Value
			end,
		}):Keybind({
			Flag = "Flag_Aimbot_HitboxExpander_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		AimbotSection:Toggle({
			Name = "Resolver",
			Default = false,
			Flag = "Flag_Aimbot_Resolver",
			Callback = function(Value)
				AimbotResolver = Value
			end,
		}):Keybind({
			Flag = "Flag_Aimbot_Resolver_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		AimbotSection:Toggle({
			Name = "Auto Prediction",
			Default = false,
			Flag = "Flag_Aimbot_AutoPrediction",
			Callback = function(Value)
				AimbotAutoPrediction = Value
			end,
		}):Keybind({
			Flag = "Flag_Aimbot_AutoPrediction_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		AimbotSection:Toggle({
			Name = "Look At",
			Flag = "Flag_Aimbot_LookAt",
			Default = false,
			Callback = function(Value)
				AimbotLookAt = Value
			end,
		}):Keybind({
			Flag = "Flag_Aimbot_LookAt_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		AimbotSection:Seperator("")

		AimbotSection:Dropdown({
			Name = "Aimpart",
			Default = "HumanoidRootPart",
			Content = {
				"Head",
				"HumanoidRootPart",
				"UpperTorso",
				"LowerTorso",
			},
			Flag = "Flag_Aimbot_Aimpart",
			Callback = function(Value)
				AimbotAimpart = Value
			end,
		})
		AimbotSection:Dropdown({
			Name = "Aimbot Keybind",
			Default = "q",
			Content = {
				"q",
				"e",
				"c",
				"v",
			},
			Flag = "Flag_Aimbot_Keybind",
			Callback = function(Value)
				AimbotKey = Value
			end,
		})

		AimbotSection:Seperator("")

		AimbotSection:Slider({
			Name = "Prediction",
			Default = 0.1552,
			Min = 0.13,
			Max = 0.3,
			Float = 0.01,
			Flag = "Flag_Aimbot_Prediction",
			Callback = function(Value)
				AimbotPrediction = Value
			end,
		})

		StrafeSection:Toggle({
			Name = "Enabled",
			Flag = "Flag_Target_Strafe",
			Default = false,
			Callback = function(Value)
				TargetStrafe = Value
			end,
		}):Keybind({
			Flag = "Flag_Target_Strafe_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		StrafeSection:Seperator("")

		StrafeSection:Dropdown({
			Name = "Type",
			Default = "",
			Content = {
				"Orbit",
				"Randomize",
			},
			Flag = "Flag_Strafe_Type",
			Callback = function(Value)
				if Value == "Orbit" then
					OrbitStrafeType = true
					RandomizeStrafeType = false
				elseif Value == "Randomize" then
					RandomizeStrafeType = true
					OrbitStrafeType = false
				end
			end,
		})

		StrafeSection:Seperator("")

		StrafeSection:Slider({
			Name = "Distance",
			Default = 10,
			Min = 1,
			Max = 40,
			Float = 0.1,
			Flag = "Flag_StrafeDistance",
			Callback = function(Value)
				StrafeDistance = Value
			end,
		})
		StrafeSection:Slider({
			Name = "Speed",
			Default = 0.6,
			Min = 0.6,
			Max = 1,
			Float = 0.1,
			Flag = "Flag_StrafeSpeed",
			Callback = function(Value)
				StrafeSpeed = Value
			end,
		})
		StrafeSection:Slider({
			Name = "Height",
			Default = 4,
			Min = 0,
			Max = 10,
			Float = 0.1,
			Flag = "Flag_StrafeHeight",
			Callback = function(Value)
				StrafeHeight = Value
			end,
		})

		StreamableSection:Toggle({
			Name = "Enabled",
			Flag = "Flag_Streamable_Enabled",
			Default = false,
			Callback = function(Value)
				Streamable = Value
			end,
		})

		StreamableSection:Seperator("")

		StreamableSection:Dropdown({
			Name = "Aimpart",
			Default = "HumanoidRootPart",
			Content = {
				"Head",
				"HumanoidRootPart",
				"UpperTorso",
				"LowerTorso",
			},
			Flag = "Flag_Streamable_Aimpart",
			Callback = function(Value)
				StreamableAimpart = Value
			end,
		})
		StreamableSection:Dropdown({
			Name = "Streamable Keybind",
			Default = "v",
			Content = {
				"q",
				"e",
				"c",
				"v",
			},
			Flag = "Flag_Streamable_KeyBind",
			Callback = function(Value)
				StreamableKey = Value
			end,
		})

		StreamableSection:Seperator("")

		StreamableSection:Slider({
			Name = "Prediction",
			Default = 0.1552,
			Min = 0.13,
			Max = 0.3,
			Float = 0.01,
			Flag = "Flag_Streamable_Prediction",
			Callback = function(Value)
				StreamablePrediction = Value
			end,
		})
		StreamableSection:Slider({
			Name = "Smoothness",
			Default = 0.1,
			Min = 0.1,
			Max = 1,
			Float = 0.1,
			Flag = "Flag_Streamable_Smoothness",
			Callback = function(Value)
				if Value == 0 then
					StreamableSmoothness = 1
				elseif Value == 0.1 then
					StreamableSmoothness = 0.9
				elseif Value == 0.2 then
					StreamableSmoothness = 0.8
				elseif Value == 0.3 then
					StreamableSmoothness = 0.7
				elseif Value == 0.4 then
					StreamableSmoothness = 0.6
				elseif Value == 0.5 then
					StreamableSmoothness = 0.5
				elseif Value == 0.6 then
					StreamableSmoothness = 0.4
				elseif Value == 0.7 then
					StreamableSmoothness = 0.3
				elseif Value == 0.8 then
					StreamableSmoothness = 0.2
				elseif Value == 0.9 then
					StreamableSmoothness = 0.1
				end
			end,
		})

		TargetSection:Box({
			Name = "Select Target",
			Default = "",
			Placeholder = "Target-Name",
			Flag = "Flag_Select_Target",
			Callback = function(Value)
				for i, v in pairs(Players:GetPlayers()) do
					if v ~= Client then
						if
							(string.sub(string.lower(v.Name), 1, string.len(Value))) == string.lower(Value)
							or (string.sub(string.lower(v.DisplayName), 1, string.len(Value)))
								== string.lower(Value)
						then
							SectionTarget = v
						end
					end
				end
			end,
		})
		TargetSection:Toggle({
			Name = "View",
			Flag = "Flag_View",
			Default = false,
			Callback = function(Value)
				if Value then
					workspace.Camera.CameraSubject = SectionTarget.Character
				else
					workspace.Camera.CameraSubject = Client.Character
				end
			end,
		})
		TargetSection:Button({
			Name = "Fling",
			Callback = function()
				if
					SectionTarget ~= nil
					and SectionTarget.Character
					and SectionTarget.Character.I_LOADED_I["K.O"].Value == false
				then
					ReturnPosition = Client.Character.HumanoidRootPart.CFrame
					if not FlingDesync then
						FlingDesync = true
					end
					swait(0.16)
					repeat
						RunService.Heartbeat:Wait()
						Client.Character.HumanoidRootPart.CFrame = SectionTarget.Character.HumanoidRootPart.CFrame
							+ SectionTarget.Character.Humanoid.MoveDirection * 8.3
					until SectionTarget.Character.HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 70
						or SectionTarget.Character.HumanoidRootPart.AssemblyAngularVelocity.Magnitude > 70
						or SectionTarget.Character.Humanoid.Health == 0
						or Client.Character.Humanoid.Health == 0
					Client.Character.HumanoidRootPart.CFrame = ReturnPosition
					swait(0.16)
					if FlingDesync then
						FlingDesync = false
					end
				end
			end,
		})
		TargetSection:Button({
			Name = "Gun TP",
			Callback = function()
				if SectionTarget ~= nil and SectionTarget.Character then
					local Gun = Client.Character:FindFirstChildWhichIsA("Tool")
					if Gun ~= nil and Gun:FindFirstChild("GunScript") and Gun:FindFirstChild("Handle") then
						Client.Character["RightHand"]["RightGrip"]:Destroy()
						repeat
							RunService.Heartbeat:Wait()
							OldAssemblyVelocity = Gun.Handle.AssemblyLinearVelocity
							OldVelocity = Gun.Handle.Velocity
							Gun.Handle.AssemblyLinearVelocity =
								Vector3.new(OldAssemblyVelocity.X, 270, OldAssemblyVelocity.Z)
							Gun.Handle.Velocity = Vector3.new(OldVelocity.X, 170, OldVelocity.Z)
							Gun.Handle.CFrame = (SectionTarget.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5, 0))
						until not Client.Character:FindFirstChildWhichIsA("Tool")
					end
				end
			end,
		})
		TargetSection:Button({
			Name = "Melee TP",
			Callback = function()
				if SectionTarget ~= nil and SectionTarget.Character then
					local Melee = Client.Character:FindFirstChildWhichIsA("Tool")
					if Melee ~= nil and not Melee:FindFirstChild("GunScript") and Melee:FindFirstChild("Handle") then
						Client.Character["RightHand"]["RightGrip"]:Destroy()
						repeat
							RunService.Heartbeat:Wait()
							OldAssemblyVelocity = Melee.Handle.AssemblyLinearVelocity
							OldVelocity = Melee.Handle.Velocity
							Melee.Handle.AssemblyLinearVelocity =
								Vector3.new(OldAssemblyVelocity.X, 270, OldAssemblyVelocity.Z)
							Melee.Handle.Velocity = Vector3.new(OldVelocity.X, 170, OldVelocity.Z)
							Melee.Handle.CFrame = SectionTarget.Character.HumanoidRootPart.CFrame
								+ SectionTarget.Character.Humanoid.MoveDirection * 12.8
						until not Client.Character:FindFirstChildWhichIsA("Tool")
					end
				end
			end,
		})
		TargetSection:Button({
			Name = "Goto",
			Callback = function()
				if SectionTarget ~= nil and SectionTarget.Character then
					SetBypass(true)
					swait(0.16)
					Client.Character.HumanoidRootPart.CFrame = SectionTarget.Character.HumanoidRootPart.CFrame
						+ Vector3.new(0, 0, 5)
					swait(0.16)
					SetBypass(false)
				end
			end,
		})
		TargetSection:Button({
			Name = "Aimbot",
			Callback = function()
				if SectionTarget ~= nil and Aimbot then
					AimbotEnabled = true
					AimbotTarget = SectionTarget
				end
			end,
		})

		TeleportSection:Button({
			Name = "Bank",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-422, 349, -82)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Casino",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-838, 331, 41)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Gun Shop",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-559, 317, -533)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "School",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-571, 330, 418)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Island",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-95, 401, 862)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Boxing Club",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-209, 331, -916)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Boat",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(137, 335, 268)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Gym",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-57, 332, -408)
				swait(0.16)
				SetBypass(false)
			end,
		})
		TeleportSection:Button({
			Name = "Motel",
			Callback = function()
				SetBypass(true)
				swait(0.16)
				Client.Character.HumanoidRootPart.CFrame = CFrame.new(-1198, 343, -369)
				swait(0.16)
				SetBypass(false)
			end,
		})

		AutoBuySection:Button({
			Name = "Purchase",
			Callback = function()
				PurchaseItem()
			end,
		})
		AutoBuySection:Keybind({
			Name = "Purchase Selected",
			Flag = "Flag_Purchase_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Callback = function()
				PurchaseItem()
			end,
		})

		AutoBuySection:Seperator("")

		AutoBuySection:Dropdown({
			Name = "Purchase Type",
			Default = "",
			Content = {
				"Gun",
				"Other",
				"Armor",
			},
			Flag = "Flag_Purchase_Type",
			Callback = function(Value)
				if Value == "Gun" then
					GunSelected = true
					OtherSelected = false
					ArmorSelected = false
				elseif Value == "Other" then
					OtherSelected = true
					GunSelected = false
					ArmorSelected = false
				elseif Value == "Armor" then
					ArmorSelected = true
					GunSelected = false
					OtherSelected = false
				end
			end,
		})
		AutoBuySection:Dropdown({
			Name = "Guns",
			Default = "",
			Content = {
				"[Revolver] - $1600",
				"[Double Barrel SG] - $800",
				"[LMG] - $4250",
				"[UMP] - $1100",
				"[AK-47] - $2250",
				"[SMG] - $700",
				"[Sniper] - $2000",
				"[AR] - $1350",
				"[Deagle] - $750",
				"[PlasmaRifle] - $12500",
				"[Golden AK-47] - $5250",
			},
			Flag = "Flag_Weapons_Chosen",
			Callback = function(Value)
				ChosenGun = Value
			end,
		})
		AutoBuySection:Dropdown({
			Name = "Others",
			Default = "",
			Content = {
				"[Popcorn] - $3",
				"[Mask] - $25",
				"[Knife] - $125",
				"[Bat] - $275",
			},
			Flag = "Flag_Others_Chosen",
			Callback = function(Value)
				ChosenOther = Value
			end,
		})
		AutoBuySection:Dropdown({
			Name = "Armors",
			Default = "",
			Content = {
				"[Medium Armor] - $550",
				"[High-Medium Armor] - $550",
				"[High Armor] - $550",
			},
			Flag = "Flag_Armor_Chosen",
			Callback = function(Value)
				ChosenArmor = Value
			end,
		})

		EspSection:Toggle({
			Name = "ESP Enabled",
			Flag = "Flag_ESP_Enabled",
			Default = false,
			Callback = function(Value)
				ESPFramework:Toggle(Value)
				ESPFramework.Players = Value
			end,
		}):Keybind({
			Flag = "Flag_ESP_Enabled_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		EspSection:Toggle({
			Name = "Names",
			Flag = "Flag_Esp_Names",
			Default = false,
			Callback = function(Value)
				ESPFramework.Names = Value
			end,
		})
		EspSection:Toggle({
			Name = "Tracers",
			Flag = "Flag_Esp_Tracers",
			Default = false,
			Callback = function(Value)
				ESPFramework.Tracers = Value
			end,
		})
		EspSection:Toggle({
			Name = "Boxes",
			Flag = "Flag_Esp_Boxes",
			Default = false,
			Callback = function(Value)
				ESPFramework.Boxes = Value
			end,
		})

		ExtraSection:Toggle({
			Name = "Chat Spy",
			Flag = "Flag_Chat_Spy",
			Default = false,
			Callback = function(Value)
				local ChatSpyFrame = Client.PlayerGui.Chat.Frame
				if Value then
					ChatSpyFrame.ChatChannelParentFrame.Visible = true
					ChatSpyFrame.ChatBarParentFrame.Position = ChatSpyFrame.ChatChannelParentFrame.Position
						+ UDim2.new(UDim.new(), ChatSpyFrame.ChatChannelParentFrame.Size.Y)
				else
					ChatSpyFrame.ChatChannelParentFrame.Visible = false
				end
			end,
		})
		ExtraSection:Toggle({
			Name = "Return on death",
			Flag = "Flag_Deathreturn",
			Default = false,
			Callback = function(Value)
				Deathreturn = Value
			end,
		})
		ExtraSection:Toggle({
			Name = "Star Detector",
			Flag = "Flag_Star_Detector",
			Default = false,
			Callback = function(Value)
				StarDetector = Value
			end,
		})

		ExtraSection:Seperator("")

		ExtraSection:Button({
			Name = "Rejoin",
			Callback = function()
				Client:Kick("Rejoining")
				swait(0.2)
				TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
			end,
		})

		ExtraSection:Button({
			Name = "Check For Stars",
			Callback = function()
				CheckForStars()
			end,
		})

		ExtraSection:Seperator("")

		ExtraSection:Slider({
			Name = "Field Of View",
			Default = 70,
			Min = 60,
			Max = 300,
			Float = 0.1,
			Flag = "Flag_Customs_Field_Of_View",
			Callback = function(Value)
				Camera.FieldOfView = Value
			end,
		})

		StompSection:Toggle({
			Name = "Stomp Farm",
			Flag = "Flag_Stomp_Farm",
			Default = false,
			Callback = function(Value)
				StompFarm = Value
				if not Value then
					SetBypass(false)
				end
			end,
		}):Keybind({
			Flag = "Flag_Stomp_Farm_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		StompSection:Toggle({
			Name = "Stomp Aura",
			Flag = "Flag_Stomp_Aura",
			Default = false,
			Callback = function(Value)
				StompAura = Value
			end,
		}):Keybind({
			Flag = "Flag_Stomp_Aura_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		CrashSection:Button({
			Name = "Crash",
			Callback = function()
				while wait(0.6) do
					game:GetService("NetworkClient"):SetOutgoingKBPSLimit(math.huge)

					local function GetMaxValue(Value)
						local MainValueIfOneTable = 499999
						if type(Value) ~= "number" then
							return nil
						end
						local CalculatePerfectValue = (MainValueIfOneTable / (Value + 2))
						return CalculatePerfectValue
					end

					local function Pingbomb(TableIncrease, Tries)
						local MainTable = {}
						local SpammedTable = {}

						table.insert(SpammedTable, {})

						Variable = SpammedTable[1]
						for i = 1, TableIncrease do
							local TableIns = {}
							table.insert(Variable, TableIns)
							Variable = TableIns
						end

						local CalculateMaximum = GetMaxValue(TableIncrease)
						local Maximum

						if CalculateMaximum then
							Maximum = CalculateMaximum
						else
							Maximum = 999999
						end

						for i = 1, Maximum do
							table.insert(MainTable, SpammedTable)
						end

						for i = 1, Tries do
							game.RobloxReplicatedStorage.SetPlayerBlockList:FireServer(MainTable)
						end
					end
					Pingbomb(250, CrashStrength)
				end
			end,
		})

		CrashSection:Seperator("")

		CrashSection:Slider({
			Name = "Crash Strength",
			Default = 2,
			Min = 1,
			Max = 10,
			Float = 0.1,
			Flag = "Flag_Crash_Strength",
			Callback = function(Value)
				CrashStrength = Value
			end,
		})

		ToolSection:Toggle({
			Name = "Reach",
			Flag = "Flag_Reach",
			Default = false,
			Callback = function(Value)
				Reach = Value
			end,
		}):Keybind({
			Flag = "Flag_Reach_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		ToolSection:Toggle({
			Name = "Auto Reload",
			Flag = "Flag_Auto_Reload",
			Default = false,
			Callback = function(Value)
				AutoReload = Value
			end,
		}):Keybind({
			Flag = "Flag_Auto_Reload_Keybind",
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Mode = "Toggle",
		})

		StompChangerSection:Toggle({
			Name = "Enabled",
			Flag = "Flag_Stomp_Changer_Enabled",
			Default = false,
			Callback = function(Value)
				StompChanger = Value
			end,
		})

		StompChangerSection:Dropdown({
			Name = "Select Type",
			Default = "",
			Content = {
				"Server Side",
				"Client Side",
			},
			Flag = "Flag_StompType_Chosen",
			Callback = function(Value)
				if Value == "Server Side" then
					ServerStomps = true
					ClientStomps = false
				elseif Value == "Client Side" then
					ClientStomps = true
					ServerStomps = false
				end
			end,
		})

		StompChangerSection:Dropdown({
			Name = "Select Server Stomp",
			Default = "",
			Content = {
				"Yeet",
				"Goku",
				"Scorpion",
				"Uppercut",
				"Ground Smash",
				"Enhanced Vision",
			},
			Flag = "Flag_ServerStomp_Chosen",
			Callback = function(Value)
				if Value == "Yeet" then
					YeetServerStomp = true
					GokuServerStomp = false
					ScorpionServerStomp = false
					UppercutServerStomp = false
					GroundSmashServerStomp = false
					EnhancedVisionServerStomp = false
				elseif Value == "Goku" then
					GokuServerStomp = true
					YeetServerStomp = false
					ScorpionServerStomp = false
					UppercutServerStomp = false
					GroundSmashServerStomp = false
					EnhancedVisionServerStomp = false
				elseif Value == "Scorpion" then
					ScorpionServerStomp = true
					GokuServerStomp = false
					YeetServerStomp = false
					UppercutServerStomp = false
					GroundSmashServerStomp = false
					EnhancedVisionServerStomp = false
				elseif Value == "Uppercut" then
					UppercutServerStomp = true
					ScorpionServerStomp = false
					GokuServerStomp = false
					YeetServerStomp = false
					GroundSmashServerStomp = false
					EnhancedVisionServerStomp = false
				elseif Value == "Ground Smash" then
					GroundSmashServerStomp = true
					UppercutServerStomp = false
					ScorpionServerStomp = false
					GokuServerStomp = false
					YeetServerStomp = false
					EnhancedVisionServerStomp = false
				elseif Value == "Enhanced Vision" then
					EnhancedVisionServerStomp = true
					GroundSmashServerStomp = false
					UppercutServerStomp = false
					ScorpionServerStomp = false
					GokuServerStomp = false
					YeetServerStomp = false
				end
			end,
		})

		StompChangerSection:Dropdown({
			Name = "Select Client Stomp",
			Default = "",
			Content = {
				"Kameha",
				"Destroyer",
				"Megalodon",
				"Dragon",
				"Rune",
				"Shapeshifter",
				"Shiny Spirit",
				"Lightning",
			},
			Flag = "Flag_ClientStomp_Chosen",
			Callback = function(Value)
				if Value == "Kameha" then
					Kameha = true
					Destroyer = false
					Megalodon = false
					Dragon = false
					Rune = false
					Shapeshifter = false
					ShinySpirit = false
					Lightning = false
				elseif Value == "Destroyer" then
					Destroyer = true
					Kameha = false
					Megalodon = false
					Dragon = false
					Rune = false
					Shapeshifter = false
					ShinySpirit = false
					Lightning = false
				elseif Value == "Megalodon" then
					Megalodon = true
					Kameha = false
					Destroyer = false
					Dragon = false
					Rune = false
					Shapeshifter = false
					ShinySpirit = false
					Lightning = false
				elseif Value == "Dragon" then
					Dragon = true
					Kameha = false
					Destroyer = false
					Megalodon = false
					Rune = false
					Shapeshifter = false
					ShinySpirit = false
					Lightning = false
				elseif Value == "Rune" then
					Rune = true
					Dragon = false
					Kameha = false
					Destroyer = false
					Megalodon = false
					Shapeshifter = false
					ShinySpirit = false
					Lightning = false
				elseif Value == "Shapeshifter" then
					Shapeshifter = true
					Rune = false
					Dragon = false
					Kameha = false
					Destroyer = false
					Megalodon = false
					ShinySpirit = false
					Lightning = false
				elseif Value == "Shiny Spirit" then
					ShinySpirit = true
					Rune = false
					Dragon = false
					Kameha = false
					Destroyer = false
					Megalodon = false
					Shapeshifter = false
					Lightning = false
				elseif Value == "Lightning" then
					Lightning = true
					Rune = false
					Dragon = false
					Kameha = false
					Destroyer = false
					Megalodon = false
					Shapeshifter = false
					ShinySpirit = false
				end
			end,
		})
		local ConfigList = ConfigSection:Dropdown({
			Name = "Config List",
			Content = UIFramework:GetConfigs(),
			Flag = "Flag_Config_Dropdown",
		})

		ConfigSection:Button({
			Name = "Delete Config",
			Callback = function()
				UIFramework:DeleteConfig(UIFramework.flags["Flag_Config_Dropdown"])
				ConfigList:Refresh(UIFramework:GetConfigs())
			end,
		})

		ConfigSection:Button({
			Name = "Save Config",
			Callback = function()
				UIFramework:SaveConfig(
					UIFramework.flags["Flag_Config_Dropdown"] or UIFramework.flags["Flag_Config_Name"]
				)
				ConfigList:Refresh(UIFramework:GetConfigs())
			end,
		})

		ConfigSection:Button({
			Name = "Load Config",
			Callback = function()
				UIFramework:LoadConfig(UIFramework.flags["Flag_Config_Dropdown"])
			end,
		})

		ConfigSection:Box({
			Name = "Config Name",
			Placeholder = "Config Name Here",
			Flag = "Flag_Config_Name",
		})

		ConfigSection:Button({
			Name = "Unload UI",
			Callback = function()
				UIFramework:Unload()
			end,
		})

		ConfigSection:Keybind({
			Name = "Toggle UI",
			Flag = "Flag_UI_Toggle",
			Default = Enum.KeyCode.RightShift,
			Blacklist = {
				Enum.UserInputType.MouseButton1,
				Enum.UserInputType.MouseButton2,
				Enum.UserInputType.MouseButton3,
			},
			Callback = function(_, fs)
				if not fs then
					UIFramework:Close()
				end
			end,
		})
	end)
	if not Success and Error then
		pcall(function()
			messagebox("There has been an error", "Vitality", 0)
		end)
	end
else
	messagebox("Wrong game, kicking in 3s", "Vitality", 0)
	swait(3)
	Client:Kick("Wrong game.")
end
