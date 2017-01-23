--Perfectly utimate Great moth (Anime)
--scripted by GameMaster (GM)
function c511005603.initial_effect(c)
	c:EnableReviveLimit()
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511005603.spcon)
	e2:SetOperation(c511005603.spop)
	c:RegisterEffect(e2)
	--atkdown
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_PHASE+PHASE_END)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511005603.atkcon)
	e3:SetOperation(c511005603.atkop)
	e3:SetCountLimit(1)
	c:RegisterEffect(e3)
end
function c511005603.eqfilter(c)
	return c:IsCode(40240595) and c:GetTurnCounter()>=5
end
function c511005603.rfilter(c)
	return c:IsCode(58192742) and c:GetEquipGroup():FilterCount(c511005603.eqfilter,nil)>0
end
function c511005603.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),c511005603.rfilter,1,nil)
end
function c511005603.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),c511005603.rfilter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511005603.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp
end

function c511005603.atkop(e,tp,eg,ep,ev,re,r,rp)
    local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_MZONE,nil)
    local tc=g:GetFirst()
    while tc do
        local e1=Effect.CreateEffect(e:GetHandler())
        e1:SetType(EFFECT_TYPE_SINGLE)
        e1:SetCode(EFFECT_UPDATE_ATTACK)
        e1:SetValue(-100)
        e1:SetReset(RESET_EVENT+0x1fe0000)
        tc:RegisterEffect(e1)
         local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
        tc=g:GetNext()
        
    end
end
