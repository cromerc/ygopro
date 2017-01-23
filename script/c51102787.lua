--Quiz Panel - Ra 20
function c51102787.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetDescription(aux.Stringid(51102781,1))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_FLIP)
	e1:SetOperation(c51102787.operation)
	c:RegisterEffect(e1)
end
function c51102787.spfilter(c,e,tp)
	return c:IsCode(51102788) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c51102787.operation(e,tp,eg,ep,ev,re,r,rp)
	local check=true
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(51102787,0))
	local h=Duel.GetDecktopGroup(1-tp,1)
	local tc=h:GetFirst()
	Duel.Draw(1-tp,1,REASON_EFFECT)
	if tc then
		Duel.ConfirmCards(1-tp,tc)
		local ct=1
		while ct<=4095 and check==true do
			if tc:IsSetCard(ct) then
				check=false
			end
			ct=ct+1
		end
		Duel.ShuffleHand(1-tp)
	end
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c51102787.spfilter,tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEDOWN_DEFENSE)
	end
	if check==true then
		Duel.Damage(tp,800,REASON_EFFECT)
	else
		if Duel.GetAttacker() then
			Duel.Destroy(Duel.GetAttacker(),REASON_EFFECT)
		end
		Duel.Damage(1-tp,800,REASON_EFFECT)
	end
end
