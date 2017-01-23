--No.83 ギャラクシー・クィーン
function c511010083.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,1,3)
	c:EnableReviveLimit()
	--attack up
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48928529,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511010083.cost)
	e1:SetOperation(c511010083.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c511010083.indes)
	c:RegisterEffect(e2)
	if not c511010083.global_check then
		c511010083.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010083.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010083.xyz_number=83
function c511010083.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511010083.operation(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_MZONE,0)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		e2:SetValue(1)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_PIERCE)
		e3:SetReset(RESET_EVENT+0x1ff0000+RESET_PHASE+PHASE_STANDBY+RESET_SELF_TURN)
		tc:RegisterEffect(e3)
		tc=g:GetNext()
	end
end
function c511010083.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,48928529)
	Duel.CreateToken(1-tp,48928529)
end
function c511010083.indes(e,c)
return not c:IsSetCard(0x48)
end