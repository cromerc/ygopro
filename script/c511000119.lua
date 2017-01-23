--Dark Sanctuary
function c511000119.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c511000119.target)
	c:RegisterEffect(e1)
	--trigger
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(97268402,0))
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetRange(LOCATION_HAND)
	e2:SetLabel(1)
	e2:SetCondition(c511000119.accon)
	e2:SetTarget(c511000119.actg)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EVENT_PHASE_START+PHASE_BATTLE)
	e3:SetCountLimit(1)
	e3:SetOperation(c511000119.regop)
	c:RegisterEffect(e3)
	--trigger2
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(29590752,1))
	e4:SetCategory(CATEGORY_EQUIP)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetCode(511000119)
	e4:SetCondition(c511000119.eqcon)
	e4:SetTarget(c511000119.eqtg)
	e4:SetOperation(c511000119.operation)
	c:RegisterEffect(e4)
	--destroy
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_DAMAGE+CATEGORY_RECOVER)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e5:SetCode(EVENT_ATTACK_ANNOUNCE)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCondition(c511000119.atkcon)
	e5:SetTarget(c511000119.atktg)
	e5:SetOperation(c511000119.atkop)
	c:RegisterEffect(e5)
	--maintain
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e6:SetCode(EVENT_PHASE+PHASE_END)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCountLimit(1)
	e6:SetCondition(c511000119.mtcon)
	e6:SetOperation(c511000119.mtop)
	c:RegisterEffect(e6)
	--move
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e7:SetCode(EFFECT_SPSUMMON_PROC_G)
	e7:SetRange(LOCATION_SZONE)
	e7:SetCondition(c511000119.movecon)
	e7:SetOperation(c511000119.moveop)
	c:RegisterEffect(e7)
	--copy	
	local e8=Effect.CreateEffect(c)
	e8:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e8:SetCode(EVENT_ADJUST)
	e8:SetRange(LOCATION_SZONE)	
	e8:SetOperation(c511000119.activ)
	c:RegisterEffect(e8)
end
function c511000119.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return true end
	if c:IsLocation(LOCATION_SZONE) and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185) 
		and Duel.SelectYesNo(tp,aux.Stringid(61965407,0)) then
		e:SetCategory(CATEGORY_EQUIP)
		e:SetProperty(EFFECT_FLAG_CARD_TARGET)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
		e:SetOperation(c511000119.operation)
	else
		e:SetCategory(0)
		e:SetProperty(0)
		e:SetOperation(nil)
	end
end
function c511000119.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsFaceup() and tc:IsRelateToEffect(e) then
		Duel.Equip(tp,c,tc)
		--equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		--end
		local e2=Effect.CreateEffect(c)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_IMMEDIATELY_APPLY)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetRange(LOCATION_FZONE)
		e2:SetCountLimit(1)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetOperation(c511000119.op)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e2)
		c:RegisterFlagEffect(511000118,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1)
	end
end
function c511000119.op(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoDeck(c,nil,-2,REASON_EFFECT)
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
end
function c511000119.accon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Card.IsCode,1,nil,31829185)
end
function c511000119.actg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	if chk==0 then return te and te:IsActivatable(tp) end
	e:SetType(EFFECT_TYPE_ACTIVATE)
	local fc=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
	if fc then
		Duel.SendtoGrave(fc,REASON_RULE)
		Duel.BreakEffect()
	end
	Duel.MoveToField(c,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	c:CreateEffectRelation(e)
	c511000119.target(e,tp,eg,ep,ev,re,r,rp,1,nil)
end
function c511000119.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseSingleEvent(e:GetHandler(),511000119,e,0,tp,tp,0)
end
function c511000119.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
end
function c511000119.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsFaceup() end
	if chk==0 then return Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_MZONE,1,nil) 
		and c:IsLocation(LOCATION_SZONE) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c511000119.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetEquipTarget()
	return tc and Duel.GetAttacker()==tc and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185)
end
function c511000119.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local a=Duel.GetAttacker()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,a:GetAttack())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,a:GetAttack())
end
function c511000119.atkop(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local tc=e:GetHandler():GetEquipTarget()
	if not a or not tc or a~=tc then return end
	Duel.NegateAttack()
	local atk=a:GetAttack()
	local val=Duel.Recover(tp,atk,REASON_EFFECT)
	Duel.Damage(1-tp,val,REASON_EFFECT)
end
function c511000119.mtcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185) 
		and e:GetHandler():GetFlagEffect(511000118)==0
end
function c511000119.mtop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.CheckReleaseGroup(tp,nil,1,nil) and Duel.SelectYesNo(tp,aux.Stringid(511000119,0)) then
		local sg=Duel.SelectReleaseGroup(tp,nil,1,1,nil)
		Duel.Release(sg,REASON_COST)
	else
		Duel.Destroy(e:GetHandler(),REASON_RULE)
	end
end
function c511000119.mvfilter(c,tp)
	if c:IsFacedown() or not c:IsCode(31893528,67287533,94772232,30170981) then return false end
	if c:IsLocation(LOCATION_MZONE) then
		return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
	else
		return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	end
