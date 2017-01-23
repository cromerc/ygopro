-- Offside Trap
-- scripted by: UnknownGuest
function c810000058.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANOUNCE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c810000058.condition)
	e1:SetTarget(c810000058.target)
	e1:SetOperation(c810000058.activate)
	c:RegisterEffect(e1)
end
function c810000058.filter(c,e,tp)
	return c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) and c:GetPreviousControler()==tp and c:IsReason(REASON_BATTLE)
		and c:IsCanBeEffectTarget(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c810000058.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c==nil then return true end
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_SZONE,0)==1
end
function c810000058.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return eg:IsContains(chkc) and c810000058.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and eg:IsExists(c810000058.filter,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=eg:FilterSelect(tp,c810000058.filter,1,1,nil,e,tp)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c810000058.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,0)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
		Duel.BreakEffect()
		local turnp=Duel.GetTurnPlayer()
		Duel.SkipPhase(turnp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
		Duel.SkipPhase(turnp,PHASE_BATTLE,RESET_PHASE+PHASE_END,1,1)
		Duel.SkipPhase(turnp,PHASE_MAIN2,RESET_PHASE+PHASE_END,1)
	end
end
