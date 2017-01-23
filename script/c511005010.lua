--Name Erasure
--  By Shad3

local scard,s_id=c511005010,511005010

function scard.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCategory(CATEGORY_HANDES+CATEGORY_DAMAGE)
	e2:SetCondition(scard.cd)
	e2:SetTarget(scard.tg)
	e2:SetOperation(scard.op)
	c:RegisterEffect(e2)
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFlagEffect(tp,s_id)==0
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(1-tp,LOCATION_HAND,0)>0 end
	Duel.SetTargetParam(Duel.AnnounceCard(tp))
	Duel.SetOperationInfo(0,CATEGORY_HANDES,nil,1,1-tp,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,1000,tp,0)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(1-tp,LOCATION_HAND,0)
	-- Revision with OCG ruling
	-- Duel.ConfirmCards(tp,g)
	local tg=g:Filter(Card.IsCode,nil,Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM))
	if tg:GetCount()>0 then
		Duel.HintSelection(tg)
		Duel.SendtoGrave(tg,REASON_EFFECT+REASON_DISCARD)
	else
		Duel.Damage(tp,1000,REASON_EFFECT)
		Duel.RegisterFlagEffect(tp,s_id,RESET_PHASE+PHASE_END,0,1)
	end
	Duel.ShuffleHand(1-tp)
end