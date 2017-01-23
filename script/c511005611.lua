--Temple of skulls (DOR)
--scripted by GameMaster (GM)
function c511005611.initial_effect(c)
	--cannot trigger
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(1,1)
	e1:SetCondition(c511005611.con)
	e1:SetValue(c511005611.aclimit)
	c:RegisterEffect(e1)
	--disable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DISABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511005611.con)
	e2:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e2:SetTarget(c511005611.distg)
	c:RegisterEffect(e2)
	--disable effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_CHAIN_SOLVING)
	e3:SetCondition(c511005611.con)
	e3:SetRange(LOCATION_MZONE)
	e3:SetOperation(c511005611.disop)
	c:RegisterEffect(e3)
end
function c511005611.aclimit(e,re,tp)
	return re:IsActiveType(TYPE_SPELL)
end
function c511005611.distg(e,c)
	return c:IsType(TYPE_SPELL)
end
function c511005611.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if tl==LOCATION_SZONE and re:IsActiveType(TYPE_SPELL) then
		Duel.NegateEffect(ev)
	end
end
function c511005611.con(e)
	return e:GetHandler():IsDefensePos()
end