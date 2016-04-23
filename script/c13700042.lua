--Necloth Kaleidomirror
function c13700042.initial_effect(c)	
	aux.UnicoreK(c,aux.FilterBoolFunction(Card.IsCode,13700022))
	aux.BrionacK(c,aux.FilterBoolFunction(Card.IsCode,13700014))
	aux.GungnirK(c,aux.FilterBoolFunction(Card.IsCode,13700028))
	aux.ValkyrusK(c,aux.FilterBoolFunction(Card.IsCode,13700044))
	aux.TrishulaK(c,aux.FilterBoolFunction(Card.IsCode,13700003))
	--salvage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(13700005,2))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c13700042.condition)
	e1:SetCost(c13700042.cost)
	e1:SetTarget(c13700042.target2)
	e1:SetOperation(c13700042.operation2)
	c:RegisterEffect(e1)
	--Ritual Summon 3 The Necloth Unicore
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(13700042,0))
	e2:SetType(EFFECT_TYPE_ACTIVATE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetCountLimit(1,13700042)
	e2:SetCondition(c13700042.condition3unicore)
	e2:SetTarget(c13700042.target3unicore)
	e2:SetOperation(c13700042.activate3unicore)
	c:RegisterEffect(e2)
	--Ritual Summon 2 The Necloth Unicore
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(13700042,1))
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1,13700042)
	e3:SetCondition(c13700042.condition2unicore)
	e3:SetTarget(c13700042.target2unicore)
	e3:SetOperation(c13700042.activate2unicore)
	c:RegisterEffect(e3)
	--Ritual Summon 2 The Necloth Brionac
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(13700042,2))
	e4:SetType(EFFECT_TYPE_ACTIVATE)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetCountLimit(1,13700042)
	e4:SetCondition(c13700042.condition2brionac)
	e4:SetTarget(c13700042.target2brionac)
	e4:SetOperation(c13700042.activate2brionac)
	c:RegisterEffect(e4)
	--Ritual Summon 1 The Necloth Brionac and 1 The Necloth Unicore
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(13700042,3))
	e5:SetType(EFFECT_TYPE_ACTIVATE)
	e5:SetCode(EVENT_FREE_CHAIN)
	e5:SetCountLimit(1,13700042)
	e5:SetCondition(c13700042.condition1b1u)
	e5:SetTarget(c13700042.target1b1u)
	e5:SetOperation(c13700042.activate1b1u)
	c:RegisterEffect(e5)
	--Ritual Summon 1 The Necloth Gungnir and 1 The Necloth Unicore
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(13700042,4))
	e6:SetType(EFFECT_TYPE_ACTIVATE)
	e6:SetCode(EVENT_FREE_CHAIN)
	e6:SetCountLimit(1,13700042)
	e6:SetCondition(c13700042.condition1g1u)
	e6:SetTarget(c13700042.target1g1u)
	e6:SetOperation(c13700042.activate1g1u)
	c:RegisterEffect(e6)
	--Ritual Summon 1 The Necloth Gungnir and 1 The Necloth Unicore
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(13700042,5))
	e7:SetType(EFFECT_TYPE_ACTIVATE)
	e7:SetCode(EVENT_FREE_CHAIN)
	e7:SetCountLimit(1,13700042)
	e7:SetCondition(c13700042.condition1v1u)
	e7:SetTarget(c13700042.target1v1u)
	e7:SetOperation(c13700042.activate1v1u)
	c:RegisterEffect(e7)
	local e8=Effect.CreateEffect(c)
	e8:SetDescription(aux.Stringid(13700042,6))
	e8:SetType(EFFECT_TYPE_ACTIVATE)
	e8:SetCode(EVENT_FREE_CHAIN)
	e8:SetCountLimit(1,13700042)
	e8:SetCondition(c13700042.condition8)
	e8:SetTarget(c13700042.target8)
	e8:SetOperation(c13700042.activate8)
	c:RegisterEffect(e8)
end
	--Ritual Summon 3 The Necloth Unicore
function c13700042.cfilter3unicore(c)
	return c:GetLevel()==12
