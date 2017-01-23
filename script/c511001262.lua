--Metabolic Storm
function c511001262.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511001262.target)
	e1:SetOperation(c511001262.activate)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	if not c511001262.global_check then
		c511001262.global_check=true
		c511001262[0]=0
		c511001262[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
		ge1:SetCode(EVENT_DESTROY)
		ge1:SetLabelObject(e1)
		ge1:SetOperation(c511001262.damop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511001262.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511001262.chkfilter(c,tp,re)
	return c:IsType(TYPE_MONSTER) and c:IsPreviousLocation(LOCATION_MZONE) and c:GetPreviousControler()==tp
		and bit.band(c:GetReason(),0x41)==0x41 and re:GetOwner():IsSetCard(0x1205)
end
function c511001262.damop(e,tp,eg,ep,ev,re,r,rp)
	local g1=eg:Filter(c511001262.chkfilter,nil,tp,re)
	local g2=eg:Filter(c511001262.chkfilter,nil,1-tp,re)
	if g1:GetCount()>0 then
		local sum=g1:GetSum(Card.GetAttack)
		c511001262[tp]=c511001262[tp]+sum
	end
	if g2:GetCount()>0 then
		local sum=g2:GetSum(Card.GetAttack)
		c511001262[1-tp]=c511001262[1-tp]+sum
	end
end
function c511001262.clear(e,tp,eg,ep,ev,re,r,rp)
	c511001262[0]=0
	c511001262[1]=0
end
function c511001262.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511001262[tp]>0 or c511001262[1-tp]>0 end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c511001262.activate(e,tp,eg,ep,ev,re,r,rp)
	if c511001262[tp]>0 then
		Duel.Damage(tp,c511001262[tp],REASON_EFFECT)
	end
	if c511001262[1-tp]>0 then
		Duel.Damage(1-tp,c511001262[1-tp],REASON_EFFECT)
	end
end
