--Infernity Des Gunman
function c513000108.initial_effect(c)
	--Negate Damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511000035,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_GRAVE)
	e1:SetCondition(c513000108.con)
	e1:SetCost(c513000108.cost)
	e1:SetOperation(c513000108.op)
	c:RegisterEffect(e1)
	if not c513000108.global_check then
		c513000108.global_check=true
		c513000108[0]=0
		c513000108[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_DAMAGE)
		ge1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
		ge1:SetOperation(c513000108.checkop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c513000108.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c513000108.con(e,tp,eg,ep,ev,re,r,rp)
	if ep==tp or Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 then return false end
	local e1=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_DAMAGE)
	local e2=Duel.IsPlayerAffectedByEffect(tp,EFFECT_REVERSE_RECOVER)
	local rd=e1 and not e2
	local rr=not e1 and e2
	local ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_DAMAGE)
	if ex and (cp==tp or cp==PLAYER_ALL) and not rd and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE) then 
		e:SetLabel(cv)
		return true 
	end
	ex,cg,ct,cp,cv=Duel.GetOperationInfo(ev,CATEGORY_RECOVER)
	if ex and (cp==tp or cp==PLAYER_ALL) and rr and not Duel.IsPlayerAffectedByEffect(tp,EFFECT_NO_EFFECT_DAMAGE) then
		e:SetLabel(cv)
		return true
	end
	return false
end
function c513000108.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c513000108.op(e,tp,eg,ep,ev,re,r,rp)
	local val=e:GetLabel()
	local cid=Duel.GetChainInfo(ev,CHAININFO_CHAIN_ID)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(cid)
	e1:SetValue(c513000108.refcon)
	e1:SetReset(RESET_CHAIN)
	Duel.RegisterEffect(e1,tp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 and c513000108[tp]>0 and Duel.SelectYesNo(tp,aux.Stringid(39910367,1)) then
		Duel.ConfirmDecktop(tp,1)
		local g=Duel.GetDecktopGroup(tp,1)
		local tc=g:GetFirst()
		if tc:IsType(TYPE_MONSTER) then
			Duel.Damage(1-tp,c513000108[tp]+val,REASON_EFFECT)
		else
			Duel.Damage(tp,c513000108[tp],REASON_EFFECT)
		end
		Duel.ShuffleDeck(tp,REASON_EFFECT)
	else
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CHANGE_DAMAGE)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(1,0)
		e2:SetValue(c513000108.damval)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
		local e3=e2:Clone()
		e3:SetCode(EFFECT_NO_EFFECT_DAMAGE)
		e3:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e3,tp)
	end
end
function c513000108.refcon(e,re,val,r,rp,rc)
	local cc=Duel.GetCurrentChain()
	if cc==0 or bit.band(r,REASON_EFFECT)==0 then return end
	local cid=Duel.GetChainInfo(0,CHAININFO_CHAIN_ID)
	if cid==e:GetLabel() then return 0
	else return val end
end
function c513000108.damval(e,re,val,r,rp,rc)
	if bit.band(r,REASON_EFFECT)~=0 then return 0
	else return val end
end
function c513000108.checkop(e,tp,eg,ep,ev,re,r,rp)
	if bit.band(r,REASON_EFFECT)>0 then
		c513000108[ep]=c513000108[ep]+ev
	end
end
function c513000108.clear(e,tp,eg,ep,ev,re,r,rp)
	c513000108[0]=0
	c513000108[1]=0
end
