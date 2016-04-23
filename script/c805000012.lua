--アンブラル・グール
function c805000012.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(805000012,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c805000012.sptg)
	e1:SetOperation(c805000012.spop)
	c:RegisterEffect(e1)
end
function c805000012.filter(c,e,tp)
	return c:IsSetCard(0x85) and c:GetTextAttack()==0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c805000012.sptg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c805000012.filter,tp,LOCATION_HAND,0,1,nil,e,tp) 
		and e:GetHandler():GetAttack()>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c805000012.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c805000012.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SET_ATTACK)
	e3:SetValue(0)
	e3:SetReset(RESET_EVENT+0xfe0000)
	c:RegisterEffect(e3)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
end
