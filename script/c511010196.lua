--CNo.96 ブラック・ストーム (Anime)
function c511010196.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsAttribute,ATTRIBUTE_DARK),3,4)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511010196.rankupregcon)
	e1:SetOperation(c511010196.rankupregop)
	c:RegisterEffect(e1)
	--Share Battle Damage If Destroyed By Battle
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511010196.damcon)
	e2:SetOperation(c511010196.damop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511010196.indes)
	c:RegisterEffect(e6)
	if not c511010196.global_check then
		c511010196.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010196.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end

c511010196.xyz_number=96
function c511010196.rumfilter(c)
	return c:IsCode(55727845) and not c:IsPreviousLocation(LOCATION_OVERLAY)
end
function c511010196.rankupregcon(e,tp,eg,ep,ev,re,r,rp)
		local rc=re:GetHandler()
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ) and (rc:IsSetCard(0x95) or rc:IsCode(100000581) or rc:IsCode(111011002) or rc:IsCode(511000580) or rc:IsCode(511002068) or rc:IsCode(511002164) or rc:IsCode(93238626)) and e:GetHandler():GetMaterial():IsExists(c511010196.rumfilter,1,nil)
end
function c511010196.rankupregop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511010196,0))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511010196.atkcon)
	e3:SetCost(c511010196.atkcost)
	e3:SetTarget(c511010196.atktg)
	e3:SetOperation(c511010196.atkop)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e3)
end

function c511010196.negfilter1(c)
	return c:IsFaceup() and c:GetOriginalCode()==513000031 and not c:IsStatus(STATUS_DISABLED) 
end
function c511010196.negfilter2(c)
	return c:IsFaceup() and c:GetOriginalCode()==511001603 and not c:IsStatus(STATUS_DISABLED) 
end
function c511010196.damcon(e,tp,eg,ep,ev,re,r,rp)
local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if not bc then return false end
	if Duel.GetMatchingGroup(c511010196.negfilter1,tp,0,LOCATION_MZONE,nil):GetCount()==0 then
		if Duel.GetMatchingGroup(c511010196.negfilter2,tp,LOCATION_MZONE,LOCATION_MZONE,nil):GetCount()==0 then
			if not bc:IsCode(511012010) and (c:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>1 or (c:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)==1 and not (bc:IsSetCard(0x48) or c:IsStatus(STATUS_DISABLED)))) then return false end
		end
	end
	if c:IsAttackPos() and bc:IsAttackPos() and c:GetAttack()<=bc:GetAttack() then return true end
	if c:IsDefensePos() and c:GetDefense()<bc:GetAttack() then return true end
	return false
end
function c511010196.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(1-tp,ev,false)
end

function c511010196.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010196.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local c=e:GetHandler()
		local a=Duel.GetAttacker()
		local at=Duel.GetAttackTarget()
		return ((a==c and at and at:IsFaceup() and at:GetAttack()>0) or (at==c and a:GetAttack()>0))
			and not e:GetHandler():IsStatus(STATUS_CHAINING)
	end
	Duel.SetTargetCard(e:GetHandler():GetBattleTarget())
end
function c511010196.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() and tc:GetAttack()>0 then
		local atk=tc:GetBaseAttack()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetRange(LOCATION_MZONE)
		e2:SetCode(EFFECT_UPDATE_ATTACK)
		e2:SetValue(atk)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end
function c511010196.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,77205367)
	Duel.CreateToken(1-tp,77205367)
end
function c511010196.indes(e,c)
return not c:IsSetCard(0x48)
end