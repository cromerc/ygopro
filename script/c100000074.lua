--大牛鬼
function c100000074.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000074.spcon)
	e1:SetOperation(c100000074.spop)
	c:RegisterEffect(e1)
	--chain attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000074,0))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetOperation(c100000074.atop)
	c:RegisterEffect(e3)
end
function c100000074.spfilter(c,code)
	return c:GetCode()==code
end
function c100000074.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(tp,c100000074.spfilter,1,nil,48649353)
end
function c100000074.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c100000074.spfilter,1,1,nil,48649353)
	Duel.Release(g1,REASON_COST)
end
function c100000074.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end