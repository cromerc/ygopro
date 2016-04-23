--Imitation
function c511000044.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000044.target)
	e1:SetOperation(c511000044.activate)
	c:RegisterEffect(e1)
end
function c511000044.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsOnField() and c511000001.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 end
	local g=Duel.SelectTarget(tp,Card.IsType,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,TYPE_TOKEN)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,tp,0)
end
function c511000044.activate(e,tp,eg,ep,ev,re,r,rp)
	local ec=Duel.GetFirstTarget()
	if not ec:IsRelateToEffect(e) or ec:IsFacedown() then return end
	if Duel.GetLocationCount(1-tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,500000148,0,0x4011,ec:GetBaseAttack(),ec:GetBaseDefence(),
			ec:GetOriginalLevel(),ec:GetOriginalRace(),ec:GetOriginalAttribute()) then return end
	ec:RegisterFlagEffect(500000148,RESET_EVENT+0x17a0000,0,0)
	local token=Duel.CreateToken(1-tp,500000148)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(ec:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENCE)
	e2:SetValue(ec:GetBaseDefence())
	token:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CHANGE_LEVEL)
	e3:SetValue(ec:GetOriginalLevel())
	token:RegisterEffect(e3)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CHANGE_RACE)
	e4:SetValue(ec:GetOriginalRace())
	token:RegisterEffect(e4)
	local e5=e1:Clone()
	e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	e5:SetValue(ec:GetOriginalAttribute())
	token:RegisterEffect(e5)
	Duel.SpecialSummon(token,0,tp,1-tp,false,false,POS_FACEUP)
	Duel.Damage(1-tp,ec:GetAttack()/2,REASON_EFFECT)
end