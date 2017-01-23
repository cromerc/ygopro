--Damage Summon
function c511000841.initial_effect(c)
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000841,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DAMAGE_STEP_END)
	e1:SetCost(c511000841.atcost)
	e1:SetCondition(c511000841.atcon)
	e1:SetTarget(c511000841.attg)
	e1:SetOperation(c511000841.atop)
	c:RegisterEffect(e1)
end
function c511000841.atcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,800) end
	Duel.PayLPCost(tp,800)
end
function c511000841.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	local a=Duel.GetAttacker()
	return a:IsControler(tp) and at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED)
end
function c511000841.filter(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false) and c:GetLevel()<=4
end
function c511000841.attg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000841.filter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000841.atop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000841.filter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
