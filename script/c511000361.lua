--Twin Dragons
function c511000361.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000361.target)
	e1:SetOperation(c511000361.activate)
	c:RegisterEffect(e1)
end
function c511000361.filter(c,e,tp)
	return c:IsFaceup() and c:IsRace(RACE_DRAGON) and c:GetLevel()<=4 and Duel.IsExistingTarget(c511000361.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp,c:GetLevel())
end
function c511000361.spfilter(c,e,tp,lv)
	return c:IsRace(RACE_DRAGON) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()==lv
end
function c511000361.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and c511000361.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511000361.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
end
function c511000361.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	local g=Duel.SelectMatchingCard(tp,c511000361.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sp=Duel.SelectMatchingCard(tp,c511000361.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp,g:GetFirst():GetLevel())
		if sp:GetCount()~=0 then
			Duel.SpecialSummon(sp,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
