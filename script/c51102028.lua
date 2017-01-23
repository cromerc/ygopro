--Last Question
function c51102028.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,0x1c0+TIMING_MAIN_END)
	e1:SetCondition(c51102028.condition)
	e1:SetOperation(c51102028.activate)
	c:RegisterEffect(e1)
end
function c51102028.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.IsAbleToEnterBP()
end
function c51102028.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_MESSAGE,1-tp,aux.Stringid(51102028,0))
	Duel.Hint(HINT_SELECTMSG,1-tp,aux.Stringid(51102028,0))
	local quest=Duel.AnnounceNumber(1-tp,0,1,2,3,4,5,6,7,8,9,10)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	e1:SetCountLimit(1)
	e1:SetLabel(quest)
	e1:SetOperation(c51102028.op)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetReset(RESET_PHASE+PHASE_END)
	e2:SetCountLimit(1)
	e2:SetLabel(0)
	e2:SetOperation(c51102028.endop)
	Duel.RegisterEffect(e2,tp)
	e1:SetLabelObject(e2)
end
function c51102028.op(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(1)
	Duel.Hint(HINT_CARD,0,51102028)
	local quest=e:GetLabel()
	local ct=Duel.GetMatchingGroupCount(Card.IsFaceup,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local c=e:GetHandler()
	if ct==quest then
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,0,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	else
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
function c51102028.endop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		Duel.Hint(HINT_CARD,0,51102028)
		local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
