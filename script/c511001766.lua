--Big Jaws (Anime)
function c511001766.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001766.spcon)
	c:RegisterEffect(e1)
	if not c511001766.global_check then
		c511001766.global_check=true
		c511001766[0]=true
		c511001766[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetOperation(c511001766.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001766.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001766.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c511001766[tp]
end
function c511001766.checkop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetActiveType()==TYPE_SPELL and re:IsHasType(EFFECT_TYPE_ACTIVATE) then
		c511001766[rp]=true
	end
end
function c511001766.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001766[0]=false
	c511001766[1]=false
end
