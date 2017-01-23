--Number 38: Hope Harbinger Dragon Titanic Galaxy
function c511001275.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,8,2)
	c:EnableReviveLimit()
	--Negate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511001275,0))
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_CHAINING)
	e1:SetCondition(c511001275.condition)
	e1:SetTarget(c511001275.target)
	e1:SetOperation(c511001275.activate)
	c:RegisterEffect(e1)
	--attach
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001275,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetLabelObject(e1)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(c511001275.atcon)
	e2:SetOperation(c511001275.atop)
	c:RegisterEffect(e2)
	--change battle target
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511001275,2))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511001275.con)
	e3:SetCost(c511001275.cost)
	e3:SetOperation(c511001275.op)
	c:RegisterEffect(e3)
	--gain atk
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(511001275,3))
	e4:SetCategory(CATEGORY_ATKCHANGE)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EVENT_DESTROY)
	e4:SetCondition(c511001275.atkcon1)
	e4:SetOperation(c511001275.atkop1)
	c:RegisterEffect(e4)
	--xyz gains atk
	local e5=Effect.CreateEffect(c)
	e5:SetDescription(aux.Stringid(511001275,4))
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e5:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e5:SetCode(EVENT_DESTROYED)
	e5:SetTarget(c511001275.atktg2)
	e5:SetOperation(c511001275.atkop2)
	c:RegisterEffect(e5)
	--battle indestructable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e6:SetValue(c511001275.indes)
	c:RegisterEffect(e6)
	if not c511001275.global_check then
		c511001275.global_check=true
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge2:SetOperation(c511001275.numchk)
		Duel.RegisterEffect(ge2,0)
	end
end
c511001275.xyz_number=38
function c511001275.condition(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsStatus(STATUS_BATTLE_DESTROYED) and rp~=tp
		and re:IsActiveType(TYPE_SPELL) and Duel.IsChainDisablable(ev)
end
function c511001275.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	if re:GetHandler():IsAbleToRemove() and re:GetHandler():IsRelateToEffect(re) and e:GetHandler():IsAbleToRemove() then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,2,0,0)
	end
end
function c511001275.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
	if re:GetHandler():IsRelateToEffect(re) and e:GetHandler():IsRelateToEffect(e) then
		local g=Group.FromCards(e:GetHandler())
		g:Merge(eg)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
		eg:GetFirst():RegisterFlagEffect(511001275,RESET_EVENT+0x1fe0000,0,1)
		e:GetHandler():RegisterFlagEffect(511001275,RESET_EVENT+0x0fe0000,0,1)
		e:SetLabelObject(eg:GetFirst())
	end
end
function c511001275.atcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject():GetLabelObject()
	return c:GetPreviousLocation()==LOCATION_REMOVED and c:GetFlagEffect(511001275)>0 and tc and tc:GetFlagEffect(511001275)>0
end
function c511001275.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Overlay(e:GetHandler(),Group.FromCards(e:GetLabelObject():GetLabelObject()))
	e:GetLabelObject():SetLabelObject(nil)
end
function c511001275.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.GetAttackTarget()~=e:GetHandler()
end
function c511001275.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c511001275.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.ChangeAttackTarget(c)
	end
end
function c511001275.atkfilter(c,tp)
	return c:IsReason(REASON_DESTROY) and c:IsControler(tp) and c:GetPreviousControler()==tp and c:IsType(TYPE_XYZ)
end
function c511001275.atkcon1(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c511001275.atkfilter,nil,tp)
	return g:GetCount()==1 and g:GetFirst()~=e:GetHandler()
end
function c511001275.atkop1(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=eg:Filter(c511001275.atkfilter,nil,tp)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_COPY_INHERIT)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	e1:SetValue(g:GetFirst():GetBaseAttack())
	c:RegisterEffect(e1)
end
function c511001275.xyzfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001275.atktg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001275.xyzfilter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c511001275.atkop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(e:GetHandler():GetPreviousAttackOnField())
		tc:RegisterEffect(e1)
	end
end
function c511001275.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c511001275.numchk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,63767246)
	Duel.CreateToken(1-tp,63767246)
end
