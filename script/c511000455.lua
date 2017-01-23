--Spirit Hunting
function c511000455.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000455.target)
	e1:SetOperation(c511000455.activate)
	c:RegisterEffect(e1)
end
function c511000455.filter(c)
	return c:IsDefensePos() and c:IsDestructable()
end
function c511000455.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,0,1,nil) and Duel.IsExistingMatchingCard(c511000455.filter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,0,1,1,nil)
	local g=Duel.GetMatchingGroup(c511000455.filter,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c511000455.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if Duel.ChangePosition(tc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)~=0 then
			local g=Duel.GetMatchingGroup(c511000455.filter,tp,0,LOCATION_MZONE,nil)
			if g:GetCount()>0 then
				Duel.Destroy(g,REASON_EFFECT)
			end
		end
	end
end
