--Performapal Wim Witch
function c511009072.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCondition(c511009072.spcon)
	e1:SetTarget(c511009072.sptg)
	e1:SetOperation(c511009072.spop)
	c:RegisterEffect(e1)
	--double tribute
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e2:SetValue(c511009072.condition)
	c:RegisterEffect(e2)
end
function c511009072.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0 
end
function c511009072.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c511009072.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c511009072.condition(e,c)
	return c:IsType(TYPE_PENDULUM)
end
