--Ｓｐ－アクセル・リミッター
function c100100108.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100100108.target)
	c:RegisterEffect(e1)
end
function c100100108.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PHASE+PHASE_END)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	e2:SetCountLimit(0)
	e2:SetCondition(c100100108.turncon)
	e2:SetOperation(c100100108.turnop)
	e2:SetLabel(0)
	Duel.RegisterEffect(e2,tp)
	local tc=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
	if Duel.GetTurnPlayer()~=tp then
		tc:RegisterFlagEffect(100100108,RESET_EVENT+RESET_PHASE+PHASE_END,0,3)
	else
		tc:RegisterFlagEffect(100100108,RESET_EVENT+RESET_PHASE+PHASE_END,0,4)
	end
end
function c100100108.turncon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c100100108.turnop(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	ct=ct+1
	e:SetLabel(ct)
	e:GetHandler():SetTurnCounter(ct)		
end