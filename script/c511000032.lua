--For Our Dreams
function c511000032.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000032.cost)
	e1:SetTarget(c511000032.target)
	e1:SetOperation(c511000032.activate)
	c:RegisterEffect(e1)
end
function c511000032.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,c511000032.filter,1,nil) end
	local g=Duel.SelectReleaseGroup(tp,c511000032.filter,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511000032.filter(c)
	return c:IsRace(RACE_WARRIOR) and Duel.IsExistingTarget(c511000032.filter2,c:GetControler(),LOCATION_MZONE,0,1,c)
end
function c511000032.filter2(c)
	return c:IsFaceup() and c:IsRace(RACE_WARRIOR)
end
function c511000032.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and chkc:IsRace(RACE_WARRIOR) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c511000032.filter2,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511000032.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end