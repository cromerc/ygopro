--
function c100015204.initial_effect(c)
	--synchro summon
    aux.AddSynchroProcedure(c,nil,aux.NonTuner(Card.IsSetCard,0x400),1)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetCountLimit(1)
	e1:SetCondition(c100015204.atkcon)
    e1:SetTarget(c100015204.distg)
	e1:SetOperation(c100015204.atkop)
	c:RegisterEffect(e1)
	--synchro summon success
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_REMOVE)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetOperation(c100015204.drop)
	c:RegisterEffect(e3)
end
function c100015204.drop(e,tp,eg,ep,ev,re,r,rp)	
	local dg=Duel.GetDecktopGroup(tp,1)
	local tc=dg:GetFirst()
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end
function c100015204.atkcon(e,tp,eg,ep,ev,re,r,rp)
    local ph=Duel.GetCurrentPhase()
    return ph==PHASE_MAIN1 or ph==PHASE_MAIN2
end
function c100015204.distg(e,tp,eg,ep,ev,re,r,rp,chk)
        if chk==0 then return Duel.IsPlayerCanDiscardDeck(1-tp,1) end
        Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,1-tp,1)
end
function c100015204.atkop(e,tp,eg,ep,ev,re,r,rp)
	local dg=Duel.GetDecktopGroup(1-tp,1)
	local tc=dg:GetFirst()
	if not tc or not tc:IsAbleToRemove() then return end
	Duel.DisableShuffleCheck()
	Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
end