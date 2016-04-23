--Name of a Friend
function c511000045.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetHintTiming(0,TIMING_MAIN_END)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000045.target)
	e1:SetOperation(c511000045.activate)
	c:RegisterEffect(e1)
end
function c511000045.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER)
end
function c511000045.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:GetLocation()==LOCATION_GRAVE and chkc:GetControler()==1-tp end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c511000045.filter,tp,0,LOCATION_GRAVE,1,nil,e,0,tp,false,false)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,511000045,0,0x11,0,0,4,RACE_SPELLCASTER,ATTRIBUTE_LIGHT) end
	local g=Duel.SelectTarget(tp,c511000045.filter,tp,0,LOCATION_GRAVE,1,1,nil,e,0,tp,false,false)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c511000045.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) then return end
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,511000045,0,0x11,0,0,1,RACE_SPELLCASTER,ATTRIBUTE_LIGHT) then return end
	c:AddTrapMonsterAttribute(TYPE_NORMAL,ATTRIBUTE_LIGHT,RACE_SPELLCASTER,1,0,0)
	Duel.SpecialSummon(c,0,tp,tp,true,false,POS_FACEUP_DEFENCE)
	c:TrapMonsterBlock()
	local code=tc:GetOriginalCode()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetCode(EFFECT_CHANGE_CODE)
	e1:SetValue(code)
	c:RegisterEffect(e1)
end
