--Crazy Summon Gear
function c511001358.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001358.target)
	e1:SetOperation(c511001358.activate)
	c:RegisterEffect(e1)
end
function c511001358.ofilter(c)
	return c:IsFaceup() and c:GetLevel()>0
end
function c511001358.filter(c,e,tp)
	return c:IsAttackBelow(1500) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001358.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c511001358.ofilter,tp,0,LOCATION_MZONE,1,nil) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.IsExistingTarget(c511001358.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) 
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and not Duel.IsPlayerAffectedByEffect(tp,59822133) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPPO)
	local g1=Duel.SelectTarget(tp,c511001358.ofilter,tp,0,LOCATION_MZONE,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g2=Duel.SelectTarget(tp,c511001358.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001358.ospfilter(c,race,lv,e,tp)
	return c:IsRace(race) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,0,1-tp,false,false,POS_FACEUP)
end
function c511001358.sspfilter(c,code,e,tp)
	return c:IsCode(code) and c:IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP)
end
function c511001358.activate(e,tp,eg,ep,ev,re,r,rp)
	local ftop=Duel.GetLocationCount(1-tp,LOCATION_MZONE)
	if ftop>2 then ftop=2 end
	if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local op=e:GetLabelObject()
	local se=g:GetFirst()
	if se==op then se=g:GetNext() end
	if op:IsFaceup() and op:IsRelateToEffect(e) then
		local sgo=Duel.GetMatchingGroup(c511001358.ospfilter,tp,0,LOCATION_DECK,nil,op:GetRace(),op:GetLevel(),e,tp)
		if sgo:GetCount()>0 and ftop>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local osp=sgo:Select(1-tp,1,ftop,nil)
			local tc=osp:GetFirst()
			while tc do
				Duel.SpecialSummonStep(tc,0,1-tp,1-tp,false,false,POS_FACEUP)
				tc=osp:GetNext()
			end
		end
		if se:IsRelateToEffect(e) then
			Duel.SpecialSummonStep(se,0,tp,tp,false,false,POS_FACEUP)
			local fts=Duel.GetLocationCount(tp,LOCATION_MZONE)
			local g=Duel.GetMatchingGroup(c511001358.sspfilter,tp,0x13,0,nil,se:GetCode(),e,tp)
			if g:GetCount()>0 and fts>0 then
				Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
				local fg=g:Select(tp,fts,fts,nil)
				local tc=fg:GetFirst()
				while tc do
					Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
					tc=fg:GetNext()
				end
			end
		end
		Duel.SpecialSummonComplete()
	end
end
