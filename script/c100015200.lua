--
function c100005200.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,c100005200.tfilter,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
	--synchro summon success
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE+CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(c100005200.drop)
	c:RegisterEffect(e1)
	--REMOVED
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_REMOVED)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)	
	e2:SetCondition(c100005200.tdcon)
	e2:SetOperation(c100005200.tdop)
	c:RegisterEffect(e2)
end
function c100005200.tfilter(c)
	return c:IsSetCard(0x99)
end
function c100005200.drop(e,tp,eg,ep,ev,re,r,rp)	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c100005200.tdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousPosition(POS_FACEUP)
end
function c100005200.tdop(e,tp,eg,ep,ev,re,r,rp)	
	local dg=Duel.GetDecktopGroup(1-tp,1)
	local tc=dg:GetFirst()
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
