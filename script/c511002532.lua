--黒魔術のカーテン
function c511002532.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511002532.cost)
	e1:SetTarget(c511002532.target)
	e1:SetOperation(c511002532.activate)
	c:RegisterEffect(e1)
end
function c511002532.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local p=tp
	if Duel.IsExistingMatchingCard(c511002532.filter,1-tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,1-tp) 
		and Duel.SelectYesNo(1-tp,aux.Stringid(102380,0)) then
		Duel.PayLPCost(1-tp,math.floor(Duel.GetLP(1-tp)/2))
		p=tp+1
	end
	e:SetLabel(p)
end
function c511002532.filter(c,e,tp)
	return c:IsRace(RACE_SPELLCASTER) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002532.revfilter(c)
	return not c:IsPublic()
end
function c511002532.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g1=Duel.GetFieldGroup(tp,0,LOCATION_HAND)
	local ct2=Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c511002532.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,nil,e,tp) 
		and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 and Duel.IsPlayerCanSpecialSummon(1-tp) 
		and (ct2>0 or g1:IsExists(c511002532.revfilter,1,nil) or g1:IsExists(c511002532.filter,1,nil,e,1-tp) ) end
	local p=e:GetLabel()
	if p~=tp then
		p=PLAYER_ALL
	end
	Duel.SetTargetPlayer(p)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,p,LOCATION_HAND+LOCATION_DECK)
end
function c511002532.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(tp,c511002532.filter,tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,tp)
		if g:GetCount()>0 then
			Duel.SpecialSummonStep(g:GetFirst(),0,tp,tp,false,false,POS_FACEUP)
		end
	end
	if p==PLAYER_ALL and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>0 then
		Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_SPSUMMON)
		local g=Duel.SelectMatchingCard(1-tp,c511002532.filter,1-tp,LOCATION_HAND+LOCATION_DECK,0,1,1,nil,e,1-tp)
		if g:GetCount()>0 then
			Duel.SpecialSummonStep(g:GetFirst(),0,1-tp,1-tp,false,false,POS_FACEUP)
		end
	end
	Duel.SpecialSummonComplete()
end
