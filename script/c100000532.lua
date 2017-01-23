--����������� ������
function c100000532.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000532.target)
	e1:SetOperation(c100000532.operation)
	c:RegisterEffect(e1)
end
function c100000532.filter(c,e,tp)
	local code=c:GetCode()
	return code==100000533 or code==100000534 or code==100000537 or code==100000538
end
function c100000532.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(c100000532.filter,tp,LOCATION_HAND,0,nil,e,tp)
	local ct=g:GetCount()
	if chk==0 then return ct>0 and Duel.GetLocationCount(tp,LOCATION_MZONE)>=ct and (ct==1 or not Duel.IsPlayerAffectedByEffect(tp,59822133)) 
		and g:FilterCount(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false)==ct end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,ct,0,0)
end
function c100000532.operation(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c100000532.filter,tp,LOCATION_HAND,0,nil,e,tp)
	local ct=g:GetCount()
	if ct<=0 or Duel.GetLocationCount(tp,LOCATION_MZONE)<ct or (ct>1 and Duel.IsPlayerAffectedByEffect(tp,59822133)) 
		or g:FilterCount(Card.IsCanBeSpecialSummoned,nil,e,0,tp,false,false)~=ct then return end
	local fid=e:GetHandler():GetFieldID()
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP)
		tc:RegisterFlagEffect(100000532,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1,fid)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
	g:KeepAlive()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetCountLimit(1)
	e1:SetLabel(fid)
	e1:SetLabelObject(g)
	e1:SetCondition(c100000532.retcon)
	e1:SetOperation(c100000532.retop)
	Duel.RegisterEffect(e1,tp)
end
function c100000532.retfilter(c,fid)
	return c:GetFlagEffectLabel(100000532)==fid
end
function c100000532.retcon(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	if not g:IsExists(c100000532.retfilter,1,nil,e:GetLabel()) then
		g:DeleteGroup()
		e:Reset()
		return false
	else return true end
end
function c100000532.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local tg=g:Filter(c100000532.retfilter,nil,e:GetLabel())
	g:DeleteGroup()
	Duel.SendtoDeck(tg,nil,2,REASON_EFFECT)
end
