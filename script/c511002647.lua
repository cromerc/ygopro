--Mimic Hell Worm
function c511002647.initial_effect(c)
	--change lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000761,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c511002647.tg)
	e1:SetOperation(c511002647.op)
	c:RegisterEffect(e1)
end
function c511002647.filter(c,lv)
	return c:IsFaceup() and c:GetLevel()~=lv
end
function c511002647.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lv=e:GetHandler():GetLevel()
	if chk==0 then return Duel.IsExistingMatchingCard(c511002647.filter,tp,0,LOCATION_MZONE,1,nil,lv) end
end
function c511002647.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local lv=c:GetLevel()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,c511002647.filter,tp,0,LOCATION_MZONE,1,1,nil,lv)
	local tc=g:GetFirst()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end
