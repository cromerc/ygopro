--Claret Note
function c511001329.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0)
	e1:SetTarget(c511001329.target)
	e1:SetOperation(c511001329.activate)
	c:RegisterEffect(e1)
end
function c511001329.cfilter(c,tp)
	local lv=c:GetLevel()
	return c:IsFaceup() and lv>=4 and Duel.GetLocationCount(tp,LOCATION_MZONE)>(math.floor(lv/4)-1)
end
function c511001329.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c511001329.cfilter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001329.cfilter,tp,0,LOCATION_MZONE,1,nil,tp) 
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511001330,0,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_DARK) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectTarget(tp,c511001329.cfilter,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001329.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local lv=tc:GetLevel()
	if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=(math.floor(lv/4)-1)
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511001330,0,0x4011,0,0,1,RACE_WARRIOR,ATTRIBUTE_DARK) then return end
	for i=1,math.floor(lv/4) do
		local token=Duel.CreateToken(tp,511001330)
		Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	end
	Duel.SpecialSummonComplete()
end
