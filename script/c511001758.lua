--Akashic Record
function c511001758.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001758.target)
	e1:SetOperation(c511001758.activate)
	c:RegisterEffect(e1)
	if not c511001758.global_check then
		c511001758.global_check=true
		c511001758[0]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511001758.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
		ge2:SetOperation(c511001758.checkop)
		Duel.RegisterEffect(ge2,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge3:SetOperation(c511001758.checkop)
		Duel.RegisterEffect(ge3,0)
		local ge3=Effect.CreateEffect(c)
		ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge3:SetCode(EVENT_CHAINING)
		ge3:SetOperation(c511001758.checkop)
		Duel.RegisterEffect(ge3,0)
	end
end
function c511001758.filter(c)
	local code=c:GetCode()
	if c511001758[0]<=0 then return false end
	for i=1,c511001758[0] do
		if code==c511001758[i] then return true end
	end
	return false
end
function c511001758.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	while tc do
		if not c511001758.filter(tc) then
			c511001758[0]=c511001758[0]+1
			c511001758[c511001758[0]]=tc:GetCode()
		end
		tc=eg:GetNext()
	end
end
function c511001758.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511001758.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
	local dg=Duel.GetOperatedGroup()
	local rg=dg:Filter(c511001758.filter,nil)
	if rg:GetCount()>0 then
		Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	end
end
