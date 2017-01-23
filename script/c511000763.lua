--Morph King Stygi-Cell
function c511000763.initial_effect(c)
	--change lv
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000763,0))
	e1:SetCategory(CATEGORY_LVCHANGE+CATEGORY_RECOVER)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c511000763.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511000763.op(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetHandler():GetLevel()
	local c=e:GetHandler()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local tc=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,c):GetFirst()
	if c:IsFaceup() and c:IsRelateToEffect(e) and tc then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		if lv~=tc:GetLevel() then
			if lv>tc:GetLevel() then
				local rec=(lv-tc:GetLevel())*200
				Duel.Recover(tp,rec,REASON_EFFECT)
			else
				local rec=(tc:GetLevel()-lv)*200
				Duel.Recover(tp,rec,REASON_EFFECT)
			end
		end
	end
end
