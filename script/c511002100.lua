--Card of Heaven and Earth
function c511002100.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002100.condition)
	e1:SetTarget(c511002100.target)
	e1:SetOperation(c511002100.activate)
	c:RegisterEffect(e1)
	if not c511002100.global_check then
		c511002100.global_check=true
		c511002100[0]=true
		c511002100[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetOperation(c511002100.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002100.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002100.checkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	if tc:IsLevelAbove(7) then
		c511002100[tc:GetControler()]=true
	end
end
function c511002100.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002100[0]=false
	c511002100[1]=false
end
function c511002100.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511002100[tp]
end
function c511002100.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then ft=ft-1 end
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) and ft>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511002100.filter(c)
	return c:IsSSetable() or c:IsMSetable(true,nil)
end
function c511002100.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	local g=Duel.GetDecktopGroup(p,2)
	Duel.Draw(p,d,REASON_EFFECT)
	if g:IsExists(c511002100.filter,1,nil) then
		local sc=g:FilterSelect(p,c511002100.filter,1,1,nil):GetFirst()
		if sc:IsMSetable(true,nil) then
			Duel.MSet(p,sc,true,nil)
		else
			Duel.SSet(p,sc)
			Duel.ConfirmCards(1-p,sc)
		end
	else
		Duel.ConfirmCards(1-p,g)
		Duel.ShuffleHand(p)
	end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e1:SetCode(EFFECT_FORBIDDEN)
		e1:SetReset(RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
