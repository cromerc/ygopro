--Tank Corps
function c511000881.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000881.target)
	e1:SetOperation(c511000881.operation)
	c:RegisterEffect(e1)
end
function c511000881.filter(c)
	return c:IsFaceup() and c:IsCode(511000880)
end
function c511000881.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511000881.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c511000881.filter,tp,LOCATION_MZONE,0,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>2
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000882,0,0x4011,800,1200,3,RACE_MACHINE,ATTRIBUTE_EARTH) 
		and not Duel.IsPlayerAffectedByEffect(tp,59822133) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c511000881.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,3,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,3,0,0)
end
function c511000881.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)>2 and not Duel.IsPlayerAffectedByEffect(tp,59822133) 
			and Duel.IsPlayerCanSpecialSummonMonster(tp,511000882,0,0x4011,800,1200,3,RACE_MACHINE,ATTRIBUTE_EARTH) then
			for i=1,3 do
				local token=Duel.CreateToken(tp,511000882)
				Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
			end
			Duel.SpecialSummonComplete()
		end
	end
end
