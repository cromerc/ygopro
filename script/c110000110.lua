--Big Bang Blow
function c110000110.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c110000110.descon)
	e1:SetTarget(c110000110.destg)
	e1:SetOperation(c110000110.desop)
	c:RegisterEffect(e1)
	if not c110000110.global_check then
		c110000110.global_check=true
		if Duel.GetFlagEffect(0,110000104)==0 and Duel.GetFlagEffect(1,110000104)==0 then
			Duel.RegisterFlagEffect(0,110000104,0,0,1)
			Duel.RegisterFlagEffect(1,110000104,0,0,1)
			--cannot attack
			local ge1=Effect.CreateEffect(c)
			ge1:SetType(EFFECT_TYPE_FIELD)
			ge1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			ge1:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
			ge1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			ge1:SetCondition(c110000110.atkcon)
			ge1:SetTarget(c110000110.atktg)
			Duel.RegisterEffect(ge1,0)
			--check
			local ge2=Effect.CreateEffect(c)
			ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			ge2:SetCode(EVENT_ATTACK_ANNOUNCE)
			ge2:SetOperation(c110000110.checkop)
			ge2:SetLabelObject(ge1)
			Duel.RegisterEffect(ge2,0)
			--change attack target
			local ge3=Effect.CreateEffect(c)
			ge3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
			ge3:SetCode(EVENT_BE_BATTLE_TARGET)
			ge3:SetCondition(c110000110.atcon)
			ge3:SetOperation(c110000110.atop)
			Duel.RegisterEffect(ge3,0)
			local ge4=ge3:Clone()
			Duel.RegisterEffect(ge4,1)
		end
	end
end
function c110000110.atkcon(e)
	return Duel.GetFlagEffect(e:GetHandlerPlayer(),110000103)~=0 and Duel.GetFlagEffect(1-e:GetHandlerPlayer(),110000103)~=0
end
function c110000110.atktg(e,c)
	return c:GetFieldID()~=e:GetLabel() and c:IsType(0x10000000)
end
function c110000110.checkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	if not a:IsType(0x10000000) then return end
	if Duel.GetFlagEffect(tp,110000103)~=0 and Duel.GetFlagEffect(1-tp,110000103)~=0 then return end
	local fid=eg:GetFirst():GetFieldID()
	Duel.RegisterFlagEffect(tp,110000103,RESET_PHASE+PHASE_END,0,1)
	Duel.RegisterFlagEffect(1-tp,110000103,RESET_PHASE+PHASE_END,0,1)
	e:GetLabelObject():SetLabel(fid)
end
function c110000110.atcon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttackTarget()
	return at:IsFaceup() and at:IsControler(tp) and at:IsType(0x10000000)
end
function c110000110.filter(c)
	return c:IsFaceup() and c:IsType(0x10000000)
end
function c110000110.atop(e,tp,eg,ep,ev,re,r,rp)
	local atg=Duel.GetAttacker():GetAttackableTarget()
	local d=Duel.GetAttackTarget()
	if atg:IsExists(c110000110.filter,1,d) and Duel.SelectYesNo(tp,aux.Stringid(21558682,0)) then
		local g=atg:FilterSelect(tp,c110000110.filter,1,1,d)
		Duel.HintSelection(g)
		Duel.ChangeAttackTarget(g:GetFirst())
	end
end
function c110000110.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c110000110.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c110000110.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g:GetCount(),g,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,PLAYER_ALL,0)
end
function c110000110.desop(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsDestructable,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	local dam=g:GetSum(Card.GetAttack)
	Duel.Destroy(g,REASON_EFFECT)
	Duel.Damage(1-tp,dam,REASON_EFFECT,true)
	Duel.Damage(tp,dam,REASON_EFFECT,true)
	Duel.RDComplete()
end
