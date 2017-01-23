--No.66 覇鍵甲虫マスター・キー・ビートル
function c511002749.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),4,2)
	c:EnableReviveLimit()
	--target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(76067258,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCost(c511002749.cost)
	e1:SetTarget(c511002749.target)
	e1:SetOperation(c511002749.operation)
	c:RegisterEffect(e1)
	--desrep
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c511002749.reptg)
	c:RegisterEffect(e3)
	--battle indestructable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e4:SetValue(c511002749.indes)
	c:RegisterEffect(e4)
	if not c511002749.global_check then
		c511002749.global_check=true
		--register
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511002749.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511002749.xyz_number=66
function c511002749.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511002749.filter(c,ec)
	return not ec:IsHasCardTarget(c)
end
function c511002749.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c511002749.filter(chkc,c) end
	if chk==0 then return Duel.IsExistingTarget(c511002749.filter,tp,LOCATION_ONFIELD,0,1,nil,c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511002749.filter,tp,LOCATION_ONFIELD,0,1,1,nil,c)
end
function c511002749.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		tc:RegisterFlagEffect(76067258,RESET_EVENT+0x1fe0000,0,0)
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			c:SetCardTarget(tc)
			--indes
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
			e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
			e2:SetValue(1)
			e2:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e2)
		end
	end
end
function c511002749.repfilter(c,tp)
	return c:IsControler(tp) and c:GetFlagEffect(76067258)~=0
end
function c511002749.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetCardTarget():IsExists(c511002749.repfilter,1,nil,tp) end
	if Duel.SelectYesNo(tp,aux.Stringid(76067258,1)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=e:GetHandler():GetCardTarget():FilterSelect(tp,c511002749.repfilter,1,1,nil,tp)
		Duel.SendtoGrave(g,REASON_EFFECT)
		return true
	else return false end
end
function c511002749.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,76067258)
	Duel.CreateToken(1-tp,76067258)
end
function c511002749.indes(e,c)
	return not c:IsSetCard(0x48)
end
