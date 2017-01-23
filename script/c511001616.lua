--Raptor's Ultimate Mace
function c511001616.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511001616.target)
	e1:SetOperation(c511001616.operation)
	c:RegisterEffect(e1)
	--Atk up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_EQUIP)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	--Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(c511001616.eqlimit)
	c:RegisterEffect(e3)
	--0 damage
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c511001616.atkcon)
	e4:SetOperation(c511001616.atkop)
	c:RegisterEffect(e4)
end
function c511001616.eqlimit(e,c)
	return c:IsSetCard(0xba)
end
function c511001616.filter(c)
	return c:IsFaceup() and c:IsSetCard(0xba)
end
function c511001616.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c511001616.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511001616.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511001616.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511001616.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c511001616.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=c:GetEquipTarget()
	local bc=eq:GetBattleTarget()
	if not bc or eq:GetEffectCount(EFFECT_INDESTRUCTABLE_BATTLE)>0 then return false end
	if eq:IsAttackPos() and bc:IsAttackPos() and eq:GetAttack()<=bc:GetAttack() then return true end
	if eq:IsDefensePos() and eq:GetDefense()<bc:GetAttack() then return true end
	return false
end
function c511001616.afilter(c)
	return c:IsSetCard(0x95) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c511001616.atkop(e,tp,eg,ep,ev,re,r,rp)
	local eq=e:GetHandler():GetEquipTarget()
	local g=Duel.GetMatchingGroup(c511001616.afilter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(984114,0)) then
		Duel.ChangeBattleDamage(eq:GetControler(),0)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
