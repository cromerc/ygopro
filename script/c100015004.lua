--100015004
function c100015004.initial_effect(c)
	--lvchange
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_LVCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c100015004.lvtg)
	e1:SetOperation(c100015004.lvop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--special summon
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCode(EVENT_REMOVE)
	e3:SetTarget(c100015004.target)
	e3:SetOperation(c100015004.operation)
	c:RegisterEffect(e3)
end
function c100015004.lvfilter(c,lv,code)
	return c:IsFaceup() and c:IsSetCard(0x400) and c:IsSetCard(0x45) and c:GetLevel()~=0
end
function c100015004.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100015004.lvfilter(chkc,e:GetHandler():GetLevel()) end
	if chk==0 then return Duel.IsExistingTarget(c100015004.lvfilter,tp,LOCATION_MZONE,0,1,e:GetHandler(),e:GetHandler():GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100015004.lvfilter,tp,LOCATION_MZONE,0,1,1,e:GetHandler(),e:GetHandler():GetLevel())
end
function c100015004.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LEVEL)
		e1:SetValue(tc:GetLevel()+c:GetLevel())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
function c100015004.filter(c,e,tp,llv)
	local lv=c:GetLevel()
	return lv>0 and (not llv or lv==llv) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c~=e:GetHandler()
end
function c100015004.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 then return false end
		if ft==1 then return Duel.IsExistingMatchingCard(c100015004.filter,tp,LOCATION_REMOVED,0,1,nil,e,tp,5)
		else
			local g=Duel.GetMatchingGroup(c100015004.filter,tp,LOCATION_REMOVED,0,nil,e,tp)
			return g:CheckWithSumEqual(Card.GetLevel,5,1,2)
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_REMOVED)
end
function c100015004.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)	
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	if ft==1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100015004.filter,tp,LOCATION_REMOVED,0,1,1,nil,e,tp,5)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	else
		local g=Duel.GetMatchingGroup(c100015004.filter,tp,LOCATION_REMOVED,0,nil,e,tp)
		if g:CheckWithSumEqual(Card.GetLevel,5,1,2) then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local sg=g:SelectWithSumEqual(tp,Card.GetLevel,5,1,2)
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
	Duel.BreakEffect()
	if g or sg then
		local dg=Duel.GetDecktopGroup(tp,1)
		local tc=dg:GetFirst()
		if not tc or not tc:IsAbleToRemove() then return end
		Duel.DisableShuffleCheck()
		Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)
	end	
end

