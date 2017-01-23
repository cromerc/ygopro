--Intervention of Fate
function c511000600.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000600,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_HAND)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511000600.con)
	e1:SetCost(c511000600.cost)
	e1:SetTarget(c511000600.tg)
	e1:SetOperation(c511000600.op)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_FLIP_SUMMON_SUCCESS)
	c:RegisterEffect(e2)
	local e3=e1:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	c:RegisterEffect(e3)
end
function c511000600.con(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c511000600.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c511000600.filter(c)
	return c:GetType()==TYPE_SPELL and c:CheckActivateEffect(false,false,false)~=nil
end
function c511000600.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0 and Duel.IsExistingMatchingCard(c511000600.filter,tp,LOCATION_HAND,0,1,nil) end
end
function c511000600.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.SelectMatchingCard(tp,c511000600.filter,tp,LOCATION_HAND,0,1,1,nil):GetFirst()
	local tpe=tc:GetType()
	local te=tc:GetActivateEffect()
	local tg=te:GetTarget()
	local co=te:GetCost()
	local op=te:GetOperation()
	e:SetCategory(te:GetCategory())
	e:SetProperty(te:GetProperty())
	Duel.ClearTargetCard()
	Duel.MoveToField(tc,tp,tp,LOCATION_SZONE,POS_FACEUP,true)
	Duel.Hint(HINT_CARD,0,tc:GetCode())
	tc:CreateEffectRelation(te)
	tc:CancelToGrave(false)
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
