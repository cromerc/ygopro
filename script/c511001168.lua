--Edict of Atlantis
function c511001168.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c511001168.activate)
	c:RegisterEffect(e1)
end
function c511001168.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(c511001168.lvop)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)	
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	Duel.RegisterEffect(e2,tp)	
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	Duel.RegisterEffect(e3,tp)	
end
function c511001168.filter(c)
	return c:IsAttribute(ATTRIBUTE_WATER) and not c:IsType(TYPE_XYZ)
end
function c511001168.lvop(e,tp,eg,ep,ev,re,r,rp)
	if not eg:IsExists(c511001168.filter,1,nil) then return end
	local g=eg:Filter(c511001168.filter,nil)
	local lv=Duel.AnnounceNumber(tp,0,1,2)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(lv)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end

