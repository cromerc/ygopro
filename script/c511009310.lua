--Synchro Zone
function c511009310.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511009310.target)
	e1:SetOperation(c511009310.operation)
	c:RegisterEffect(e1)
	--disable attack
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(78625592,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c511009310.target)
	e2:SetOperation(c511009310.operation)
	c:RegisterEffect(e2)
end
function c511009310.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tg=Duel.GetAttacker()
	e:SetLabel(0)
	if Duel.CheckEvent(EVENT_ATTACK_ANNOUNCE) and tg:IsType(TYPE_SYNCHRO) and tp~=Duel.GetTurnPlayer() then
		e:SetLabel(1)
		e:GetHandler():RegisterFlagEffect(0,RESET_CHAIN,EFFECT_FLAG_CLIENT_HINT,1,0,65)
	end
end
function c511009310.operation(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabel()==0 or not e:GetHandler():IsRelateToEffect(e) then return end
	Duel.NegateAttack()
end
