--The Greatest Duo of the Seven Emperors
function c511001180.initial_effect(c)
--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c511001180.atkcon)
	e1:SetTarget(c511001180.tgtg)
	e1:SetOperation(c511001180.tgop)
	c:RegisterEffect(e1)
end
function c511001180.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local att=Duel.GetAttackTarget()
	return ep==tp and
	 (a:IsSetCard(0x1048) or (att and att:IsSetCard(0x1048)))
end
function c511001180.tgfilter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001180.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c511001180.tgfilter,tp,LOCATION_EXTRA,0,1,nil,20785975,e,tp)
		and Duel.IsExistingMatchingCard(c511001180.tgfilter,tp,LOCATION_EXTRA,0,1,nil,67173574,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
end
function c511001180.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc1=Duel.SelectMatchingCard(tp,c511001180.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil,20785975,e,tp):GetFirst()
	local tc2=Duel.SelectMatchingCard(tp,c511001180.tgfilter,tp,LOCATION_EXTRA,0,1,1,nil,67173574,e,tp):GetFirst()
	if tc1 and tc2 then
		Duel.SpecialSummonStep(tc1,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc1:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc1:RegisterEffect(e2,true)
		Duel.SpecialSummonStep(tc2,0,tp,tp,false,false,POS_FACEUP)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DISABLE)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		tc2:RegisterEffect(e3,true)
		local e4=Effect.CreateEffect(e:GetHandler())
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DISABLE_EFFECT)
		e4:SetReset(RESET_EVENT+0x1fe0000)
		tc2:RegisterEffect(e4,true)
	end
	Duel.SpecialSummonComplete()
end
