--
function c100015202.initial_effect(c)
	--synchro summon
    aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--synchro summon success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c100015202.drop)
	c:RegisterEffect(e1)
	--cannot be target
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c100015202.targetd)
	e2:SetValue(c100015202.tgval)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	c:RegisterEffect(e3)
end
function c100015202.drop(e,tp,eg,ep,ev,re,r,rp)	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c100015202.targetd(e,c)
	return c:IsSetCard(0x400)
end
function c100015202.tgval(e,re,rp)
	return e:GetHandlerPlayer()~=rp
end