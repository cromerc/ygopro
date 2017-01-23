--クリスタル・ヴェール
function c511001024.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCost(c511001024.cost)
	e1:SetCondition(c511001024.condition)
	e1:SetTarget(c511001024.target)
	e1:SetOperation(c511001024.activate)
	c:RegisterEffect(e1)
end
function c511001024.costfilter(c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsAbleToRemoveAsCost()
end
function c511001024.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001024.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer()
end
function c511001024.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then 	
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001024.costfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511001024.costfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	local atk=g:GetFirst():GetAttack()/2
	if atk<0 then atk=0 end
	Duel.Remove(g,POS_FACEUP,REASON_COST)
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(atk)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk)
end
function c511001024.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Damage(p,d,REASON_EFFECT)
	end
end
