--Magic King Moon Star
function c511000761.initial_effect(c)
	--change lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000761,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511000761.tg)
	e1:SetOperation(c511000761.op)
	c:RegisterEffect(e1)
end
function c511000761.filter(c,lv)
	return c:IsFaceup() and c:GetLevel()~=lv
end
function c511000761.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=e:GetHandler():GetLevel()
	if chk==0 then return Duel.IsExistingMatchingCard(c511000761.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,lv) end
end
function c511000761.op(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetHandler():GetLevel()
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectMatchingCard(tp,c511000761.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,lv):GetFirst()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
