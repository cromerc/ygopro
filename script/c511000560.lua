--Total Defense Shogun (DM)
--Scripted by edo9300
function c511000560.initial_effect(c)
	--to defense
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75372290,0))
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_TRIGGER_F+EFFECT_TYPE_SINGLE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c511000560.postg)
	e1:SetOperation(c511000560.posop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_DEFENSE_ATTACK)
	c:RegisterEffect(e3)
	--destroy
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(51100567,3))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_ATTACK_ANNOUNCE)
	e4:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e4:SetCondition(c511000560.descon)
	e4:SetCost(c511000560.descost)
	e4:SetTarget(c511000560.destg)
	e4:SetOperation(c511000560.desop)
	c:RegisterEffect(e4)
	if not c511000560.global_check then
		c511000560.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000560.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000560.dm=true
function c511000560.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000560.postg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return e:GetHandler():IsAttackPos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c511000560.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsAttackPos() and c:IsRelateToEffect(e) then
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	end
end
function c511000560.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511000560.descon(e,tp,eg,ep,ev,re,r,rp)
	return tp~=Duel.GetTurnPlayer() and e:GetHandler():GetFlagEffect(300)>0
end
function c511000560.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tg=Duel.GetAttacker()
	if chk==0 then return tg:IsOnField() and tg:IsDestructable() and tg:IsCanBeEffectTarget(e) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tg,1,0,0)
end
function c511000560.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	Duel.Destroy(tc,REASON_EFFECT)
end