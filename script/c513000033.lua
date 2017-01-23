--フリッグのリンゴ
function c513000033.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_RECOVER+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_BATTLE_DAMAGE)
	e1:SetCondition(c513000033.condition)
	e1:SetTarget(c513000033.target)
	e1:SetOperation(c513000033.activate)
	c:RegisterEffect(e1)
	if not c513000033.global_check then
		c513000033.global_check=true
		c513000033[0]=0
		c513000033[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c513000033.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c513000033.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c513000033.checkop(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp then
		c513000033[tp]=c513000033[tp]+ev
	end
	if ep==1-tp then
		c513000033[1-tp]=c513000033[1-tp]+ev
	end
end
function c513000033.clear(e,tp,eg,ep,ev,re,r,rp)
	c513000033[0]=0
	c513000033[1]=0
end
function c513000033.condition(e,tp,eg,ep,ev,re,r,rp)
	return ep==tp and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
end
function c513000033.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsPlayerCanSpecialSummonMonster(tp,42671152,0,0x4011,-2,-2,1,RACE_FIEND,ATTRIBUTE_DARK) end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,c513000033[tp])
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c513000033.activate(e,tp,eg,ep,ev,re,r,rp)
	local rec=Duel.Recover(tp,c513000033[tp],REASON_EFFECT)
	if rec~=c513000033[tp] or Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		or not Duel.IsPlayerCanSpecialSummonMonster(tp,42671152,0,0x4011,-2,-2,1,RACE_FIEND,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,42671152)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(c513000033[tp])
	e1:SetReset(RESET_EVENT+0x1fe0000)
	token:RegisterEffect(e1,true)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_SET_DEFENSE)
	token:RegisterEffect(e2,true)
	Duel.SpecialSummonComplete()
end
