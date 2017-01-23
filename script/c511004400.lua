--Vanilla Mode
--scripted by andré and shad3 and Cybercatman
function c511004400.initial_effect(c)
	--active
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_HAND+LOCATION_DECK)
	e1:SetCountLimit(1)
	e1:SetCondition(c511004400.aco)
	e1:SetOperation(c511004400.aop)
	c:RegisterEffect(e1)
end
function c511004400.aco(e,tp,eg,ev,ep,re,r,rp)
	return Duel.GetTurnCount()<=1
end
function c511004400.aop(e,tp,eg,ev,ep,re,r,rp)
	local c=e:GetHandler()
	local lol=LOCATION_ONFIELD+LOCATION_GRAVE+LOCATION_REMOVED+LOCATION_DECK
	Duel.DisableShuffleCheck()
	Duel.SendtoDeck(c,tp,-2,REASON_RULE)
	if c:GetPreviousLocation()==LOCATION_HAND then
		Duel.Draw(tp,1,REASON_RULE)
	end
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCondition(c511004400.condition)
	e1:SetTargetRange(1,1)
	e1:SetValue(c511004400.aclimit)
	Duel.RegisterEffect(e1,tp)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCondition(c511004400.condition)
	e2:SetTargetRange(lol,lol)
	e2:SetTarget(c511004400.disable)
	e2:SetCode(EFFECT_DISABLE)
	Duel.RegisterEffect(e2,tp)
	--triger stuff
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_TRIGGER)
	Duel.RegisterEffect(e3,tp)
end
function c511004400.condition()
   return Duel.GetFlagEffect(0,511004401)==0
end
function c511004400.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_MONSTER)
end
function c511004400.disable(e,c)
	return c:IsType(TYPE_MONSTER)
end
--[[
"vanilla mode" reference
1:majesty's fiend
2:skill drain
3:vector pendulum
4:concentration duel
5:Red supremacy
ability yeil currennt id:
51100441
--]]