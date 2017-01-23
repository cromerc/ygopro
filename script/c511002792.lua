--Question Change
function c511002792.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(c511002792.condition)
	e1:SetTarget(c511002792.target)
	e1:SetOperation(c511002792.activate)
	c:RegisterEffect(e1)
end
function c511002792.condition(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local rc=re:GetHandler()
	return ep==tp and bit.band(r,REASON_EFFECT)~=0 and rc and rc:GetOwner()==tp and rc:IsSetCard(0x1213) 
		and ev>0
end
function c511002792.filter(c)
	return c:IsSetCard(0x1213) and c:IsFacedown()
end
function c511002792.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511002792.filter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511002792.filter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,1,0,0)
end
function c511002792.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SetLP(tp,Duel.GetLP(tp)+ev)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_POSCHANGE)
	local g=Duel.SelectMatchingCard(tp,c511002792.filter,tp,LOCATION_MZONE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		Duel.ChangePosition(g,0,POS_FACEUP_ATTACK,0,POS_FACEUP_DEFENSE)
	end
end
