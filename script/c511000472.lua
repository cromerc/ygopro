--Miracle Draw
function c511000472.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--draw check
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000472,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000472.drcon)
	e2:SetTarget(c511000472.drtg)
	e2:SetOperation(c511000472.drop)
	c:RegisterEffect(e2)
end
function c511000472.drcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer() and Duel.GetDrawCount(tp)>0
end
function c511000472.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,0)
	local ac=Duel.AnnounceCard(tp)
	e:GetHandler():SetHint(CHINT_CARD,ac)
	Duel.SetTargetParam(ac)
	Duel.SetOperationInfo(0,CATEGORY_ANNOUNCE,nil,0,tp,ANNOUNCE_CARD)
end
function c511000472.drop(e,tp,eg,ep,ev,re,r,rp)
	local ac=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DRAW)
	e1:SetOperation(c511000472.damop)
	e1:SetLabel(ac)
	e1:SetReset(RESET_PHASE+PHASE_DRAW)
	Duel.RegisterEffect(e1,tp)
end
function c511000472.damop(e,tp,eg,ep,ev,re,r,rp)
	if ep~=e:GetOwnerPlayer() then return end
	local hg=eg:Filter(Card.IsLocation,nil,LOCATION_HAND)
	if hg:GetCount()==0 then return end
	Duel.ConfirmCards(1-ep,hg)
	if hg:GetFirst():GetCode()==e:GetLabel() then
		Duel.Damage(1-tp,1000,REASON_EFFECT)
	else
		Duel.Damage(tp,1000,REASON_EFFECT)
	end
	Duel.ShuffleHand(ep)
end
