--Compulsory Circulation Device
function c511002735.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002735.condition)
	e1:SetCost(c511002735.cost)
	e1:SetTarget(c511002735.target)
	e1:SetOperation(c511002735.activate)
	c:RegisterEffect(e1)
end
function c511002735.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()>=PHASE_BATTLE_START and Duel.GetCurrentPhase()<=PHASE_BATTLE
end
function c511002735.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511002735.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=Duel.GetMatchingGroupCount(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,nil)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.CheckRemoveOverlayCard(tp,1,0,1,REASON_COST) and ct>0 
			and Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil) end
	if ct>1 then
		local t={}
		for i=1,ct do 
			t[i]=i
		end
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(81330115,0))
		ct=Duel.AnnounceNumber(tp,table.unpack(t))
	end
	Duel.RemoveOverlayCard(tp,1,0,ct,ct,REASON_COST)
	local g=Duel.GetMatchingGroup(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,1,0,0)
	Duel.SetTargetParam(ct)
end
function c511002735.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,ct,ct,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Remove(g,0,REASON_EFFECT+REASON_TEMPORARY)>0 then
			local tc=g:GetFirst()
			while tc do
				tc:RegisterFlagEffect(511002735,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
				tc=g:GetNext()
			end
			g:KeepAlive()
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
			e1:SetReset(RESET_PHASE+PHASE_BATTLE)
			e1:SetCountLimit(1)
			e1:SetLabelObject(g)
			e1:SetOperation(c511002735.retop)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c511002735.retfilter(c)
	return c:GetFlagEffect(511002735)~=0
end
function c511002735.retop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject()
	local sg=g:Filter(c511002735.retfilter,nil)
	g:DeleteGroup()
	local tc=sg:GetFirst()
	while tc do
		Duel.ReturnToField(tc)
		tc=sg:GetNext()
	end
end
