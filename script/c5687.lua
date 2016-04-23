--慧眼の魔術師
function c5687.initial_effect(c)
	--pendulum summon
	aux.AddPendulumProcedure(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5687,0))
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetTarget(c5687.destg)
	e2:SetOperation(c5687.desop)
	c:RegisterEffect(e2)
	--pscale
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(5687,1))
	e3:SetCategory(CATEGORY_TOHAND)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_HAND)
	e3:SetCost(c5687.cost)
	e3:SetTarget(c5687.target)
	e3:SetOperation(c5687.operation)
	c:RegisterEffect(e3)
	if not c5687.global_check then
		c5687.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetOperation(c5687.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c5687.checkop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_SZONE,LOCATION_SZONE,nil)
	if g:GetCount()>0 then
		local sc=g:GetFirst()
		while sc do
			if (sc:GetSequence()==6 or sc:GetSequence()==7) and sc:GetFlagEffectLabel(5687)==nil then
				if sc:GetSequence()==6 then sc:RegisterFlagEffect(5687,RESET_EVENT+0x1fe0000,0,1,sc:GetLeftScale())
				else sc:RegisterFlagEffect(5687,RESET_EVENT+0x1fe0000,0,1,sc:GetRightScale()) end
			end
			sc=g:GetNext()
		end
	end
end
function c5687.pfilter(c)
	return c:IsSetCard(0x98) and not c:IsCode(5687) and c:IsType(TYPE_PENDULUM) and not c:IsForbidden()
end
function c5687.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local seq=e:GetHandler():GetSequence()
	local tc=Duel.GetFieldCard(tp,LOCATION_SZONE,13-seq)
	if chk==0 then return Duel.IsExistingMatchingCard(c5687.pfilter,tp,LOCATION_DECK,0,1,nil)
		and tc and (tc:IsSetCard(0x98) or tc:IsSetCard(0x9f)) and e:GetHandler():IsDestructable() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c5687.desop(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	if Duel.Destroy(e:GetHandler(),REASON_EFFECT)~=0 then
		local g=Duel.SelectMatchingCard(tp,c5687.pfilter,tp,LOCATION_DECK,0,1,1,nil)
		local tc=g:GetFirst()
		if tc then
			local seq=6
			if Duel.GetFieldCard(tp,LOCATION_SZONE,6)~=nil then seq=7 end
			local scale=0
			if seq==6 then scale=tc:GetLeftScale()
			else scale=tc:GetRightScale() end
			Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
			tc:RegisterFlagEffect(5687,RESET_EVENT+0x1fe0000,0,1,scale)
		end
	end
end
function c5687.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function c5687.filter(c)
	if not c:IsFaceup() and not (c:GetSequence()==6 or c:GetSequence()==7) then return false end
	return (c:GetSequence()==6 and c:GetLeftScale()~=c:GetFlagEffectLabel(5687))
		or (c:GetSequence()==7 and c:GetRightScale()~=c:GetFlagEffectLabel(5687))
end
function c5687.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_SZONE) and chkc:IsControler(tp) and c5687.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c5687.filter,tp,LOCATION_SZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c5687.filter,tp,LOCATION_SZONE,0,1,1,nil)
end
function c5687.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CHANGE_LSCALE)
		e1:SetValue(tc:GetFlagEffectLabel(5687))
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CHANGE_RSCALE)
		tc:RegisterEffect(e2)
	end
end
