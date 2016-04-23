--グランド・コア
function c100000067.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_DESTROY)
	e1:SetCondition(c100000067.condition)
	e1:SetOperation(c100000067.operation)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c100000067.condition2)
	c:RegisterEffect(e2)
	--battle indes
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_COUNT)
	e3:SetCountLimit(1)
	e3:SetValue(c100000067.valcon)
	c:RegisterEffect(e3)
end
function c100000067.valcon(e,re,r,rp)
	return bit.band(r,REASON_BATTLE)~=0
end
function c100000067.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetReason(),0x41)==0x41
end
function c100000067.condition2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return bit.band(c:GetReason(),0x41)==0x41 and c:IsPreviousLocation(LOCATION_MZONE) and not c:IsPreviousPosition(POS_FACEUP)
end

function c100000067.tf(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,c:GetControler(),false,false)
	and not c:IsHasEffect(EFFECT_NECRO_VALLEY)
end
function c100000067.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.Destroy(sg,REASON_EFFECT)
	if Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)==5
		and	Duel.IsExistingMatchingCard(c100000067.tf,c:GetControler(),0x13,0,1,nil,100000061,e,c:GetControler())
		and	Duel.IsExistingMatchingCard(c100000067.tf,c:GetControler(),0x13,0,1,nil,100000062,e,c:GetControler())
		and	Duel.IsExistingMatchingCard(c100000067.tf,c:GetControler(),0x13,0,1,nil,100000063,e,c:GetControler())
		and	Duel.IsExistingMatchingCard(c100000067.tf,c:GetControler(),0x13,0,1,nil,100000064,e,c:GetControler())
		and	Duel.IsExistingMatchingCard(c100000067.tf,c:GetControler(),0x13,0,1,nil,100000065,e,c:GetControler())
	then
		Duel.BreakEffect()
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,c:GetControler(),0x13)
		Duel.Hint(HINT_SELECTMSG,c:GetControler(),HINTMSG_SPSUMMON)
		local tc1=Duel.SelectMatchingCard(c:GetControler(),c100000067.tf,c:GetControler(),0x13,0,1,1,nil,100000061,e,c:GetControler()):GetFirst()
		Duel.SpecialSummonStep(tc1,1,c:GetControler(),c:GetControler(),false,false,POS_FACEUP)
		local tc2=Duel.SelectMatchingCard(c:GetControler(),c100000067.tf,c:GetControler(),0x13,0,1,1,nil,100000062,e,c:GetControler()):GetFirst()
		Duel.SpecialSummonStep(tc2,0,c:GetControler(),c:GetControler(),false,false,POS_FACEUP)
		local tc3=Duel.SelectMatchingCard(c:GetControler(),c100000067.tf,c:GetControler(),0x13,0,1,1,nil,100000063,e,c:GetControler()):GetFirst()
		Duel.SpecialSummonStep(tc3,0,c:GetControler(),c:GetControler(),false,false,POS_FACEUP)
		local tc4=Duel.SelectMatchingCard(c:GetControler(),c100000067.tf,c:GetControler(),0x13,0,1,1,nil,100000064,e,c:GetControler()):GetFirst()
		Duel.SpecialSummonStep(tc4,0,c:GetControler(),c:GetControler(),false,false,POS_FACEUP)
		local tc5=Duel.SelectMatchingCard(c:GetControler(),c100000067.tf,c:GetControler(),0x13,0,1,1,nil,100000065,e,c:GetControler()):GetFirst()
		Duel.SpecialSummonStep(tc5,0,c:GetControler(),c:GetControler(),false,false,POS_FACEUP)
		Duel.ShuffleDeck(c:GetControler())
		Duel.SpecialSummonComplete()
	end
end
