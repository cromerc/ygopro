--No.16 色の支配者ショック・ルーラー
function c513000018.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,4,3)
	c:EnableReviveLimit()
	--act limit
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(54719828,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c513000018.cost)
	e1:SetOperation(c513000018.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c513000018.indes)
	c:RegisterEffect(e2)
	if not c513000018.global_check then
		c513000018.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c513000018.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c513000018.xyz_number=16
function c513000018.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c513000018.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(54719828,1))
	local op=Duel.SelectOption(tp,70,71,72)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(0,0xff)
	e1:SetTarget(c513000018.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	e1:SetLabel(op)
	Duel.RegisterEffect(e1,tp)
	--disable effect
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVING)
	e2:SetOperation(c513000018.disoperation)
	e2:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	e2:SetLabel(op)
	Duel.RegisterEffect(e2,tp)
	--disable trap monster
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE_TRAPMONSTER)
	e3:SetTargetRange(0,0xff)
	e3:SetTarget(c513000018.distarget)
	e3:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	e3:SetLabel(op)
	Duel.RegisterEffect(e3,tp)
end
function c513000018.distarget(e,c)
	local type=0
	if e:GetLabel()==0 then
		type=TYPE_MONSTER
	elseif e:GetLabel()==1 then
		type=TYPE_SPELL
	else
		type=TYPE_TRAP
	end
	return c:IsType(type)
end
function c513000018.disoperation(e,tp,eg,ep,ev,re,r,rp)
	local type=0
	if e:GetLabel()==0 then
		type=TYPE_MONSTER
	elseif e:GetLabel()==1 then
		type=TYPE_SPELL
	else
		type=TYPE_TRAP
	end
	if re:IsActiveType(type) and re:GetHandler():IsControler(1-tp) then
		Duel.NegateEffect(ev)
	end
end
function c513000018.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,54719828)
	Duel.CreateToken(1-tp,54719828)
end
function c513000018.indes(e,c)
	return not c:IsSetCard(0x48)
end
