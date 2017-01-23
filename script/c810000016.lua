-- Cut-In Shark
-- scripted by: UnknownGuest
function c810000016.initial_effect(c)
	-- Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000016,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c810000016.condition)
	e1:SetTarget(c810000016.target)
	e1:SetOperation(c810000016.activate)
	c:RegisterEffect(e1)
end
function c810000016.cfilter(e,c)
	return Duel.GetAttackTarget()
end
function c810000016.condition(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsControler(tp)
end
function c810000016.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local g=eg:Filter(c810000016.cfilter,nil)
	Duel.SetTargetCard(g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c810000016.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS):Filter(Card.IsRelateToEffect,nil,e)
	if g:GetCount()==0 then return end
	if c:IsRelateToEffect(e) then
		Duel.Release(g,REASON_COST)
		Duel.SpecialSummon(c,1,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
