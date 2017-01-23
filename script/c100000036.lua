--アショカ・ピラー
function c100000036.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_LEAVE_FIELD)
	e1:SetCondition(c100000036.dmcon)
	e1:SetTarget(c100000036.dmtg)
	e1:SetOperation(c100000036.dmop)
	c:RegisterEffect(e1)
end
function c100000036.dmcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:IsPreviousPosition(POS_FACEUP)
		and (not c:IsReason(REASON_BATTLE) or bit.band(c:GetBattlePosition(),POS_FACEUP)~=0)
end
function c100000036.dmtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,tp,2000)
end
function c100000036.dmop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(tp,2000,REASON_EFFECT)
end
