--希望の創造者
function c200000000.initial_effect(c)
	--spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c200000000.retcon)
	e2:SetOperation(c200000000.spr)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e3:SetRange(LOCATION_GRAVE)
	e3:SetCode(EVENT_PREDRAW)
	e3:SetCondition(c200000000.spcon)
	e3:SetTarget(c200000000.sptg)
	e3:SetOperation(c200000000.spop)
	c:RegisterEffect(e3)
end
c200000000.illegal=true
function c200000000.retcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsReason(REASON_DESTROY) and e:GetHandler():GetReasonPlayer()~=tp
		and e:GetHandler():GetPreviousControler()==tp
end
function c200000000.spr(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()==tp then
		c:RegisterFlagEffect(200000000,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,3)
	else
		c:RegisterFlagEffect(200000000,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,2)
	end
end
function c200000000.spcon(e,tp,eg,ep,ev,re,r,rp)
	local tp=e:GetHandler():GetControler()
	return Duel.GetTurnPlayer()==tp and Duel.GetLP(tp)<Duel.GetLP(1-tp)
end
function c200000000.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():GetFlagEffect(200000000)>0 end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(110000000,5))
	local code=Duel.AnnounceCard(tp)
    e:SetLabel(code)
	e:GetHandler():ResetFlagEffect(200000000)
end
function c200000000.spop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()~=200000001 then return end
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(110000000,6))
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_DECK,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.ShuffleDeck(tp)
		Duel.MoveSequence(tc,0)
		Duel.ConfirmDecktop(tp,1)
	end
	Duel.RegisterFlagEffect(tp,200000000,0,0,0)
end
