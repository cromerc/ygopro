--Battlefield Tragedy
function c511000714.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--check
	local e0=Effect.CreateEffect(c)
	e0:SetCode(EVENT_ATTACK_ANNOUNCE)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetRange(0x7F)
	e0:SetOperation(c511000714.checkop)
	e0:SetLabel(0)
	c:RegisterEffect(e0)
	--send 5 cards
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetDescription(aux.Stringid(511000714,0))
	e2:SetCondition(c511000714.con)
	e2:SetTarget(c511000714.tg)
	e2:SetOperation(c511000714.op)
	e2:SetLabelObject(e0)
	c:RegisterEffect(e2)
	--reset
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e3:SetRange(0x7F)
	e3:SetCountLimit(1)
	e3:SetOperation(c511000714.resop)
	e3:SetLabelObject(e0)
	c:RegisterEffect(e3)
end
function c511000714.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 then
		e:SetLabel(1)
	elseif e:GetLabel()==1 then
		e:SetLabel(2)
	end
end
function c511000714.resop(e,tp,eg,ep,ev,re,r,rp)
	e:GetLabelObject():SetLabel(0)
end
function c511000714.con(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)>0 and ep~=Duel.GetTurnPlayer() and e:GetLabelObject():GetLabel()==1
end
function c511000714.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,Duel.GetTurnPlayer(),5)
end
function c511000714.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.DiscardDeck(Duel.GetTurnPlayer(),5,REASON_EFFECT)
end
