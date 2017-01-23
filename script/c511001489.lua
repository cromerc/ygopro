--The Legendary Fisherman III
function c511001489.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND+LOCATION_GRAVE)
	e1:SetCondition(c511001489.hspcon)
	e1:SetOperation(c511001489.hspop)
	e1:SetValue(SUMMON_TYPE_SPECIAL+1)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511001489,0))
	e2:SetCategory(CATEGORY_REMOVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c511001489.bantg)
	e2:SetOperation(c511001489.banop)
	c:RegisterEffect(e2)
	--Double Damage
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e3:SetCode(EVENT_CHAINING)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCondition(c511001489.con)
	e3:SetCost(c511001489.cost)
	e3:SetOperation(c511001489.op)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--indes
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCondition(c511001489.econ)
	e4:SetValue(1)
	c:RegisterEffect(e4)
end
function c511001489.hspcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1
		and Duel.CheckReleaseGroup(c:GetControler(),Card.IsCode,1,nil,3643300)
end
function c511001489.hspop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(tp,Card.IsCode,1,1,nil,3643300)
	Duel.Release(g,REASON_COST)
end
function c511001489.bantg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,nil)
		and e:GetHandler():GetSummonType()==SUMMON_TYPE_SPECIAL+1 end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,0,0)
end
function c511001489.banop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,0,LOCATION_MZONE,1,5,nil)
	if g:GetCount()>0 then
		Duel.HintSelection(g)
		if Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_TEMPORARY)>0 then
			g=g:Filter(Card.IsLocation,nil,LOCATION_REMOVED)
			g:KeepAlive()
			local tc=g:GetFirst()
			while tc do
				tc:RegisterFlagEffect(511001489,RESET_EVENT+0x1fe0000,0,1)
				tc=g:GetNext()
			end
			e:SetLabelObject(g)
		end
	end
end
function c511001489.con(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp~=tp or cp==PLAYER_ALL) then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	return ex and (cp~=tp or cp==PLAYER_ALL) and Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_REVERSE_RECOVER)
end
function c511001489.retfilter(c)
	return c:GetFlagEffect(511001489)>0 and c:IsLocation(LOCATION_REMOVED)
end
function c511001489.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject():GetLabelObject()
	local sg=g:Filter(c511001489.retfilter,nil)
	if chk==0 then return sg:GetCount()>0 and Duel.GetLocationCount(1-tp,LOCATION_MZONE)>=sg:GetCount() end
	local tc=sg:GetFirst()
	while tc do
		Duel.ReturnToField(tc)
		tc=sg:GetNext()
	end
end
function c511001489.op(e,tp,eg,ep,ev,re,r,rp,val,r,rc)
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CHANGE_DAMAGE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(0,1)
	e2:SetLabel(cid)
	e2:SetValue(c511001489.damop)
	e2:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e2,tp)
end
function c511001489.damop(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	return val*2
end
function c511001489.ffilter(c)
	return c:IsFaceup() and c:IsCode(22702055)
end
function c511001489.econ(e)
	return Duel.IsExistingMatchingCard(c511001489.ffilter,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(22702055)
end
