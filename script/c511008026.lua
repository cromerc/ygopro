--Granel Top 5
--Scripted by Snrk
function c511008026.initial_effect(c)
	--self destruction
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c511008026.sdcon)
	c:RegisterEffect(e1)
	--equip
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c511008026.eqcon)
	e2:SetOperation(c511008026.eqop)
	c:RegisterEffect(e2)
end
--self destruction
function c511008026.cfil(c)
	return c:IsFaceup() and (c:IsCode(100000050) or c:IsCode(100000056) or c:IsCode(100000061))
end
function c511008026.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c511008026.cfil,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
--equip
function c511008026.eqfil1(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO) and c:IsAbleToChangeControler()
end
function c511008026.eqfil2(c)
	return c:IsFaceup() and c:IsCode(100000050) or c:IsCode(100000056) or c:IsCode(100000061)
end
function c511008026.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingTarget(c511008026.eqfil1,tp,0,LOCATION_MZONE,1,nil)
	and Duel.IsExistingTarget(c511008026.eqfil2,tp,LOCATION_MZONE,0,1,nil)
	and Duel.GetLocationCount(tp,LOCATION_SZONE)>0
end
function c511008026.eqlimit(e,c)
	return not c:IsDisabled()
end
function c511008026.eqop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local eqg=Duel.SelectMatchingCard(tp,c511008026.eqfil2,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local eqtgc=Duel.SelectMatchingCard(tp,c511008026.eqfil1,tp,0,LOCATION_MZONE,1,1,nil)
	if not eqg or not eqtgc then return end
	local eqc=eqg:GetFirst()
	local eqtg=eqtgc:GetFirst()
	if eqtg:IsFaceup() and eqtg:IsType(TYPE_MONSTER) then
		if eqc:IsFaceup() then
			if not Duel.Equip(tp,eqtg,eqc,false) then return end
			--add equip limit
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511008026.eqlimit)
			eqtg:RegisterEffect(e1)
		else Duel.SendtoGrave(eqtg,REASON_EFFECT) end
	end
end