end
function c13700042.condition3unicore(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter3unicore,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter3unicore(c,e,tp)
	return c:IsCode(13700022) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target3unicore(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13700042.filter3unicore,tp,LOCATION_HAND,0,3,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13700042.activate3unicore(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter3unicore,tp,LOCATION_HAND,0,3,3,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter3unicore,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end
	--Ritual Summon 2 The Necloth Unicore
function c13700042.cfilter2unicore(c)
	return c:GetLevel()==8
end
function c13700042.condition2unicore(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter2unicore,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter2unicore(c,e,tp)
	return c:IsCode(13700022) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target2unicore(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13700042.filter2unicore,tp,LOCATION_HAND,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13700042.activate2unicore(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter2unicore,tp,LOCATION_HAND,0,2,2,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter2unicore,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end
	--Ritual Summon 2 The Necloth Brionac
function c13700042.cfilter2brionac(c)
	return c:GetLevel()==12
end
function c13700042.condition2brionac(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter2brionac,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter2brionac(c,e,tp)
	return c:IsCode(13700014) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target2brionac(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c13700042.filter2brionac,tp,LOCATION_HAND,0,2,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13700042.activate2brionac(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter2brionac,tp,LOCATION_HAND,0,2,2,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter2brionac,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end
	--~ Ritual Summon 1 The Necloth Brionac and 1 The Necloth Unicore
function c13700042.cfilter1b1u(c)
	return c:GetLevel()==10
end
function c13700042.condition1b1u(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter1b1u,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter1b1u(c,e,tp)
	return c:IsCode(13700014) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.filter1b1u2(c,e,tp)
	return c:IsCode(13700022) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target1b1u(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c13700042.filter1b1u,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c13700042.filter1b1u2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13700042.activate1b1u(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter1b1u,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc2=Duel.SelectMatchingCard(tp,c13700042.filter1b1u2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter1b1u,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end
	--~ Ritual Summon 1 The Necloth Gungnir and 1 The Necloth Unicore
function c13700042.cfilter1g1u(c)
	return c:GetLevel()==11
end
function c13700042.condition1g1u(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter1g1u,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter1g1u(c,e,tp)
	return c:IsCode(13700028) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.filter1g1u2(c,e,tp)
	return c:IsCode(13700022) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target1g1u(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c13700042.filter1g1u,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c13700042.filter1g1u2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13700042.activate1g1u(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter1g1u,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc2=Duel.SelectMatchingCard(tp,c13700042.filter1g1u2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter1g1u,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end
	
	--~ Ritual Summon 1 The Necloth Gungnir and 1 The Necloth Unicore
function c13700042.cfilter1v1u(c)
	return c:GetLevel()==12
end
function c13700042.condition1v1u(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter1v1u,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter1v1u(c,e,tp)
	return c:IsCode(13700044) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.filter1v1u2(c,e,tp)
	return c:IsCode(13700022) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target1v1u(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and Duel.IsExistingMatchingCard(c13700042.filter1v1u,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.IsExistingMatchingCard(c13700042.filter1v1u2,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c13700042.activate1v1u(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter1v1u,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local tc2=Duel.SelectMatchingCard(tp,c13700042.filter1v1u2,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter1v1u,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		Duel.SpecialSummon(tc2,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end	
	

--~ Summon Brionac
function c13700042.bmtfilter(c,e)
	return (c:GetCode()~=13700014 and c:GetLevel()>0 and c:IsLocation(LOCATION_MZONE+LOCATION_HAND+LOCATION_EXTRA))
	or ( c:IsSetCard(0x606d) and c:GetLevel()>0 and c:IsAbleToRemove() and c:IsLocation(LOCATION_GRAVE))
end
function c13700042.bspfilter(c,e,tp,m)
	return c:IsCode(13700014) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
		and m:CheckWithSumEqual(Card.GetRitualLevel,c:GetLevel(),1,1,c)
end
function c13700042.btarget(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c13700042.bmtfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_EXTRA+LOCATION_MZONE,0,e:GetHandler(),e)
		return Duel.IsExistingMatchingCard(c13700042.bspfilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_EXTRA)
end
function c13700042.bactivate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local mg=Duel.GetMatchingGroup(c13700042.bmtfilter,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_EXTRA+LOCATION_MZONE,0,nil,e)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c13700042.bspfilter,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,1,nil,e,tp,mg)
	local tc=g:GetFirst()
		if tc then
		mg:RemoveCard(tc)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
		local mat=mg:SelectWithSumEqual(tp,Card.GetRitualLevel,tc:GetLevel(),1,1,tc)
		tc:SetMaterial(mat)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.BreakEffect()
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
		tc:CompleteProcedure()
	end
end
--~ Savage
function c13700042.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c13700042.filter2(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemove()
end
function c13700042.cost(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c13700042.filter2,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	local g=Duel.SelectMatchingCard(tp,c13700042.filter2,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c13700042.sfilter(c)
	return c:IsSetCard(0x1373) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c13700042.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c13700042.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c13700042.operation2(e,tp,eg,ep,ev,re,r,rp,chk)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c13700042.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c13700042.cfilter8(c)
	return (c:GetCode()~=13700022 and c:GetLevel()==4 and c:IsLocation(LOCATION_MZONE+LOCATION_HAND+LOCATION_EXTRA))
end
function c13700042.condition8(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c13700042.cfilter8,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,nil)
end
function c13700042.filter8(c,e,tp)
	return c:IsCode(13700022) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_RITUAL,tp,true,false)
end
function c13700042.target8(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end
		local mg=Duel.GetMatchingGroup(c13700042.filter8,tp,LOCATION_GRAVE+LOCATION_HAND+LOCATION_EXTRA+LOCATION_MZONE,0,e:GetHandler(),e)
		return Duel.IsExistingMatchingCard(c13700042.filter8,tp,LOCATION_HAND+LOCATION_EXTRA,0,1,nil,e,tp,mg)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND+LOCATION_EXTRA)
end
function c13700042.activate8(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.SelectMatchingCard(tp,c13700042.filter8,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local mat=Duel.SelectMatchingCard(tp,c13700042.cfilter8,tp,LOCATION_MZONE+LOCATION_EXTRA+LOCATION_HAND,0,1,1,nil)
		Duel.ReleaseRitualMaterial(mat)
		Duel.SendtoGrave(mat,REASON_EFFECT)
		Duel.SpecialSummon(tc,SUMMON_TYPE_RITUAL,tp,tp,true,false,POS_FACEUP)
end