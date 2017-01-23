--ＳｐTune Up 123
function c511000944.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000944.con)
	e1:SetTarget(c511000944.target)
	e1:SetOperation(c511000944.activate)
	c:RegisterEffect(e1)
end
function c511000944.con(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFieldCard(e:GetHandler():GetControler(),LOCATION_SZONE,5)
	return tc and tc:GetCounter(0x91)>1
end
function c511000944.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c511000944.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000944.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000944.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000944.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c511000944.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local d=Duel.TossDice(tp,1)
		local lv=0
		if d==1 or d==2 then
			lv=1
		elseif d==3 or d==4 then
			lv=2
		else
			lv=3
		end
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(lv)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		tc:RegisterEffect(e1)
	end
end
