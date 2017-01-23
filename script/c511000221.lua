--Vessel of Illusion
function c511000221.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(c511000221.condition)
	e1:SetTarget(c511000221.target)
	e1:SetOperation(c511000221.operation)
	c:RegisterEffect(e1)
end
function c511000221.cfilter(c,tp)
	return c:GetPreviousControler()==tp and c:GetPreviousLocation()==LOCATION_MZONE 
		and bit.band(c:GetPreviousPosition(),POS_FACEUP)~=0 and c:IsType(TYPE_SPIRIT) and c:IsLocation(LOCATION_GRAVE)
end
function c511000221.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000221.cfilter,nil,tp)
	local tc=g:GetFirst()
	return g:GetCount()==1
end
function c511000221.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=eg:Filter(c511000221.cfilter,nil,tp)
	local ec=g:GetFirst()
	if chk==0 then return eg:IsExists(c511000221.cfilter,1,nil,tp) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000222,0,0x4011,ec:GetBaseAttack(),ec:GetBaseDefense(),
			ec:GetOriginalLevel(),ec:GetOriginalRace(),ec:GetOriginalAttribute()) end
	ec:CreateEffectRelation(e)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511000221.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511000221.cfilter,nil,tp)
	local ec=g:GetFirst()
	if not ec or not ec:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511000222,0,0x4011,ec:GetBaseAttack(),ec:GetBaseDefense(),
			ec:GetOriginalLevel(),ec:GetOriginalRace(),ec:GetOriginalAttribute()) then return end
	local token=Duel.CreateToken(tp,511000222)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_BASE_ATTACK)
	e1:SetValue(ec:GetBaseAttack())
	e1:SetReset(RESET_EVENT+0xfe0000)
	token:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_BASE_DEFENSE)
	e2:SetValue(ec:GetBaseDefense())
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
	Duel.SpecialSummon(token,0,tp,tp,false,false,POS_FACEUP)
end
