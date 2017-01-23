--Goyo Arrow
function c511002224.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002224.target)
	e1:SetOperation(c511002224.operation)
	c:RegisterEffect(e1)
	--equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c511002224.eqlimit)
	c:RegisterEffect(e2)
	--damage
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_DAMAGE)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTarget(c511002224.damtg)
	e4:SetOperation(c511002224.damop)
	c:RegisterEffect(e4)
end
function c511002224.eqlimit(e,c)
	return c:IsSetCard(0x204) or c:IsCode(7391448) or c:IsCode(63364266) or c:IsCode(98637386) or c:IsCode(84305651) 
		or c:IsCode(58901502) or c:IsCode(59255742)
end
function c511002224.filter(c)
	return c:IsFaceup() and (c:IsSetCard(0x204) or c:IsCode(7391448) or c:IsCode(63364266) or c:IsCode(98637386) or c:IsCode(84305651) 
		or c:IsCode(58901502) or c:IsCode(59255742))
end
function c511002224.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(c511002224.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511002224.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511002224.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if e:GetHandler():IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end
function c511002224.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetEquipTarget()
	if chk==0 then return ec and ec:GetLevel()>0 end
	local lv=ec:GetLevel()
	local dam=lv*100
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511002224.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local ec=e:GetHandler():GetEquipTarget()
	if not ec then return end
	local dam=ec:GetLevel()*100
	Duel.Damage(p,dam,REASON_EFFECT)
end
