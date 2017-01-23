--Dramatic Crossroads
function c511000318.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_HANDES)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511000318.condition)
	e1:SetTarget(c511000318.target)
	e1:SetOperation(c511000318.activate)
	c:RegisterEffect(e1)
end
function c511000318.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c511000318.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
end
function c511000318.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local op=Duel.SelectOption(1-tp,aux.Stringid(511000318,0),aux.Stringid(511000318,1))
	if op==0 then
		local sg=g:RandomSelect(1-tp,1)
		Duel.SendtoGrave(sg,REASON_EFFECT+REASON_DISCARD)
	else
		local g=Duel.GetMatchingGroup(nil,tp,0,LOCATION_HAND,nil)
		Duel.ConfirmCards(tp,g)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg:GetFirst(),tp,REASON_EFFECT)
		Duel.ShuffleHand(1-tp)
	end
end
