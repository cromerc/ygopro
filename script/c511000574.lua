--Dark Magician (DM)
--Scripted by edo9300
function c511000574.initial_effect(c)
	--double activation
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(51100567,12))
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_PZONE+LOCATION_MZONE)
	e1:SetCost(c511000574.cost)
	e1:SetCondition(c511000574.condition)
	e1:SetTarget(c511000574.target)
	e1:SetOperation(c511000574.activate)
	c:RegisterEffect(e1)
	if not c511000574.global_check then
		c511000574.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_ADJUST)
		ge1:SetCountLimit(1)
		ge1:SetProperty(EFFECT_FLAG_NO_TURN_RESET)
		ge1:SetOperation(c511000574.chk)
		Duel.RegisterEffect(ge1,0)
	end
end
c511000574.dm=true
function c511000574.chk(e,tp,eg,ep,ev,re,r,rp)
	Duel.CreateToken(tp,300)
	Duel.CreateToken(1-tp,300)
end
function c511000574.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,1000) end
	Duel.PayLPCost(tp,1000)
end
function c511000574.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==ep and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and e:GetHandler():GetFlagEffect(300)>0
end
function c511000574.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local tc=re:GetHandler()
	e:SetLabelObject(tc)
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	if bit.band(tpe,TYPE_FIELD)~=0 then
		local of=Duel.GetFieldCard(1-tp,LOCATION_SZONE,5)
		if of then Duel.Destroy(of,REASON_RULE) end
		of=Duel.GetFieldCard(tp,LOCATION_SZONE,5)
		if of and Duel.Destroy(of,REASON_RULE)==0 then Duel.SendtoGrave(tc,REASON_RULE) end
	end
	Duel.Hint(HINT_CARD,0,tc:GetCode())
	tc:CreateEffectRelation(te)
	if bit.band(tpe,TYPE_EQUIP+TYPE_CONTINUOUS+TYPE_FIELD)==0 then
		tc:CancelToGrave(false)
	end
	if co then co(te,tp,eg,ep,ev,re,r,rp,1) end
	if tg then tg(te,tp,eg,ep,ev,re,r,rp,1) end
	Duel.BreakEffect()
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if g then
		local etc=g:GetFirst()
		while etc do
			etc:CreateEffectRelation(te)
			etc=g:GetNext()
		end
	end
end
function c511000574.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local op=te:GetOperation()
	if op then op(te,tp,eg,ep,ev,re,r,rp) end
	tc:ReleaseEffectRelation(te)
	if etc then	
		etc=g:GetFirst()
		while etc do
			etc:ReleaseEffectRelation(te)
			etc=g:GetNext()
		end
	end
end
