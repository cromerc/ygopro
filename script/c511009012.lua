--Eva Epsilon
function c511009012.initial_effect(c)
	--Give Counter
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39892082,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCondition(c511009012.damcon)
	e2:SetOperation(c511009012.damop)
	c:RegisterEffect(e2)
end

function c511009012.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ct=c:GetCounter(0x1109)
	e:SetLabel(ct)
	return ct>0 and c:IsLocation(LOCATION_GRAVE)
end
function c511009012.damop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()==0 then return end
	for i=1,ct do
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(83604828,1))
		local tc=g:Select(tp,1,1,nil):GetFirst()
		tc:AddCounter(0x1109,1)
	end
end
