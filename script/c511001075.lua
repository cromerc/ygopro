--Xyz Plant
function c511001075.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001075.target)
	e1:SetOperation(c511001075.activate)
	c:RegisterEffect(e1)
end
function c511001075.filter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511001075.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511001075.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c511001075.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001075,0,0x21,0,0,nil,RACE_PLANT,ATTRIBUTE_EARTH) end
	local g=Duel.SelectTarget(tp,c511001075.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511001075.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001075,0,0x11,0,0,1,RACE_PLANT,ATTRIBUTE_EARTH) then return end
	c:AddMonsterAttribute(TYPE_EFFECT+TYPE_SPELL+TYPE_TRAP)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP)
	c:AddMonsterAttributeComplete()
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_SINGLE)
	e0:SetCode(EFFECT_CHANGE_LEVEL)
	e0:SetValue(c511001075.value)
	e0:SetLabelObject(tc)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e0)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UNRELEASABLE_SUM)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EFFECT_CANNOT_BE_FUSION_MATERIAL)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e3:SetValue(1)
	c:RegisterEffect(e3)
	local e4=e3:Clone()
	e4:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_ATTACK)
	e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e5:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e6:SetReset(RESET_EVENT+0x1fe0000)
	e6:SetCode(EFFECT_REMOVE_TYPE)
	e6:SetValue(TYPE_TRAP)
	c:RegisterEffect(e6)
end
function c511001075.value(e,c)
	local tc=e:GetLabelObject()
	if tc:IsLocation(LOCATION_MZONE) then
		return tc:GetLevel()
	else
		return 0
	end
end
