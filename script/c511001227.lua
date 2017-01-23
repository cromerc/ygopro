--Guardraw
function c511001227.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001227.target)
	e1:SetOperation(c511001227.activate)
	c:RegisterEffect(e1)
end
function c511001227.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,tp,LOCATION_MZONE,0,1,nil,POS_FACEUP_ATTACK) end
	local g=Duel.GetMatchingGroup(Card.IsPosition,tp,LOCATION_MZONE,0,nil,POS_FACEUP_ATTACK)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,1)
end
function c511001227.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUPATTACK)
	local g=Duel.SelectMatchingCard(tp,Card.IsPosition,tp,LOCATION_MZONE,0,1,1,nil,POS_FACEUP_ATTACK)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
		Duel.Draw(tp,1,REASON_EFFECT)	
	end
end
