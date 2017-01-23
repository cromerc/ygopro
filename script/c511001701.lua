--Cardian - Ameshikou
function c511001701.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),2)
	c:EnableReviveLimit()
	--skip draw
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PREDRAW)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c511001701.scon)
	e1:SetOperation(c511001701.sop)
	c:RegisterEffect(e1)
	--draw negate
	local e2=Effect.CreateEffect(c)
	e2:SetRange(LOCATION_MZONE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_DRAW)
	e2:SetCondition(c511001701.drcon)
	e2:SetOperation(c511001701.drop)
	c:RegisterEffect(e2)
	--damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_DRAW)
	e3:SetCondition(c511001701.damcon)
	e3:SetOperation(c511001701.damop)
	c:RegisterEffect(e3)
end
function c511001701.scon(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	return tp==Duel.GetTurnPlayer() and mg:GetCount()>0 and mg:IsExists(Card.IsCode,1,nil,89818984) and mg:IsExists(Card.IsCode,1,nil,16024176) 
		and mg:IsExists(Card.IsCode,1,nil,43413875) and mg:IsExists(Card.IsCode,1,nil,16802689)
end
function c511001701.sop(e,tp,eg,ep,ev,re,r,rp)
	local dt=Duel.GetDrawCount(tp)
	if dt~=0 and not Duel.SelectYesNo(tp,aux.Stringid(1945387,0)) then
		_replace_count=0
		_replace_max=dt
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetCode(EFFECT_DRAW_COUNT)
		e1:SetTargetRange(1,0)
		e1:SetReset(RESET_PHASE+PHASE_DRAW)
		e1:SetValue(0)
		Duel.RegisterEffect(e1,tp)
	end
end
function c511001701.drcon(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	return ep==tp and mg:GetCount()>0 and mg:IsExists(Card.IsCode,1,nil,89818984) and mg:IsExists(Card.IsCode,1,nil,16024176) 
		and mg:IsExists(Card.IsCode,1,nil,43413875) and mg:IsExists(Card.IsCode,1,nil,16802689)
end
function c511001701.drop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFacedown() then return end
	Duel.NegateRelatedChain(c,RESET_TURN_SET)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_DISABLE_EFFECT)
	e2:SetValue(RESET_TURN_SET)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	c:RegisterEffect(e2)
end
function c511001701.damcon(e,tp,eg,ep,ev,re,r,rp)
	local mg=e:GetHandler():GetMaterial()
	return ep~=tp and mg:GetCount()>0 and mg:IsExists(Card.IsCode,1,nil,89818984) and mg:IsExists(Card.IsCode,1,nil,16024176) 
		and mg:IsExists(Card.IsCode,1,nil,43413875) and mg:IsExists(Card.IsCode,1,nil,16802689)
end
function c511001701.damop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Damage(1-tp,1500,REASON_EFFECT)
end
