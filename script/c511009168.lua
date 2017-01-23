--Delay Armor
function c511009168.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009168.target)
	e1:SetOperation(c511009168.operation)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511009168.eqlimit)
	c:RegisterEffect(e3)
	
	
	--cannot destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(75886890,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_EQUIP)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511009168.eqcon)
	e2:SetCost(c511009168.eqcost)
	e2:SetOperation(c511009168.eqop)
	c:RegisterEffect(e2)
	
	--handes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(12174035,0))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCategory(CATEGORY_TOGRAVE)
	e3:SetCode(EVENT_BATTLE_DESTROYING)
	e3:SetCondition(c511009168.hdcon)
	e3:SetTarget(c511009168.hdtg)
	e3:SetOperation(c511009168.hdop)
	c:RegisterEffect(e3)
	
end
function c511009168.eqlimit(e,c)
	return c:IsSetCard(0xc008)
end
function c511009168.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xc008)
end
function c511009168.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c511009168.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009168.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511009168.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511009168.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end


function c511009168.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetEquipTarget()
end
function c511009168.eqcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	e:SetLabelObject(e:GetHandler():GetEquipTarget())
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511009168.eqop(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetLabelObject()
	if ec and ec:IsFaceup() and ec:IsLocation(LOCATION_MZONE) then
		Duel.BreakEffect()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		ec:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		ec:RegisterEffect(e2)
	end
end

--destroy and damage
function c511009168.hdcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:GetFirst()==e:GetHandler():GetEquipTarget() and eg:GetFirst():IsStatus(STATUS_OPPO_BATTLE)
end
function c511009168.desfilter(c,lvl)
	return c:IsFaceup() and c:IsLevelBelow(lvl) and c:IsDestructable()
end
function c511009168.hdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local lvl=e:GetHandler():GetEquipTarget():GetBattleTarget():GetLevel()
	if chk==0 then return Duel.IsExistingMatchingCard(c511009168.desfilter,tp,0,LOCATION_MZONE,1,nil,lvl) end
	-- local g=Duel.GetMatchingGroup(c21313376.filter,tp,0,LOCATION_MZONE,nil,lvl)
	local tc=Duel.SelectTarget(tp,c511009168.desfilter,tp,0,LOCATION_MZONE,1,1,nil,lvl)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
end
function c511009168.hdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.Destroy(tc,REASON_EFFECT) then
		Duel.Damage(1-tp,500,REASON_EFFECT)
	end
end

