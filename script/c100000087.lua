--チェーン・リゾネーター
function c100000087.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000087,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c100000087.spcon)
	e1:SetTarget(c100000087.sumtg)
	e1:SetOperation(c100000087.sumop)
	c:RegisterEffect(e1)
end
function c100000087.sfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_SYNCHRO)
end
function c100000087.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000087.sfilter,e:GetHandler():GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingMatchingCard(c100000087.filter,e:GetHandler():GetControler(),LOCATION_DECK,0,1,nil,e,tp)
end
function c100000087.filter(c,e,tp)
	return c:IsSetCard(0x57) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000087.sumtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000087.filter,tp,LOCATION_DECK,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_DECK)
end
function c100000087.sumop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c100000087.filter,tp,LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end