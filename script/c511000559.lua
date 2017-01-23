--Blue-Eyes White Dragon (DM)
--Scripted by edo9300
function c511000559.initial_effect(c)
	--attack first
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_BP_FIRST_TURN)
	e1:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCondition(c511000559.con)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK)
	e2:SetRange(LOCATION_MZONE+LOCATION_PZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCondition(c511000559.con2)
	e2:SetTarget(c511000559.ftarget)
	c:RegisterEffect(e2)
	if not c511000559.global_check then
		c511000559.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000559.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000559.dm=true
function c511000559.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000559.con(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(300)>0 and Duel.IsExistingMatchingCard(function(c)return c:IsType(TYPE_FUSION)end,tp,LOCATION_MZONE,0,1,nil)
end
function c511000559.con2(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnCount()==1 and e:GetHandler():GetFlagEffect(300)>0
end
function c511000559.ftarget(e,c)
	return not c:IsType(TYPE_FUSION)
end