end
function c511000119.movecon(e,c,og)
	if c==nil then return true end
	return Duel.IsExistingMatchingCard(c511000119.mvfilter,c:GetControler(),LOCATION_ONFIELD,0,1,nil,c:GetControler())
end
function c511000119.moveop(e,tp,eg,ep,ev,re,r,rp,c,og)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOFIELD)
	local tc=Duel.SelectMatchingCard(tp,c511000119.mvfilter,tp,LOCATION_ONFIELD,0,1,1,nil):GetFirst()
	if tc then
		if tc:IsLocation(LOCATION_MZONE) then
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
		else
			Duel.MoveToField(tc,tp,tp,LOCATION_MZONE,POS_FACEUP,true)
			--immune
			local e4=Effect.CreateEffect(c)
			e4:SetType(EFFECT_TYPE_SINGLE)
			e4:SetCode(EFFECT_IMMUNE_EFFECT)
			e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e4:SetRange(LOCATION_MZONE)
			e4:SetValue(c511000119.efilter)
			e4:SetReset(RESET_EVENT+0x47c0000)
			tc:RegisterEffect(e4,true)
			--cannot be battle target
			local e2=Effect.CreateEffect(c)
			e2:SetType(EFFECT_TYPE_SINGLE)
			e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
			e2:SetRange(LOCATION_MZONE)
			e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
			e2:SetValue(aux.imval1)
			e2:SetReset(RESET_EVENT+0x47c0000)
			tc:RegisterEffect(e2,true)
			--Direct attack
			local e3=Effect.CreateEffect(c)
			e3:SetType(EFFECT_TYPE_FIELD)
			e3:SetCode(EFFECT_DIRECT_ATTACK)
			e3:SetRange(LOCATION_MZONE)
			e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
			e3:SetTarget(c511000119.dirtg)
			e3:SetReset(RESET_EVENT+0x47c0000)
			tc:RegisterEffect(e3,true)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_CANNOT_ATTACK)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetReset(RESET_EVENT+0x47c0000)
			tc:RegisterEffect(e1,true)
			tc:RegisterFlagEffect(511000119,RESET_EVENT+0x1fe0000,0,1)
		end
	end
	return
end
function c511000119.efilter(e,te)
	local tc=te:GetOwner()
	return tc~=e:GetOwner() and not tc:IsCode(94212438)
end
function c511000119.dirfil(c)
	return c:GetFlagEffect(511000119)==0
end
function c511000119.dirtg(e,c)
	return not Duel.IsExistingMatchingCard(c511000119.dirfil,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
function c511000119.filter(c)
	return (c:GetType()==TYPE_SPELL or c:IsType(TYPE_QUICKPLAY)) and c:GetActivateEffect() 
		and c:GetFlagEffect(511000120)==0
end
function c511000119.activ(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c511000119.filter,tp,LOCATION_HAND,0,nil)
	local tc=g:GetFirst()
	while tc do
		if tc:GetFlagEffect(511000120)==0 then
			local te=tc:GetActivateEffect()
			local e1=Effect.CreateEffect(tc)
			e1:SetCategory(te:GetCategory())
			if tc:GetType()==TYPE_SPELL then
				e1:SetType(EFFECT_TYPE_IGNITION)	
			else
				e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
				e1:SetCode(te:GetCode())
			end
			e1:SetProperty(te:GetProperty())
			e1:SetCondition(c511000119.con)
			e1:SetCost(c511000119.cos)
			e1:SetTarget(c511000119.tar)
			e1:SetOperation(c511000119.act)
			e1:SetRange(LOCATION_HAND)
			tc:RegisterEffect(e1)
			tc:RegisterFlagEffect(511000120,RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END,0,1) 	
		end
		tc=g:GetNext()
	end		
end
function c511000119.con(e,tp,eg,ep,ev,re,r,rp)
	local te=e:GetHandler():GetActivateEffect()
	local condition=te:GetCondition()
	return (not condition or condition(e,tp,eg,ep,ev,re,r,rp)) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.GetLocationCount(tp,LOCATION_SZONE)<=0
end
function c511000119.cos(e,tp,eg,ep,ev,re,r,rp,chk)
	local te=e:GetHandler():GetActivateEffect()
	local co=te:GetCost()
	if chk==0 then return not co or co(e,tp,eg,ep,ev,re,r,rp,0) end
	if co then co(e,tp,eg,ep,ev,re,r,rp,1) end
end
function c511000119.tar(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local te=c:GetActivateEffect()
	local tg=te:GetTarget()
	local op=te:GetOperation()
	if chk==0 then return (not tg or tg(e,tp,eg,ep,ev,re,r,rp,0)) and Duel.GetTurnPlayer()==tp 
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,nil,31829185) end
	e:SetType(EFFECT_TYPE_ACTIVATE)
	Duel.MoveToField(c,tp,tp,LOCATION_MZONE,POS_FACEUP_ATTACK,true)
	c:CreateEffectRelation(e)
	if tg then tg(e,tp,eg,ep,ev,re,r,rp,1,nil) end
	e:SetOperation(op)
end
