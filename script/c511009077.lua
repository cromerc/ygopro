--Performapal Allcover Hippo
function c511009077.initial_effect(c)
		--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(96606246,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511009077.sptg)
	e1:SetOperation(c511009077.spop)
	c:RegisterEffect(e1)
	
		--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(47829960,0))
	e2:SetCategory(CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c511009077.target)
	e2:SetOperation(c511009077.operation)
	c:RegisterEffect(e2)
end
function c511009077.filter(c,e,tp)
	return c:IsSetCard(0x9f)  and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		
end
function c511009077.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511009077.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511009077.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511009077.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end


function c511009077.posfilter(c)
	return c:IsFaceup() and c:IsAttackPos()
end
function c511009077.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(c511009077.posfilter,tp,LOCATION_MZONE,0,1,nil) end
	local g=Duel.GetMatchingGroup(c511009077.posfilter,tp,LOCATION_MZONE,0,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c511009077.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511009077.posfilter,tp,LOCATION_MZONE,0,nil)
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
end
