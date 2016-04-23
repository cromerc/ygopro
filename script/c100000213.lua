--ギミックパペット－シザー・アーム
function c100000213.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)	
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100000213.con)
	e1:SetOperation(c100000213.activate)
	c:RegisterEffect(e1)
end
function c100000213.costfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_EQUIP) and c:IsAbleToGrave() and c:IsDestructable()
end
function c100000213.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c100000213.costfilter,tp,LOCATION_SZONE,0,1,nil) 
end
function c100000213.activate(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000213.costfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000213.costfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.Destroy(g,REASON_EFFECT)
	local c=e:GetHandler()
	local tc=g:GetFirst()
	if tc:IsLocation(LOCATION_GRAVE) then
		if c:IsFaceup() then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(c:GetLevel()*2)			
			e1:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e1)
		end
	end
end
