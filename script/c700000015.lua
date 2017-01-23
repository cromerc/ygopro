--Scripted by Eerie Code
--Abyss Actor - Extra
function c700000015.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c700000015.spcon)
	e2:SetTarget(c700000015.sptg)
	e2:SetOperation(c700000015.spop)
	c:RegisterEffect(e2)
	--Set in P.Zone
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTarget(c700000015.pztg)
	e3:SetOperation(c700000015.pzop)	
	c:RegisterEffect(e3)
end

function c700000015.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0 and e:GetHandler():GetFlagEffect(700000015)==0
end
function c700000015.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,c,1,0,0)
end
function c700000015.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end

function c700000015.pzfilter(c)
	return (c:GetSequence()==6 or c:GetSequence()==7)
end
function c700000015.pztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetMatchingGroupCount(c700000015.pzfilter,tp,LOCATION_SZONE,0,nil)<2 end
end
function c700000015.pzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		c:RegisterFlagEffect(700000015,RESET_EVENT+0xfc0000+RESET_PHASE+PHASE_END,0,1)
	end
end