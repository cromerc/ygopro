--Number 35: Ravenous Tarantula (Anime)
function c511010035.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,10,2)
	c:EnableReviveLimit()
	--half atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetTarget(c511010035.atktg)
	e1:SetValue(c511010035.val)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	c:RegisterEffect(e2)
	--battle indestructable
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e5:SetValue(c511010035.indes)
	c:RegisterEffect(e5)
	if not c511010035.global_check then
		c511010035.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511010035.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511010035.xyz_number=35
function c511010035.atktg(e,c)
	return c:IsRace(RACE_INSECT)
end
function c511010035.val(e,c)
	local tp=e:GetHandler():GetControler()
	if Duel.GetLP(tp)<=Duel.GetLP(1-tp) then
		return Duel.GetLP(1-tp)-Duel.GetLP(tp)
	else
		return Duel.GetLP(tp)-Duel.GetLP(1-tp)
	end
end
function c511010035.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,90162951)
	Duel.CreateToken(1-tp,90162951)
end
function c511010035.indes(e,c)
	return not c:IsSetCard(0x48)
end