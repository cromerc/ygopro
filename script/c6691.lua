--Scripted by Eerie Code
--Great Horn of Heaven
function c6691.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCondition(c6691.condition)
	e1:SetTarget(c6691.target)
	e1:SetOperation(c6691.activate)
	c:RegisterEffect(e1)	
end

function c6691.condition(e,tp,eg,ep,ev,re,r,rp)
	local ph=Duel.GetCurrentPhase()
	return Duel.GetTurnPlayer()==1-tp and (ph==PHASE_MAIN1 or ph==PHASE_MAIN2) and Duel.GetCurrentChain()==0
end
function c6691.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,eg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,eg:GetCount(),0,0)
end
function c6691.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
	Duel.Draw(1-tp,1,REASON_EFFECT)
	local ph=Duel.GetCurrentPhase()
	Duel.SkipPhase(1-tp,ph,RESET_PHASE+ph,1)
end