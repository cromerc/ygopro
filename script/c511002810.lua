--モノマネンド
function c511002810.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002810.target)
	e1:SetOperation(c511002810.activate)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetCondition(c511002810.descon)
	e2:SetOperation(c511002810.desop)
	c:RegisterEffect(e2)
end
function c511002810.filter(c,e,tp)
	return c:IsLevelBelow(3) and c:IsAttackPos() 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetCode(),0,0x21,0,0,1,c:GetRace(),c:GetAttribute())
end
function c511002810.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511002810.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and e:IsHasType(EFFECT_TYPE_ACTIVATE) 
		and Duel.IsExistingTarget(c511002810.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACK)
	local g=Duel.SelectTarget(tp,c511002810.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511002810.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) or not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetCode(),0,0x21,0,0,1,tc:GetRace(),tc:GetAttribute()) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_SPELL+TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(tc:GetCode())
	c:RegisterEffect(e1)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RACE)
	e4:SetValue(tc:GetRace())
	c:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e5:SetValue(tc:GetAttribute())
	c:RegisterEffect(e5)
	local e6=e1:Clone()
	e6:SetCode(EFFECT_REMOVE_TYPE)
	e6:SetValue(TYPE_TRAP)
	c:RegisterEffect(e6)
	c:CopyEffect(tc:GetOriginalCode(),RESET_EVENT+0x1fe0000,1)
	c:SetCardTarget(tc)
end
function c511002810.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511002810.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
