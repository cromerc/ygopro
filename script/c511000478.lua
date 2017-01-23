--Draw Paradox
function c511000478.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--opponent draw
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000478,0))
	e2:SetCategory(CATEGORY_DRAW)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PREDRAW)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c511000478.drcon)
	e2:SetTarget(c511000478.drtg)
	e2:SetOperation(c511000478.drop)
	c:RegisterEffect(e2)
end
function c511000478.drcon(e,eg,ep,ev,re,r,rp)
	local tp=Duel.GetTurnPlayer()
	return Duel.GetDrawCount(tp)>0
end
function c511000478.drtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local dt=Duel.GetDrawCount(Duel.GetTurnPlayer())
	if dt~=0 then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		if Duel.GetTurnPlayer()==e:GetHandler():GetControler() then
			e1:SetTargetRange(1,0)
		else
			e1:SetTargetRange(0,1)
		end
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511000478.drop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Draw(1-Duel.GetTurnPlayer(),1,REASON_RULE)
end
