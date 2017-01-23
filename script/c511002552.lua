--捨て身の宝札
function c511002552.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c511002552.condition)
	e1:SetCost(c511002552.cost)
	e1:SetTarget(c511002552.target)
	e1:SetOperation(c511002552.activate)
	c:RegisterEffect(e1)
	if not c511002552.global_check then
		c511002552.global_check=true
		c511002552[0]=true
		c511002552[1]=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CHANGE_POS)
		ge1:SetOperation(c511002552.poscheck)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002552.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002552.poscheck(e,tp,eg,ep,ev,re,r,rp)
	if re==nil then
		c511002552[rp]=false
	end
end
function c511002552.clear(e,tp,eg,ep,ev,re,r,rp)
	c511002552[0]=true
	c511002552[1]=true
end
function c511002552.check(tp)
	local at1=0
	local ct=0
	for i=0,4 do
		local tc=Duel.GetFieldCard(tp,LOCATION_MZONE,i)
		if tc and tc:IsPosition(POS_FACEUP_ATTACK) then
			at1=at1+tc:GetAttack()
			ct=ct+1
		end
	end
	local at2=-1
	for i=0,4 do
		local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,i)
		if tc and tc:IsFaceup() then
			local atk=tc:GetAttack()
			if at2<0 or atk<at2 then at2=atk end
		end
	end
	return at1<at2 and ct>0
end
function c511002552.condition(e,tp,eg,ep,ev,re,r,rp)
	return c511002552.check(tp)
end
function c511002552.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetActivityCount(tp,ACTIVITY_SUMMON)==0 and Duel.GetActivityCount(tp,ACTIVITY_FLIPSUMMON)==0
		and Duel.GetActivityCount(tp,ACTIVITY_SPSUMMON)==0 and c511002552[tp] end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_SUMMON)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	Duel.RegisterEffect(e3,tp)
	local e4=Effect.CreateEffect(e:GetHandler())
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_SET_AVAILABLE+EFFECT_FLAG_OATH)
	e4:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e4:SetReset(RESET_PHASE+PHASE_END)
	e4:SetTargetRange(LOCATION_MZONE,0)
	Duel.RegisterEffect(e4,tp)
end
function c511002552.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c511002552.activate(e,tp,eg,ep,ev,re,r,rp)
	if not c511002552.check(tp) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
