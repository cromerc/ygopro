--~ Bond With the Spirit Beast
function c13700019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c13700019.target)
	e1:SetOperation(c13700019.activate)
	c:RegisterEffect(e1)
end
function c13700019.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x1376) or c:IsSetCard(0x1377) or c:IsSetCard(0x1378)) and c:IsAbleToRemove()
end
function c13700019.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c13700019.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c13700019.filter,tp,LOCATION_MZONE,0,2,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c13700019.filter,tp,LOCATION_MZONE,0,2,2,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
end
function c13700019.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tc=g:Filter(Card.IsRelateToEffect,nil,e)
	if tc then
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
			local g=Duel.SelectMatchingCard(tp,c13700019.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
		Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
	end
end

function c13700019.filter2(c)
	return c:IsSetCard(0x1378)
end
