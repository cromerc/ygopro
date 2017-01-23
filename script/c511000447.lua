--Wind Pressure Compensation
function c511000447.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	c:RegisterEffect(e1)
	--change pos
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000447,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c511000447.poscon)
	e2:SetTarget(c511000447.postg)
	e2:SetOperation(c511000447.posop)
	c:RegisterEffect(e2)
end
function c511000447.cfilter(c,tp)
	return c:IsReason(REASON_BATTLE) and c:GetPreviousControler()==tp
end
function c511000447.poscon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c511000447.cfilter,1,nil,tp)
end
function c511000447.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,Duel.GetAttacker(),1,0,0)
end
function c511000447.posop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,0,0)
end
