--Blocken
--scripted by: UnknownGuest
function c810000100.initial_effect(c)
	--change battle target
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000100,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BE_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c810000100.cbcon)
	e1:SetOperation(c810000100.cbop)
	c:RegisterEffect(e1)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(810000100,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetCondition(c810000100.condition)
	e2:SetTarget(c810000100.target)
	e2:SetOperation(c810000100.operation)
	c:RegisterEffect(e2)
end
function c810000100.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bt=eg:GetFirst()
	return c~=bt and bt:GetControler()==c:GetControler()
end
function c810000100.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(e:GetHandler())
end
function c810000100.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsLocation(LOCATION_DECK)
end
function c810000100.spfilter(c,e,tp)
	return c:IsCode(810000101) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c810000100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c810000100.spfilter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c810000100.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c810000100.spfilter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
