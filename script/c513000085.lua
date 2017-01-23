--ディメンション・ワンダラー
function c513000085.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(62107612,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_REMOVE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c513000085.condition)
	e1:SetCost(c513000085.cost)
	e1:SetTarget(c513000085.target)
	e1:SetOperation(c513000085.operation)
	c:RegisterEffect(e1)
end
function c513000085.condition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re
end
function c513000085.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c513000085.filter(c)
	return c:IsFaceup() and c:GetAttack()>0
end
function c513000085.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and c513000085.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 
		and Duel.IsExistingTarget(c513000085.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,2,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c513000085.filter,tp,LOCATION_REMOVED,LOCATION_REMOVED,2,2,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,g:GetSum(Card.GetAttack))
end
function c513000085.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<2 then return end
	if g:GetCount()==2 then
		local sum=g:GetSum(Card.GetAttack)
		Duel.Damage(1-tp,sum,REASON_EFFECT)
	end
end
