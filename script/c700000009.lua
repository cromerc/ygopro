--Scripted by Eerie Code
--Performapal Odd-Eyes Light Phoenix
function c700000009.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(700000009,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c700000009.spcon)
	e2:SetCost(c700000009.spcost)
	e2:SetTarget(c700000009.sptg)
	e2:SetOperation(c700000009.spop)
	c:RegisterEffect(e2)
	--destroy replace
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(700000009,1))
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetCode(EFFECT_DESTROY_REPLACE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c700000009.reptg)
	c:RegisterEffect(e3)
end
function c700000009.spcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(1-tp) and Duel.GetAttackTarget()==nil
end
function c700000009.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	local sc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	if chk==0 then return sc and sc:IsDestructable(e) end
	Duel.Destroy(sc,REASON_COST)
end
function c700000009.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c700000009.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c700000009.repfil(c)
	return (c:GetSequence()==6 or c:GetSequence()==7) and c:IsDestructable()
end
function c700000009.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReason(REASON_BATTLE) and Duel.IsExistingMatchingCard(c700000009.repfil,tp,LOCATION_SZONE,0,1,nil) end
	if Duel.SelectYesNo(tp,aux.Stringid(700000009,2)) then
		local g=Duel.SelectMatchingCard(tp,c700000009.repfil,tp,LOCATION_SZONE,0,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
