--ワイゼルＧ３
function c100000047.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c100000047.spcon)
	e1:SetOperation(c100000047.spop)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetCondition(c100000047.sdcon2)
	c:RegisterEffect(e2)
	--change battle target
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000047,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BE_BATTLE_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c100000047.cbcon)
	e3:SetOperation(c100000047.cbop)
	c:RegisterEffect(e3)
	--battle indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e4:SetCountLimit(1)
	e4:SetValue(c100000047.valcon)
	c:RegisterEffect(e4)
end
function c100000047.spfilter(c,code)
	return c:GetCode()==code
end
function c100000047.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(tp,c100000047.spfilter,1,nil,100000053)
end
function c100000047.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g1=Duel.SelectReleaseGroup(tp,c100000047.spfilter,1,1,nil,100000053)
	Duel.Release(g1,REASON_COST)
end
function c100000047.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000047.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c100000047.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c100000047.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return c~=bt and bt:GetControler()==c:GetControler()
end
function c100000047.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c100000047.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end