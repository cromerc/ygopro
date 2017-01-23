--Hot Red Dragon Archfiend Belial
function c511001637.initial_effect(c)
	--synchro summon
	c:EnableReviveLimit()
	aux.AddSynchroProcedure2(c,nil,aux.NonTuner(nil))
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001637,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DAMAGE)
	e2:SetCondition(c511001637.spcon)
	e2:SetTarget(c511001637.sptg)
	e2:SetOperation(c511001637.spop)
	c:RegisterEffect(e2)
end
function c511001637.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511001637.filter(c,e,tp)
	return c:IsType(TYPE_TUNER) and c:GetLevel()>0 and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and not c:IsHasEffect(EFFECT_NECRO_VALLEY) 
		and Duel.IsExistingMatchingCard(c511001637.filter2,tp,LOCATION_DECK,0,1,nil,c:GetLevel(),e,tp)
end
function c511001637.filter2(c,lv,e,tp)
	return c:IsType(TYPE_TUNER) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001637.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>1 
		and Duel.IsExistingMatchingCard(c511001637.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c511001637.spop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=1 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g1=Duel.SelectMatchingCard(tp,c511001637.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	local tc=g1:GetFirst()
	if tc then
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c511001637.filter2,tp,LOCATION_DECK,0,1,1,nil,tc:GetLevel(),e,tp)
		if g2:GetCount()>0 then
			Duel.SpecialSummonStep(g2:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_DISABLE)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			g2:GetFirst():RegisterEffect(e3,true)
			local e4=Effect.CreateEffect(e:GetHandler())
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_DISABLE_EFFECT)
			e4:SetReset(RESET_EVENT+0x1fe0000)
			g2:GetFirst():RegisterEffect(e4,true)
		end
		Duel.SpecialSummonComplete()
	end
end
