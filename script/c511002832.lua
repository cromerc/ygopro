--One Hundred Thousand Gauss
function c511002832.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002832.condition)
	e1:SetTarget(c511002832.target)
	e1:SetOperation(c511002832.activate)
	c:RegisterEffect(e1)
end
function c511002832.cfilter(c,tpe)
	return c:IsFaceup() and c:IsType(tpe)
end
function c511002832.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511002832.cfilter,tp,LOCATION_MZONE,0,1,nil,0x20000000) 
		and Duel.IsExistingMatchingCard(c511002832.cfilter,tp,LOCATION_MZONE,0,1,nil,0x40000000)
end
function c511002832.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsPosition,tp,0,LOCATION_MZONE,1,nil,POS_FACEUP_DEFENSE) end
	local g=Duel.GetMatchingGroup(Card.IsPosition,tp,0,LOCATION_MZONE,nil,POS_FACEUP_DEFENSE)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511002832.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,Card.IsPosition,tp,0,LOCATION_MZONE,1,1,nil,POS_FACEUP_DEFENSE)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
		local e7=Effect.CreateEffect(e:GetHandler())
		e7:SetType(EFFECT_TYPE_SINGLE)
		e7:SetCode(EFFECT_UPDATE_ATTACK)
		e7:SetReset(RESET_EVENT+0x1fe0000)
		e7:SetValue(-800)
		tc:RegisterEffect(e7)
	end
end
