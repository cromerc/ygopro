--Action Card - Space Debris
function c95000174.initial_effect(c)
		--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetTarget(c95000174.target)
	e1:SetOperation(c95000174.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000174.handcon)
	c:RegisterEffect(e2)
end
function c95000174.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end
function c95000174.filter(c,e,tp)
	return c:GetPreviousControler()==1-tp and c:IsPreviousLocation(LOCATION_MZONE)
		and (c:IsReason(REASON_EFFECT) or (c:IsReason(REASON_BATTLE) and Duel.GetAttacker():IsControler(1-tp)))
		and c:GetBaseDefense()>0 and c:IsCanBeEffectTarget(e) and c:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED)
end
function c95000174.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c95000174.filter(chkc,e,tp) end
	if chk==0 then return eg:IsExists(c95000174.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=eg:FilterSelect(tp,c95000174.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c95000174.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Damage(1-tp,tc:GetBaseDefense(),REASON_EFFECT)
	end
end
