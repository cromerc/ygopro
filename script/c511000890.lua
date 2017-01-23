--Cell Division
function c511000890.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000890.target)
	e1:SetOperation(c511000890.activate)
	c:RegisterEffect(e1)
end
function c511000890.filter(c,e,tp)
	return c:IsFaceup() and c:IsLevelBelow(3) and c:IsRace(RACE_INSECT)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000891,0,0x4011,c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalLevel(),c:GetOriginalRace(),c:GetOriginalAttribute())
end
function c511000890.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c511000890.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511000890.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000890.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000890.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,511000891,0,0x4011,tc:GetBaseAttack(),tc:GetBaseDefense(),
			tc:GetOriginalLevel(),tc:GetOriginalRace(),tc:GetOriginalAttribute()) then return end
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local token=Duel.CreateToken(tp,511000891)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(tc:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(tc:GetBaseDefense())
	token:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetValue(tc:GetOriginalLevel())
	token:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RACE)
	e4:SetValue(tc:GetOriginalRace())
	token:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e5:SetValue(tc:GetOriginalAttribute())
	token:RegisterEffect(e5)
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
