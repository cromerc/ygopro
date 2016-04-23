--レッドアイズ・バーン
function c100000113.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c100000113.condition)
	e1:SetOperation(c100000113.operation)
	c:RegisterEffect(e1)
end
function c100000113.cfilter(c,tp)
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsSetCard(0x3b) and c:IsType(TYPE_MONSTER)
end
function c100000113.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c100000113.cfilter,1,nil,tp)
end
function c100000113.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
	local atk=eg:GetFirst():GetAttack()
	Duel.Damage(1-tp,atk,REASON_EFFECT)
	Duel.Damage(tp,atk,REASON_EFFECT)
end
