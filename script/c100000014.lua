--無限光アイン・ソフ・オウル
function c100000014.initial_effect(c)
	--Activate to Grave
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetCondition(c100000014.condition1)
	e1:SetCost(c100000014.cost)
	e1:SetTarget(c100000014.target1)
	e1:SetOperation(c100000014.operation1)
	c:RegisterEffect(e1)
	--to Grave
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetHintTiming(0,TIMING_END_PHASE)
	e2:SetCondition(c100000014.condition1)
	e2:SetTarget(c100000014.target2)
	e2:SetOperation(c100000014.operation1)
	c:RegisterEffect(e2)
	--Activate special summon
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100000014,1))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e3:SetType(EFFECT_TYPE_ACTIVATE)
	e3:SetCode(EVENT_FREE_CHAIN)
	e3:SetCountLimit(1)
	e3:SetCondition(c100000014.condition2)
	e3:SetCost(c100000014.cost)
	e3:SetTarget(c100000014.target3)
	e3:SetOperation(c100000014.operation2)
	c:RegisterEffect(e3)
	--special summon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(100000014,1))
	e4:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetCountLimit(1)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCondition(c100000014.condition2)
	e4:SetTarget(c100000014.target4)
	e4:SetOperation(c100000014.operation2)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_TO_DECK)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(LOCATION_MZONE,0)
	e5:SetTarget(c100000014.tgn)
	c:RegisterEffect(e5)
	local e6=Effect.CreateEffect(c)
	e6:SetDescription(aux.Stringid(100000014,1))
	e6:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetCondition(c100000014.condition3)
	e6:SetTarget(c100000014.target5)
	e6:SetOperation(c100000014.operation3)
	c:RegisterEffect(e6)
end
function c100000014.condition1(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c100000014.costfilter(c)
	return c:IsFaceup() and c:GetCode()==100000013 and c:IsAbleToGraveAsCost()
end
function c100000014.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000014.costfilter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100000014.costfilter,tp,LOCATION_SZONE,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000014.rfilter(c)
	return c:IsSetCard(0x4a) and c:IsType(TYPE_MONSTER) and c:IsAbleToGrave()
end
function c100000014.target1(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c100000014.rfilter(chkc) end
	if chk==0 then return true end
	if Duel.IsExistingTarget(c100000014.rfilter,tp,LOCATION_HAND,0,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(100000014,0)) then
	local cg=Duel.SelectTarget(tp,c100000014.rfilter,tp,LOCATION_HAND,0,1,1,nil)
	if cg:GetCount()==0 then return end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SendtoGrave(cg,REASON_EFFECT+REASON_DISCARD)
	e:GetHandler():RegisterFlagEffect(100000014,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	else e:SetProperty(0) end
end
function c100000014.target2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_HAND) and chkc:IsControler(tp) and c100000014.rfilter(chkc) end
	if chk==0 then return e:GetHandler():GetFlagEffect(100000014)==0
		and Duel.IsExistingTarget(c100000014.rfilter,tp,LOCATION_HAND,0,1,nil) end
	local cg=Duel.SelectTarget(tp,c100000014.rfilter,tp,LOCATION_HAND,0,1,1,nil)
	if cg:GetCount()==0 then return end
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,0,tp,1)
	Duel.SendtoGrave(cg,REASON_EFFECT+REASON_DISCARD)
	e:GetHandler():RegisterFlagEffect(100000014,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
end
function c100000014.operation1(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISCARD)
	Duel.BreakEffect()
	Duel.Draw(tp,2,REASON_EFFECT)
end
function c100000014.condition2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function c100000014.filter(c,e,sp)
	return c:IsSetCard(0x4a) and c:IsCanBeSpecialSummoned(e,0,sp,false,false)
end
function c100000014.target3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end 
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and Duel.IsExistingMatchingCard(c100000014.filter,tp,LOCATION_HAND,0,1,nil,e,tp)
		and Duel.SelectYesNo(tp,aux.Stringid(100000014,0)) then
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
	else e:SetProperty(0) end
end
function c100000014.target4(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000014.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c100000014.operation2(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local gs=Duel.SelectMatchingCard(tp,c100000014.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if gs:GetCount()>0 then
		Duel.SpecialSummon(gs,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c100000014.condition3(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD) and e:GetHandler():IsPreviousPosition(POS_FACEUP)
end
function c100000014.tf1(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,true,false)	and (not c:IsLocation(LOCATION_GRAVE) or not c:IsHasEffect(EFFECT_NECRO_VALLEY))
	and c:IsCode(8967776)
end
function c100000014.target5(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	 and Duel.IsExistingMatchingCard(c100000014.tf1,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c100000014.operation3(e,tp,eg,ep,ev,re,r,rp)
	if chk==0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft<=0 then return end
	local tc1=Duel.SelectMatchingCard(tp,c100000014.tf1,tp,0x13,0,1,1,nil,e,tp)
	if tc1 then
		Duel.SpecialSummon(tc1,0,tp,tp,true,false,POS_FACEUP)
		Duel.ShuffleDeck(tp)
	end
end
function c100000014.tgn(e,c)
	return c:IsSetCard(0x4a)
end
