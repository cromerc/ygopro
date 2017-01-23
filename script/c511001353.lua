--Wild Half
function c511001353.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511001353.condition)
	e1:SetTarget(c511001353.target)
	e1:SetOperation(c511001353.activate)
	c:RegisterEffect(e1)
end
function c511001353.cfilter(c)
	return c:IsFaceup() and c:IsCode(86188410)
end
function c511001353.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c511001353.cfilter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c511001353.filter(c,tp)
	return c:IsFaceup() and c:GetLevel()>0
		and Duel.IsPlayerCanSpecialSummonMonster(1-tp,511001354,0,0x4011,c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute())
end
function c511001353.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001353.filter(chkc,tp) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and 
		Duel.IsExistingTarget(c511001353.filter,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511001353.filter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001353.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	local ea=Effect.CreateEffect(e:GetHandler())
	ea:SetType(EFFECT_TYPE_SINGLE)
	ea:SetCode(EFFECT_SET_BASE_ATTACK)
	ea:SetReset(RESET_EVENT+0x1fe000)
	ea:SetValue(tc:GetBaseAttack()/2)
	tc:RegisterEffect(ea)
	local ed=Effect.CreateEffect(e:GetHandler())
	ed:SetType(EFFECT_TYPE_SINGLE)
	ed:SetCode(EFFECT_SET_BASE_DEFENSE)
	ed:SetReset(RESET_EVENT+0x1fe000)
	ed:SetValue(tc:GetBaseDefense()/2)
	tc:RegisterEffect(ed)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(1-tp,511001354,0,0x4011,tc:GetAttack(),tc:GetDefense(),
			tc:GetLevel(),tc:GetRace(),tc:GetAttribute()) then return end
	local token=Duel.CreateToken(tp,511001354)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(tc:GetAttack())
	e1:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(tc:GetDefense())
	token:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetValue(tc:GetLevel())
	token:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RACE)
	e4:SetValue(tc:GetRace())
	token:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e5:SetValue(tc:GetAttribute())
	token:RegisterEffect(e5)
	Duel.SpecialSummon(token,0,1-tp,1-tp,false,false,POS_FACEUP)
	if not tc:IsType(TYPE_TRAPMONSTER) then
		token:CopyEffect(tc:GetCode(),RESET_EVENT+0x1fe0000,1)
	end	
end
