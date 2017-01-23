--Shining Sly
function c511001495.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetCondition(c511001495.atcon)
	e1:SetValue(aux.imval1)
	c:RegisterEffect(e1)
	--Negate Damage
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c511001495.con)
	e2:SetCost(c511001495.cost)
	e2:SetOperation(c511001495.op)
	c:RegisterEffect(e2)
end
function c511001495.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
end
function c511001495.atcon(e)
	local c=e:GetHandler()
	return Duel.IsExistingMatchingCard(c511001495.filter,c:GetControler(),LOCATION_MZONE,LOCATION_MZONE,1,c)
end
function c511001495.con(e,tp,eg,ep,ev,re,r,rp)
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	e:SetLabel(cp)
	if ex and (cp==tp or cp==1-tp) then return true end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	e:SetLabel(cp)
	return ex and ((cp==tp and Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)) 
		or (cp==1-tp and Duel.IsPlayerAffectedByEffect(1-tp,EFFECT_REVERSE_RECOVER)))
end
function c511001495.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local cp=e:GetLabel()
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsReleasable,cp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectMatchingCard(tp,Card.IsReleasable,cp,LOCATION_MZONE,0,1,1,nil)
	Duel.Release(g,REASON_COST)
end
function c511001495.op(e,tp,eg,ep,ev,re,r,rp,val,r,rc)
	local cp=e:GetLabel()
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	if cp==tp then
		e1:SetTargetRange(1,0)
	else
		e1:SetTargetRange(0,1)
	end
	e1:SetLabel(cid)
	e1:SetValue(c511001495.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
end
function c511001495.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then e:SetLabel(val) return 0
	else return val end
end
