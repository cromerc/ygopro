--Synchron Keeper
function c511001440.initial_effect(c)
	--Negate Damage
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c511001440.con)
	e1:SetCost(c511001440.cost)
	e1:SetTarget(c511001440.tg)
	e1:SetOperation(c511001440.op)
	c:RegisterEffect(e1)
end
function c511001440.con(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainDisablable(ev) then return false end
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and (cp==tp or cp==PLAYER_ALL) and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
end
function c511001440.cfilter(c,e,tp,clv)
	local lv=c:GetLevel()
	return c:IsAbleToRemoveAsCost() and lv>0 and c:IsType(TYPE_TUNER) 
		 and Duel.IsExistingMatchingCard(c511001440.spfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,lv+clv)
end
function c511001440.spfilter(c,e,tp,lv)
	return c:IsType(TYPE_SYNCHRO) and c:GetLevel()==lv and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_SYNCHRO,tp,false,false)
end
function c511001440.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToRemoveAsCost() 
		and Duel.IsExistingMatchingCard(c511001440.cfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp,c:GetLevel()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c511001440.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c:GetLevel())
	g:AddCard(c)
	g:KeepAlive()
	e:SetLabelObject(g)
	e:SetLabel(g:GetSum(Card.GetLevel))
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c511001440.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)
end
function c511001440.op(e,tp,eg,ep,ev,re,r,rp,val,r,rc)
	Duel.NegateEffect(ev)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c511001440.spfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,e:GetLabel())
	local tc=g:GetFirst()
	if tc then
		tc:SetMaterial(e:GetLabelObject())
		Duel.SpecialSummon(tc,SUMMON_TYPE_SYNCHRO,tp,tp,false,false,POS_FACEUP)
		tc:CompleteProcedure()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2,true)
	end
end
