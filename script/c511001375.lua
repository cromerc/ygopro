--Level Resist Wall
function c511001375.initial_effect(c)
	--Activate(summon)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetTarget(c511001375.target)
	e1:SetOperation(c511001375.activate)
	c:RegisterEffect(e1)
end
function c511001375.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001375.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local sg=Duel.GetMatchingGroup(c511001375.filter,tp,LOCATION_HAND,0,nil,e,tp)
	if chk==0 then return eg:GetCount()==1 and tc:GetLevel()>0 and tc:IsControler(tp)
		and ft>0 and sg:CheckWithSumEqual(Card.GetLevel,tc:GetLevel(),1,ft+1) end
	e:SetLabel(tc:GetLevel())
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001375.activate(e,tp,eg,ep,ev,re,r,rp)
	local lv=e:GetLabel()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	local sg=Duel.GetMatchingGroup(c511001375.filter,tp,LOCATION_HAND,0,nil,e,tp)
	if ft<=0 and not sg:CheckWithSumEqual(Card.GetLevel,tc:GetLevel(),1,ft+1) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sp=sg:SelectWithSumEqual(tp,Card.GetLevel,lv,1,ft+1)
	if sp:GetCount()>0 then
		Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
	end
end
