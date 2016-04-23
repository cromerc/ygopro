--玄翼竜 ブラック・フェザー
function c100000282.initial_effect(c)
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()	
	--send 
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DECKDES)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_DAMAGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100000282.recon)
	e1:SetTarget(c100000282.rectg)
	e1:SetOperation(c100000282.recop)
	c:RegisterEffect(e1)
end
function c100000282.recon(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp
end
function c100000282.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return ev>=400 and Duel.IsPlayerCanDiscardDeck(tp,1) end
	Duel.SetOperationInfo(0,CATEGORY_DECKDES,nil,0,tp,0)
end
function c100000282.recop(e,tp,eg,ep,ev,re,r,rp)
	local ct=math.floor(ev/400)
	Duel.DiscardDeck(tp,ct,REASON_EFFECT)
	local g=Duel.GetOperatedGroup()
	local ct=g:FilterCount(Card.IsType,nil,TYPE_MONSTER)
	if ct==0 then return end
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(ct*400)
		e1:SetReset(RESET_EVENT+0x1ff0000)
		c:RegisterEffect(e1)
	end
end