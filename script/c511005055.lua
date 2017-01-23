--Flattery
--  By Shad3

local scard,s_id=c511005055,511005055

function scard.initial_effect(c)
	--Global Reg
	if not scard.gl_chk then
		scard.gl_chk=true
		local ge1=Effect.GlobalEffect()
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(scard.flag_op)
		Duel.RegisterEffect(ge1,0)
	end
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_CUSTOM+s_id)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e1:SetCondition(scard.cd)
	e1:SetTarget(scard.tg)
	e1:SetOperation(scard.op)
	c:RegisterEffect(e1)
end

function scard.flag_reg(c)
	if c:IsFaceup() and c:GetFlagEffect(s_id)==0 then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetRange(LOCATION_MZONE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetLabel(c:GetAttack())
		e1:SetOperation(scard.flag_raise)
		c:RegisterEffect(e1)
		c:RegisterFlagEffect(s_id,RESET_EVENT+0x1fe0000,0,1)
	end
end

function scard.flag_op(e,tp,eg,ep,ev,re,r,rp)
	Duel.GetFieldGroup(0,LOCATION_MZONE,LOCATION_MZONE):ForEach(scard.flag_reg)
end

function scard.flag_raise(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:GetLabel()==c:GetAttack() then return end
	local ph=Duel.GetCurrentPhase()
	if ph>=PHASE_BATTLE_START and ph<=PHASE_BATTLE then
		Duel.RaiseEvent(Group.FromCards(c),EVENT_CUSTOM+s_id,e,REASON_EFFECT,rp,tp,math.abs(e:GetLabel()-c:GetAttack()))
	end
	e:SetLabel(c:GetAttack())
end

function scard.cd(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end

function scard.tg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsFaceup() and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,LOCATION_MZONE,0,1,nil) end
	Duel.SelectTarget(tp,Card.IsFaceup,tp,LOCATION_MZONE,0,1,1,nil)
end

function scard.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_BATTLE)
		e1:SetValue(ev)
		tc:RegisterEffect(e1)
	end
end