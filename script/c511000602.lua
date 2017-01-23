--Divination of Fate
function c511000602.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511000602.condition)
	e1:SetTarget(c511000602.target)
	e1:SetOperation(c511000602.activate)
	c:RegisterEffect(e1)
	if not c511000602.global_check then
		c511000602.global_check=true
		c511000602[0]=false
		c511000602[1]=false
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE_STEP_END)
		ge1:SetOperation(c511000602.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511000602.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000602.checkop(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	if at and at:IsRelateToBattle() and not at:IsStatus(STATUS_BATTLE_DESTROYED) then
		c511000602[0]=true
		c511000602[1]=true
	end
end
function c511000602.clear(e,tp,eg,ep,ev,re,r,rp)
	c511000602[0]=false
	c511000602[1]=false
end
function c511000602.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511000602[tp]
end
function c511000602.spfilter(c,e,tp)
	return c:IsLevelBelow(4) and c:IsSetCard(0x5) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511000602.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511000602.spfilter,tp,LOCATION_HAND,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_HAND)
end
function c511000602.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511000602.spfilter,tp,LOCATION_HAND,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)
	end
end
