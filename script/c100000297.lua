--エアロの爪
function c100000297.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000297.target)
	e1:SetOperation(c100000297.operation)
	c:RegisterEffect(e1)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(300)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c100000297.eqlimit)
	c:RegisterEffect(e3)
	--tograve replace
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EFFECT_SEND_REPLACE)
	e4:SetTarget(c100000297.reptg)
	e4:SetOperation(c100000297.repop)
	c:RegisterEffect(e4)
end
function c100000297.eqlimit(e,c)
	return c:IsCode(76812113)
end
function c100000297.filter(c)
	return c:IsFaceup() and c:IsCode(76812113)
end
function c100000297.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c100000297.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000297.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100000297.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000297.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c100000297.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local eq=e:GetHandler():GetEquipTarget()
	if chk==0 then return eq and c:GetDestination()==LOCATION_GRAVE 
		and Duel.IsExistingMatchingCard(c100000297.filter,tp,LOCATION_MZONE,0,1,eq) end
	if Duel.SelectYesNo(tp,aux.Stringid(100000297,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,c100000297.filter,tp,LOCATION_MZONE,0,1,1,eq)
		e:SetLabelObject(g:GetFirst())
		Duel.HintSelection(g)
		return true
	else return false end
end
function c100000297.repop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	Duel.Equip(tp,e:GetHandler(),tc)
end
