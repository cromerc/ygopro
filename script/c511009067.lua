--Wings of the Supreme King
function c511009067.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511009067.target)
	e1:SetOperation(c511009067.operation)
	c:RegisterEffect(e1)
	--cannot be destroyed (monster)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot be destroyed
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	--Equip limit
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_EQUIP_LIMIT)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetValue(c511009067.eqlimit)
	c:RegisterEffect(e4)
	--damage
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DAMAGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLE_DESTROYING)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511009067.damcon)
	e5:SetCost(c511009067.damcost)
	e5:SetTarget(c511009067.damtg)
	e5:SetOperation(c511009067.damop)
	c:RegisterEffect(e5)
	--destroy
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e6:SetCode(EVENT_LEAVE_FIELD)
	e6:SetCondition(c511009067.descon)
	e6:SetTarget(c511009067.destg)
	e6:SetOperation(c511009067.desop)
	c:RegisterEffect(e6)
	--disable summon
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCode(EFFECT_CANNOT_SUMMON)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetTargetRange(1,0)
	c:RegisterEffect(e7)
	local e8=e7:Clone()
	e8:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	c:RegisterEffect(e8)
end
function c511009067.eqlimit(e,c)
	return c:IsRace(RACE_DRAGON) and c:GetSummonLocation()==LOCATION_EXTRA
end
function c511009067.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:GetSummonLocation()==LOCATION_EXTRA
end
function c511009067.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511009067.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511009067.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511009067.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511009067.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,e:GetHandler(),tc)
	end
end

function c511009067.damcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=eg:GetFirst()
	local bc=ec:GetBattleTarget()
	return e:GetHandler():GetEquipTarget()==ec and ec:IsControler(tp)
		and bc:GetPreviousControler()==1-tp and bc:IsReason(REASON_BATTLE)
end
function c511009067.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(511009067)==0 end
	e:GetHandler():RegisterFlagEffect(511009067,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE,0,1)
end
function c511009067.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local ec=e:GetHandler():GetEquipTarget()
	local bc=ec:GetBattleTarget()
	local dam=bc:GetPreviousAttackOnField()
	if dam<0 then dam=0 end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c511009067.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c511009067.descon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=c:GetPreviousEquipTarget()
	return c:IsReason(REASON_LOST_TARGET) and ec:IsReason(REASON_BATTLE)
end
function c511009067.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetPreviousEquipTarget()
	local rc=ec:GetReasonCard()
	if chk==0 then return rc and rc:IsDestructable() end
	Duel.SetTargetCard(rc)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,rc,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,rc:GetAttack())
end
function c511009067.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local atk=tc:GetAttack()
		if atk<0 or tc:IsFacedown() then atk=0 end
		if Duel.Destroy(tc,REASON_EFFECT)~=0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
	end
end
