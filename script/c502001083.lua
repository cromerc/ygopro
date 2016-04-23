---Sylvan Princessprout
function c502001083.initial_effect(c)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(502001083,0))
	e1:SetProperty(EFFECT_FLAG_CHAIN_UNIQUE)
	e1:SetCategory(CATEGORY_TOGRAVE+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,502001083+100000000+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c502001083.gdcos)
	e1:SetTarget(c502001083.gdtg)
	e1:SetOperation(c502001083.gdop)
	c:RegisterEffect(e1)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(502001083,2))
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_CHAIN_UNIQUE)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCountLimit(1,502001083+200000000+EFFECT_COUNT_CODE_OATH)
	e2:SetCondition(c502001083.condition)
	e2:SetTarget(c502001083.target)
	e2:SetOperation(c502001083.operation)
	c:RegisterEffect(e2)
end
function c502001083.gdcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return c:IsReleasable() end
	Duel.Release(c,REASON_COST)
end	
function c502001083.gdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local dg=Duel.GetDecktopGroup(tp,1)
	if chk==0 then return dg:IsExists(Card.IsAbleToGrave,1,nil) end
	Duel.SetOperationInfo(tp,CATEGORY_TOGRAVE,dg,dg:GetCount(),tp,LOCATION_DECK)
	Duel.SetOperationInfo(tp,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
end	
function c502001083.tdfilter(c)
	return c:IsAbleToDeck()
	and c:IsType(TYPE_MONSTER)
--	and c:IsSetCard()
	and (c:IsCode(10753491) or c:IsCode(502001083))
end
function c502001083.gdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.DisableShuffleCheck()
	local c=e:GetHandler()
	local tp=c:GetControler()
	local dg=Duel.GetDecktopGroup(tp,1)
	if dg:IsExists(Card.IsAbleToGrave,1,nil) then
		Duel.ConfirmCards(1-tp,dg)
		if Duel.SendtoGrave(dg,REASON_EFFECT+REASON_REVEAL)~=0 then
			local g=Duel.GetMatchingGroup(c502001083.tdfilter,tp,LOCATION_GRAVE,0,nil)
			if g:GetCount()>0 then
				if Duel.SelectYesNo(tp,aux.Stringid(502001083,2)) then
					Duel.BreakEffect()
					local tg=g:Select(tp,1,1,nil)
					local tc=tg:GetFirst()
					Duel.SendtoDeck(tc,nil,0,REASON_EFFECT)
				end
			end
		end
	end
end	
function c502001083.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return c:IsPreviousLocation(LOCATION_DECK)
	and c:IsReason(REASON_EFFECT)
	and c:IsReason(REASON_REVEAL)
end
function c502001083.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	and c:IsCanBeSpecialSummoned(e,0,tp,false,false) end
	local t={}
	local i=1
	local p=1
	for i=1,8 do 
		t[p]=i p=p+1
	end
	t[p]=nil
	local ac=Duel.AnnounceNumber(tp,table.unpack(t))
	e:SetLabel(ac)
	Duel.SetOperationInfo(tp,CATEGORY_SPECIAL_SUMMON,c,1,tp,LOCATION_GRAVE)
end	
function c502001083.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(e:GetHandler():GetControler(),LOCATION_MZONE)<=0 then return end
	local lv=e:GetLabel()
	local c=e:GetHandler()
	local tp=c:GetControler()
	if c:IsRelateToEffect(e) and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		if Duel.SpecialSummonStep(c,0,tp,tp,false,false,POS_FACEUP)~=0 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CHANGE_LEVEL)
			e1:SetValue(lv)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			c:RegisterEffect(e1)
			--
			Duel.SpecialSummonComplete()
		end
	end
end	
