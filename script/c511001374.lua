--Number 8: Heraldic King Genom-Heritage (anime)
function c511001374.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.FilterBoolFunction(Card.IsSetCard,0x76),4,2)
	c:EnableReviveLimit()
	--atk
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(69838592,1))
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetCondition(c511001374.atkcon)
	e1:SetCost(c511001374.cost)
	e1:SetOperation(c511001374.atkop)
	c:RegisterEffect(e1)
	--effect
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(10032958,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCost(c511001374.cost)
	e2:SetCondition(c511001374.effcon)
	e2:SetOperation(c511001374.effop)
	c:RegisterEffect(e2)
	--name
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51827737,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetCountLimit(1)
	e2:SetCost(c511001374.cost)
	e2:SetCondition(c511001374.cocon)
	e2:SetOperation(c511001374.coop)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetValue(c511001374.indes)
	c:RegisterEffect(e3)
	if not c511001374.global_check then
		c511001374.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001374.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001374.xyz_number=8
function c511001374.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001374.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc and bc:IsFaceup() and bc:IsRelateToBattle() and bc:GetBaseAttack()~=c:GetAttack() and bc:GetAttack()>0
end
function c511001374.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if c:IsFaceup() and c:IsRelateToBattle() and bc:IsFaceup() and bc:IsRelateToBattle() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(bc:GetBaseAttack())
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		bc:RegisterEffect(e1)
	end
end
function c511001374.effcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	return a:IsControler(1-tp) and a:IsPosition(POS_FACEUP_ATTACK)
end
function c511001374.effop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local c=e:GetHandler()
	if c:IsFaceup() then
		Duel.NegateAttack()
		local code=a:GetOriginalCode()
		c:CopyEffect(code,RESET_EVENT+0x1fe0000)
	end
end
function c511001374.cocon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511001374.coop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local c=e:GetHandler()
	if c:IsFaceup() then
		local code=a:GetCode()
		--code
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		a:RegisterEffect(e1)
		--code
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e2:SetCode(EFFECT_ADD_CODE)
		e2:SetValue(code)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end
function c511001374.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,47387961)
	Duel.CreateToken(1-tp,47387961)
end
function c511001374.indes(e,c)
	return not c:IsSetCard(0x48)
end
