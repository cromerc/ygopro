--Card of Spell Containment
function c511000204.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511000204.cost)
	e1:SetTarget(c511000204.target)
	e1:SetOperation(c511000204.activate)
	c:RegisterEffect(e1)
	if not c511000204.global_check then
		c511000204.global_check=true
		c511000204[0]=true
		c511000204[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHAINING)
		ge1:SetOperation(c511000204.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_PHASE_START+PHASE_DRAW)
		ge2:SetOperation(c511000204.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511000204.checkop(e,tp,eg,ep,ev,re,r,rp)
	if re:IsActiveType(TYPE_SPELL) then
		c511000204[rp]=false
	end
end
function c511000204.clear(e,tp,eg,ep,ev,re,r,rp)
	c511000204[0]=true
	c511000204[1]=true
end
function c511000204.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511000204[tp] end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_MSET)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetTarget(aux.TRUE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SSET)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_TURN_SET)
	Duel.RegisterEffect(e3,tp)
	local e4=e1:Clone()
	e4:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e4:SetTarget(c511000204.sumlimit)
	Duel.RegisterEffect(e4,tp)
	local e5=Effect.CreateEffect(e:GetHandler())
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e5:SetCode(EFFECT_CANNOT_ACTIVATE)
	e5:SetTargetRange(1,0)
	e5:SetValue(c511000204.aclimit)
	e5:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e5,tp)
end
function c511000204.aclimit(e,re,tp)
	return re:GetHandler():IsType(TYPE_SPELL)
end
function c511000204.sumlimit(e,c,sump,sumtype,sumpos,targetp)
	return bit.band(sumpos,POS_FACEDOWN)~=0
end
function c511000204.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511000204.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
