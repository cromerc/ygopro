--Paradox Synthesis
function c511001917.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c511001917.cost)
	e1:SetTarget(c511001917.target)
	e1:SetOperation(c511001917.activate)
	c:RegisterEffect(e1)
end
function c511001917.cfilter1(c)
	return c:IsType(TYPE_XYZ) and c:IsReleasable()
end
function c511001917.cfilter2(c,tp)
	return c:IsFaceup() and c:IsLevelAbove(5) and c:IsReleasable() 
		and Duel.IsExistingMatchingCard(Card.IsFaceup,tp,0,LOCATION_MZONE,1,c)
end
function c511001917.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	e:SetLabel(1)
	if chk==0 then return true end
end
function c511001917.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		if e:GetLabel()~=1 then return false end
		e:SetLabel(0)
		return Duel.IsExistingMatchingCard(c511001917.cfilter1,tp,LOCATION_MZONE,0,1,nil) 
			and Duel.IsExistingMatchingCard(c511001917.cfilter2,tp,0,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g2=Duel.SelectMatchingCard(tp,c511001917.cfilter2,tp,0,LOCATION_MZONE,1,1,nil,tp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g1=Duel.SelectMatchingCard(tp,c511001917.cfilter1,tp,LOCATION_MZONE,0,1,1,nil)
	g1:Merge(g2)
	local atk=g1:GetSum(Card.GetAttack)
	Duel.Release(g1,REASON_COST)
	Duel.SetTargetParam(atk)
end
function c511001917.activate(e,tp,eg,ep,ev,re,r,rp)
	local atk=Duel.GetChainInfo(0,CHAININFO_TARGET_PARAM)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectMatchingCard(tp,Card.IsFaceup,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.HintSelection(g)
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e2:SetCode(EVENT_PHASE+PHASE_END)
		e2:SetCountLimit(1)
		e2:SetLabelObject(tc)
		e2:SetCondition(c511001917.descon)
		e2:SetOperation(c511001917.desop)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		e3:SetCode(EVENT_LEAVE_FIELD)
		e3:SetLabelObject(e2)
		e3:SetOperation(c511001917.resetop)
		Duel.RegisterEffect(e3,tp)
	end
end
function c511001917.descon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetLabelObject()
end
function c511001917.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	if tc and tc:GetBattledGroupCount()>0 then
		local atk=tc:GetAttack()
		if Duel.Destroy(tc,REASON_EFFECT)>0 then
			Duel.Damage(1-tp,atk,REASON_EFFECT)
		end
		e:Reset()
	end
end
function c511001917.resetop(e,tp,eg,ep,ev,re,r,rp)
	local eff=e:GetLabelObject()
	if not eff then
		e:Reset()
		return
	end
	local tc=eff:GetLabelObject()
	if not tc or eg:IsContains(tc) then
		e:GetLabelObject():Reset()
		e:Reset()
	end
end
