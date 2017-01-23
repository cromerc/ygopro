--Mud Max
function c511000484.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511000484.target)
	e1:SetOperation(c511000484.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511000484.eqlimit)
	c:RegisterEffect(e2)
	--equip effect
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(300)
	c:RegisterEffect(e3)
	--battle target
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511000484,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_BE_BATTLE_TARGET)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511000484.negcon)
	e4:SetCost(c511000484.negcost)
	e4:SetOperation(c511000484.negop)
	c:RegisterEffect(e4)
end
function c511000484.eqlimit(e,c)
	return c:IsCode(84327329)
end
function c511000484.filter(c)
	return c:IsFaceup() and c:IsCode(84327329)
end
function c511000484.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511000484.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000484.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511000484.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000484.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511000484.negcon(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local bt=eg:GetFirst()
	return bt==eq
end
function c511000484.negcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511000484.spfilter(c,e,tp)
	return c:GetLevel()<=4 and c:IsSetCard(0x3008) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000484.negop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateAttack() then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c511000484.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) then
			if Duel.SelectYesNo(tp,aux.Stringid(511000484,1)) then
				local g=Duel.SelectMatchingCard(tp,c511000484.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
				if g:GetCount()>0 then
					Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
				end
			end
		end
	end
end