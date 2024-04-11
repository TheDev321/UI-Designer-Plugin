
local TweenService = game:GetService("TweenService")

local UITweens = {}

UITweens.PlayVariable = false
UITweens.IsHovering   = false
UITweens.IsPressed    = false

UITweens.HoverInPlaying  = false
UITweens.HoverOutPlaying = false
UITweens.PressPlaying    = false

UITweens.Button = nil

UITweens.TweenPress = nil

UITweens.TweenInfoIn = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.In,
	0,
	false,
	0
)

UITweens.TweenInfoOut = TweenInfo.new(
	0.2,
	Enum.EasingStyle.Quart,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

function UITweens:PlayTween(tween, playVariable)
	if not playVariable then
		tween:Play()
		playVariable = true
	end
end

function UITweens:CancelTween(tween, playVariable)
	if playVariable then
		tween:Cancel()
		playVariable = false
	end
end

function UITweens:TweenHoverIn(button)
	self.Button = button
	local baseSize = button.Size

	local tweenHoverIn = TweenService:Create(button, self.TweenInfoIn, { Size = UDim2.new(baseSize.X.Scale * 1.05, 0, baseSize.Y.Scale * 1.05, 0)})
	self:PlayTween(tweenHoverIn, self.HoverInPlaying)
end

function UITweens:TweenHoverOut(button)
	self.Button = button
	local baseSize = button.Size
	
	local tweenHoverOut = TweenService:Create(button, self.TweenInfoOut, { Size = baseSize })
	self:PlayTween(tweenHoverOut, self.HoverOutPlaying)
end

function UITweens:TweenButtonPressedIn(button)
	self.Button = button
	local baseSize = button.Size
	
	self.TweenPress = TweenService:Create(UITweens.Button, UITweens.TweenInfoOut, { Size = UDim2.new(UITweens.Button.Size.X.Scale * 0.95, 0, UITweens.Button.Size.Y.Scale * 0.95, 0) })
	
	self:PlayTween(self.TweenPress, self.PressPlaying)
end

function UITweens:TweenButtonPressedOut(button)
	self.Button = button
	self.IsPressed = false
	
	self.TweenPress = TweenService:Create(UITweens.Button, UITweens.TweenInfoOut, { Size = UDim2.new(UITweens.Button.Size.X.Scale * 0.95, 0, UITweens.Button.Size.Y.Scale * 0.95, 0) })
	self:CancelTween(self.TweenPress, self.PressPlaying)
	
	--if self.IsHovering then
		--self:PlayTween(self:TweenHoverIn(button), self.HoverInPlaying)
	--else
		--self:PlayTween(self:TweenHoverOut(button), self.HoverOutPlaying)
	--end
end

return UITweens
