--Shock Draw
function c511002660.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(c511002660.target)
	e1:SetOperation(c511002660.activate)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	if not c511002660.global_check then
		c511002660.global_check=true
		c511002660[0]=0
		c511002660[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE)
		ge1:SetOperation(c511002660.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002660.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002660.checkop(e,tp,eg,ep,ev,re,r,rp)
	c511002660[ep]=c511002660[ep]+ev
end
function c511002660.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002660[0]=0
	c511002660[1]=0
end
function c511002660.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local ct=c511002660[tp]
	local dct=math.floor(ct/1000)
	if chk==0 then return dct>0 and Duel.IsPlayerCanDraw(tp,dct) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(dct)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,dct)
end
function c511002660.activate(e,tp,eg,ep,ev,re,r,rp)
	local ct=c511002660[tp]
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Draw(p,math.floor(ct/1000),REASON_EFFECT)
end
