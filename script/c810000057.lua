--星屑の残光
-- scripted by: UnknownGuest
function c810000057.initial_effect(c)
	-- Special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(810000057,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c810000057.condition)
	e1:SetTarget(c810000057.target)
	e1:SetOperation(c810000057.activate)
	c:RegisterEffect(e1)
	if not c810000057.global_check then
		c810000057.global_check=true
		c810000057[0]=true
		c810000057[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetOperation(c810000057.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c810000057.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c810000057.filter(c,e,tp)
	return c:IsCode(44508094) and c:IsCanBeSpecialSummoned(e,0,tp,true,true)
end
function c810000057.condition(e,tp,eg,ep,ev,re,r,rp,chk)
	return c810000057[tp]
end
function c810000057.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c810000057.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c810000057.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c810000057.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c810000057.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SpecialSummon(tc,0,tp,tp,true,true,POS_FACEUP)
	end
end
function c810000057.checkop(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsCode(44508094) then
		c810000057[re:GetHandler():GetPreviousControler()]=true
	end
end
function c810000057.clear(e,tp,eg,ep,ev,re,r,rp)
	c810000057[0]=false
	c810000057[1]=false
end
